package de.uni_tuebingen.ub.nppm.util;

import java.util.*;
import java.io.*;
import java.net.URL;

// https://stackoverflow.com/questions/28327389/how-can-i-do-to-get-all-class-of-a-given-package-with-guava
public class NamespaceHelper {
    // Original name: getClassOfPackage
    static public List<Class> getClassesOfPackage(String packageName)
        throws ClassNotFoundException, IOException {

        ClassLoader classLoader = Thread.currentThread().getContextClassLoader();

        assert classLoader != null;
        String path = packageName.replace('.', '/');
        Enumeration<URL> resources = classLoader.getResources(path);
        List<File> dirs = new ArrayList<>();
        while (resources.hasMoreElements()) {
            URL resource = resources.nextElement();
            dirs.add(new File(resource.getFile()));
        }
        ArrayList<Class> classes = new ArrayList<>();
        for (File directory : dirs) {
            classes.addAll(findClasses(directory, packageName));
        }
        return classes;
    }

    private static List<Class> findClasses(File directory, String packageName)
            throws ClassNotFoundException {
        List<Class> classes = new ArrayList<>();
        if (!directory.exists()) {
            return classes;
        }
        File[] files = directory.listFiles();
        for (File file : files) {
            if (file.isDirectory()) {
                assert !file.getName().contains(".");
                classes.addAll(findClasses(file,
                        packageName + "." + file.getName()));
            } else if (file.getName().endsWith(".class")) {
                classes.add(Class.forName(packageName
                        + '.'
                        + file.getName().substring(0,
                                file.getName().length() - 6)));
            }
        }
        return classes;
    }
}
