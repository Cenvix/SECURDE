package com.DB;
import java.sql.Connection;
import java.sql.SQLException;

import org.apache.tomcat.dbcp.dbcp.BasicDataSource;

public class DBPool {
	public final static String url = "jdbc:mysql://localhost:3306/securde";
	public final static String username = "securde";
	public final static String password = "DGOsecurde17";
	public final static String  driver = "com.mysql.jdbc.Driver";
	
	private static DBPool dbPool = null;
	private static BasicDataSource basicDataSource;
	
	private DBPool() {
		basicDataSource = new BasicDataSource();
		
		basicDataSource.setDriverClassName(driver);
		basicDataSource.setUrl(url);
		basicDataSource.setUsername(username);
		basicDataSource.setPassword(password);
	}
	
	public static DBPool getInstance() {
		if(dbPool == null) {
			dbPool = new DBPool();
		}
		
		return dbPool;
	}
	
	public Connection getConnection() {
		try {
			return basicDataSource.getConnection();
		} catch (SQLException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		
		return null;
	}
}
