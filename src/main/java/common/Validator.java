package common;

import java.util.regex.Pattern;

/**
 * Created by wopqw on 03.12.16.
 */
public class Validator {

    private static final String usernamePatternString = "^\\w{3,15}$";
    private static final Pattern usernamePattern = Pattern.compile(usernamePatternString);

    private static final String emailPatternString = "^\\w+@.+\\.\\w+$";
    private static final Pattern emailPattern = Pattern.compile(emailPatternString);

    public static boolean validateUsername(String username){
        return username != null && usernamePattern.matcher(username).matches();
    }

    public static boolean validateEmail(String email){
        return email != null && emailPattern.matcher(email).matches();
    }
}
