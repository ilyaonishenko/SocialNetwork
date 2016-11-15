package security;


import model.User;

import javax.servlet.http.HttpSession;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Optional;

public interface StringEncryptUtil {

    String ALGORITHM = "MD5";
//    MessageDigest ENCRYPTOR = ExceptionalFunction.getOrThrowUnchecked(MessageDigest::getInstance, ALGORITHM);



    static String encrypt(String s) throws NoSuchAlgorithmException {


        MessageDigest ENCRYPTOR = MessageDigest.getInstance(ALGORITHM);

        ENCRYPTOR.reset();

        byte[] bs = ENCRYPTOR.digest(s.getBytes());

        StringBuilder stringBuilder = new StringBuilder();

        //hex encode the digest
        for (byte b : bs) {
            String hexVal = Integer.toHexString(0xFF & b);
            if (hexVal.length() == 1)
                stringBuilder.append("0");
            stringBuilder.append(hexVal);
        }

        return stringBuilder.toString();
    }

    static Optional<User> getSUserOpt(HttpSession httpSession) {
        Optional<User> sUserOpt = Optional.ofNullable(httpSession)
                .map(session -> (User) session.getAttribute("sUser"));

        return sUserOpt;
    }
}
