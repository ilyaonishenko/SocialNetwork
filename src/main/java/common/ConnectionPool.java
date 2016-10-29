package common;

import lombok.SneakyThrows;
import lombok.extern.java.Log;

import java.io.FileInputStream;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Arrays;
import java.util.Properties;
import java.util.concurrent.ArrayBlockingQueue;
import java.util.concurrent.BlockingQueue;
import java.util.function.Supplier;
import java.util.stream.Collectors;

/**
 * Created by wopqw on 21.10.16.
 */
@Log
public class ConnectionPool implements AutoCloseable {

    private static BlockingQueue<Connection> freeConnections;
    private static BlockingQueue<Connection> reservedConnections;
    private volatile boolean isClosing = false;

    @SneakyThrows
    public static ConnectionPool create(String pathToConfig){

        Properties properties = new Properties();
        properties.load(new FileInputStream(pathToConfig));

        int poolSize = Integer.parseInt(getValueAndRemoveKey(properties, "poolSize"));

        return create(poolSize,getValueAndRemoveKey(properties,"driver"),
                getValueAndRemoveKey(properties,"url"));
    }

    private static ConnectionPool create(Integer poolSize, String driver, String url){

        //noinspection Duplicates
        return new ConnectionPool(poolSize, () ->{

            try {
                Class.forName(driver);
                return DriverManager.getConnection(url);
            } catch (ClassNotFoundException | SQLException e){
                e.printStackTrace();
            }
            return null;
        });

    }

    private ConnectionPool(int poolSize, Supplier<Connection> connectionSupplier) {

        freeConnections = new ArrayBlockingQueue<>(poolSize);
        reservedConnections = new ArrayBlockingQueue<>(poolSize);

        for (int i = 0; i < poolSize; i++) {
            freeConnections.add(connectionSupplier.get());
        }
    }

    @Override
    public void close() throws Exception {

        isClosing = true;

        freeConnections.forEach(connection -> {
            try {
                connection.close();
            } catch (Exception e) {
                throw new RuntimeException(e);
            }
        });
    }

    private static String getValueAndRemoveKey(Properties properties, String key) {

        return (String) properties.remove(key);
    }

    private ConnectionWrapper wrap(Connection connection) {

        //noinspection Duplicates
        return new ConnectionWrapper(connection) {
            @Override
            public void close() throws SQLException {
                if (connection.isClosed()) {
                    throw new SQLException("Connection is already closed");
                }

                if (connection.isReadOnly()) {
                    connection.setReadOnly(false);
                }

                if (reservedConnections.contains(this) && !reservedConnections.remove(this)) {
                    throw new RuntimeException("Cannot close reserved connection");
                }

                if (isClosing) {
                    connection.close();
                } else if (!freeConnections.offer(connection)) {
                    throw new RuntimeException("Cannot return connection to the pool");
                }
            }
        };
    }

    public Connection getConnection() {

        if (isClosing) {
            throw new RuntimeException("Cannot get connection from the closing pool");
        }

        //noinspection Duplicates
        try {
            Connection connection = wrap(freeConnections.take());
            reservedConnections.add(connection);
            return connection;
        } catch (InterruptedException e) {
            throw new RuntimeException(e);
        }
    }

    @SneakyThrows
    public void initDb(String pathToInit){

        try(Connection connection = getConnection()){

            Statement stat = connection.createStatement();

            Arrays.stream(
                    Files.lines(Paths.get(pathToInit))
                            .collect(Collectors.joining())
                            .split(";"))
                    .forEachOrdered(sql -> {
                        try{
                            stat.addBatch(sql);
                        } catch (SQLException e){
                            throw new RuntimeException(e);
                        }
                    });
            stat.executeBatch();
        }
    }
}
