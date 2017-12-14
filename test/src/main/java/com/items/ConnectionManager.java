package com.items;
import java.sql.*;
import java.sql.DriverManager;
import java.sql.SQLException;

//import com.mysql.jdbc.Connection;

public class ConnectionManager {
	private static Connection MyConn = null;
    
    
    
	/* public static java.sql.Connection MyConn = null;
	static java.sql.Connection getConnection() throws Exception {

		
        System.out.println(" database manager");
	        String url = "jdbc:mysql://localhost:8889/test";
	        String dbName = "test";
	        String driver = "com.mysql.jdbc.Driver";
	        String userName = "root";
	        String password = "root";*/
	        
		/*// Jalastic
	        String url = "jdbc:mysql://node23485-onlinepos.njs.jelastic.vps-host.net/test";
	        String dbName = "test";
	        String driver = "com.mysql.jdbc.Driver";
	        String userName = "root";
	        String password = "BPNivr47456";*/
	        
/*
		//kdpatel2424@outlook.com--
		  String url = "jdbc:mysql://us-cdbr-azure-southcentral-f.cloudapp.net:3306/";
		String dbName = "testdata1";
		String driver = "com.mysql.jdbc.Driver";
		String userName = "b6893a64d2d8f6";
		String password = "76959b7d";
		*/
		
		//kdptel2424@gmail.com Updated 11/28/2017 works perfectely
	private static String url = "jdbc:mysql://us-cdbr-azure-central-a.cloudapp.net:3306/OnlinePOS";
	private static String dbName = "test";
	private static String driver = "com.mysql.jdbc.Driver";
	private static String userName = "b84052900eb15a";
	private static String password = "326f30a3";
		
	        
	     /*   Class.forName(driver).newInstance();
	         MyConn = (Connection) DriverManager.getConnection(url, userName,password);
	         if(MyConn ==null)
	        	 System.out.println("Error");
	        return MyConn;
	    }*/
	/*private static String url = "jdbc:mysql://localhost:8889/OnlinePOS";
    private static   String dbName = "test";
    private static   String driver = "com.mysql.jdbc.Driver";
    private static   String userName = "root";
    private static   String password = "root";*/
	
	
    public static Connection getConnection() {
        try {
            Class.forName(driver);
            try {
                MyConn = DriverManager.getConnection(url, userName, password);
            } catch (SQLException ex) {
                // log an exception. fro example:
                System.out.println("Failed to create the database connection."); 
            }
        } catch (ClassNotFoundException ex) {
            // log an exception. for example:
            System.out.println("Driver not found."); 
        }
        return MyConn;
    }
	 public static void closeConnection(java.sql.Connection myConn) {

	        try {

	            MyConn.close();

	        } catch (SQLException e) {

	        }

	    }
	 
	 
}