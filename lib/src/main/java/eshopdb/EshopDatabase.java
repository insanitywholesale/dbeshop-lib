package eshopdb;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;

public class EshopDatabase {

    private String driverClassName = "org.postgresql.Driver";
    private String url = "jdbc:postgresql://localhost:5432/tester";
    private String username = "tester";
    private String passwd = "Apasswd";
    private Connection dbConnection = null;
    private Statement statement = null;
    private final boolean isWindows = System.getProperty("os.name").startsWith("Windows");
    private String[] sqlFileNames = {"eshop-tables.sql", "eshop-audittables.sql", "eshop-audittriggers.sql", "eshop-operations.sql"};

    public EshopDatabase() {
        try {
            //Load database driver
            Class.forName(driverClassName);
        } catch (ClassNotFoundException ex) {
            System.err.println("driver load exception: " + ex);
			return;
        }
        try {
            //Establish connection
            dbConnection = DriverManager.getConnection(url, username, passwd);
            //Make database connection globally available
            statement = dbConnection.createStatement();
        } catch (SQLException ex) {
            System.err.println("Error when trying to connect to database at " + url + ": " + ex);
			return;
        }


        for (String sqlFileName : sqlFileNames) {
            runSQLFromFile(sqlFileName);
            try {
                Thread.sleep(1000);
            } catch (InterruptedException ex) {
                System.err.println("Error when sleeping: " + ex);
            }
        }
    }

    private void runSQLFromFile(String fileName) {
		if (fileName.equals("")) {
			return;
		}
        String query;
        try {
            String sql;
            if (isWindows) {
                sql = ((this.getClass()).getResource(fileName)).getPath().substring(1);
            } else {
                sql = (this.getClass().getResource("/" + fileName)).getPath();
            }
            Path path = Path.of(sql);
            query = Files.readString(path);
        } catch (NullPointerException ex) {
            System.err.println("Error trying to load " + fileName + ": " + ex);
			return;
        } catch (IOException ex) {
            System.err.println("Error trying to load " + fileName + ": " + ex);
            return;
		}
        try {
            //Create base tables
            statement.execute(query);
        } catch (SQLException ex) {
            System.err.println("Error when running SQL in " + fileName + ": " + ex);
        }
    }

    //TODO: switch to different logging using below resources
    //import java.util.logging.Level;
    //import java.util.logging.Logger;
    //Logger.getLogger(EshopDatabase.class.getName()).log(Level.SEVERE, null, ex);
}
