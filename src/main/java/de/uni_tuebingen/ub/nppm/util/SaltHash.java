package de.uni_tuebingen.ub.nppm.util;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.util.Base64;

//source: https://www.youtube.com/watch?v=hNKfEwTO3AQ
public class SaltHash {
    public static String GenerateHash(String data, String algorithm, byte[] salt) throws NoSuchAlgorithmException {
        MessageDigest digest = MessageDigest.getInstance(algorithm);
        digest.reset();
        digest.update(salt);
        byte[] hash = digest.digest(data.getBytes());
        return BytesToBase64String(hash);
    }

    public static String BytesToBase64String(byte[] bytes) {
        return Base64.getEncoder().encodeToString(bytes);
    }

    public static byte[] Base64StringToBytes(String string) {
        return Base64.getDecoder().decode(string);
    }

    public static byte[] GenerateRandomSalt(int length) {
        byte[] salt = new byte[length];
        SecureRandom random = new SecureRandom();
        random.nextBytes(salt);
        return salt;
    }
}
