package security;


import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

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
}
