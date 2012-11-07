package util;

import org.yaml.snakeyaml.Yaml;
import sun.nio.cs.Surrogate;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.util.HashMap;

/**
 * Author: Vlaaad
 * Date: 11.08.12
 */
public class YamlUtil {
    public static HashMap<String, Object> load(String pathToYaml) {
        try {
            Object yml = new Yaml().load(new FileInputStream(pathToYaml));
            if (HashMap.class.isInstance(yml)) {
                return (HashMap<String, Object>) yml;
            } else {
                log("Wrong file loaded");
                System.exit(-1);
            }
        } catch (FileNotFoundException e) {
            log("No yaml file to load");
            e.printStackTrace();
            System.exit(-1);
        }
        return null;
    }

    private static void log(String message) {
        System.out.println(message);
    }
}
