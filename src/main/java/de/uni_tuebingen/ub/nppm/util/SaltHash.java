package de.uni_tuebingen.ub.nppm.util;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;

//source: https://www.youtube.com/watch?v=hNKfEwTO3AQ
public class SaltHash {

    private final char[] hexArray = "0123456789ABCDEF".toCharArray();
    private String saltString = "";

    public SaltHash() {
    }

    public String getSaltString() {
        return saltString;
    }

    public void setSaltString(String saltString) {
        this.saltString = saltString;
    }

    //Methoden
    public String generateHash(String data, String algorithm, byte[] salt) throws NoSuchAlgorithmException {

        MessageDigest digest = MessageDigest.getInstance(algorithm);
        digest.reset();
        digest.update(salt);
        byte[] hash = digest.digest(data.getBytes());
        return bytesToStringHex(hash);
    }

    public String bytesToStringHex(byte[] bytes) {
        char[] hexChars = new char[bytes.length * 2];
        for (int j = 0; j < bytes.length; j++) {
            int v = bytes[j] & 0xFF;
            hexChars[j * 2] = hexArray[v >>> 4];
            hexChars[j * 2 + 1] = hexArray[v & 0x0f];
        }
        return new String(hexChars);
    }

    //creats salt byte[] and saltString
    public byte[] createSalt() {
        byte[] salt = new byte[20];
        SecureRandom random = new SecureRandom();
        random.nextBytes(salt);

        for (int i = 0; i < salt.length; i++) {
            if (i == 0) {
                saltString += salt[i];
            } else {
                saltString += "S" + salt[i];  //"S" as byte divider (byte can be 1,2 or 3 numbers long)
            }
        }
        return salt;
    }

    public String decodeSaltHash(String password, String algorithm, String saltString) throws NoSuchAlgorithmException {
        String data = password;
        String fullString = saltString;
        String[] split = fullString.split("S");
        int bytelength = split.length;
        byte[] salt = new byte[bytelength];

        for (int i = 0; i < bytelength; i++) {
            salt[i] = Byte.parseByte(split[i]);
        }

        MessageDigest digest = MessageDigest.getInstance(algorithm);
        digest.reset();
        digest.update(salt);
        byte[] hash = digest.digest(data.getBytes());
        return bytesToStringHex(hash);
    }

}
