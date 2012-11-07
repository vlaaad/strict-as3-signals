package util;

import freemarker.template.Configuration;
import freemarker.template.DefaultObjectWrapper;
import freemarker.template.Template;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.io.Writer;
import java.util.HashMap;

/**
 * Author: Vlaaad
 * Date: 11.08.12
 */
public class GenerateUtil {
    private static Configuration cfg;

    public static void init(String templatePath) throws IOException {
        cfg = new Configuration();
        cfg.setDirectoryForTemplateLoading(new File(templatePath));
        cfg.setObjectWrapper(new DefaultObjectWrapper());
    }

    public static void generate(String outputFileName, String templateName, HashMap root) {
        Template template = null;
        try {
            template = cfg.getTemplate(templateName);
        } catch (IOException e) {
            e.printStackTrace();
            System.exit(-1);
        }
        File output = new File(outputFileName);
        generate(output, template, root);
    }

    private static void generate(File output, Template template, HashMap root) {
        try {
            mkdirsIfNeeded(output);
            logGeneratedFile(output);
            Writer fileWriter = new FileWriter(output);
            template.process(root, fileWriter);
            fileWriter.flush();
            fileWriter.close();
        } catch (Exception ignored) {
            ignored.printStackTrace();
            System.exit(-1);
        }
    }

    private static void mkdirsIfNeeded(File output) {
        String[] dirs = output.getPath().split("\\\\");
        if (dirs.length > 1) {
            String folders = "";
            for (int i = 0; i < dirs.length - 1; i++) {
                folders += dirs[i] + "\\";
            }
            File folder = new File(folders);
            if (!folder.exists()) {
                boolean dirsCreated = folder.mkdirs();
                if (!dirsCreated) {
                    log("Failed to create directories " + folder.getPath());
                    System.exit(-1);
                }
            }
        }
    }

    private static void logGeneratedFile(File output) throws Exception {
        if (!output.exists()) {
            boolean fileCreateResult = output.createNewFile();
            if (fileCreateResult) {
                System.out.println("Creating " + output.getPath());
            } else {
                System.out.println("Failed to create " + output.getPath());
            }
        } else {
            System.out.println("Updating " + output.getPath());
        }
    }

    private static void log(String message) {
        System.out.println(message);
    }
}
