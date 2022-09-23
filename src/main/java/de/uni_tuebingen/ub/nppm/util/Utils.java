package de.uni_tuebingen.ub.nppm.util;

public class Utils {
    public static boolean isNumeric(String str){
        try {
            Integer.parseInt(str);
        } catch (NumberFormatException numberFormatException) {
            return false;
        }
        return true;
    }
}
