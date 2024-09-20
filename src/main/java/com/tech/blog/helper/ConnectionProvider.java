package com.tech.blog.helper;

import java.sql.Connection;
import java.sql.DriverManager;

public class ConnectionProvider {
	private static Connection con;

	public static Connection getConnection() {
		try {
			if (con == null) {
				// Driver class load
				Class.forName("com.mysql.cj.jdbc.Driver");
				// Getting connection object
				con = DriverManager.getConnection("jdbc:mysql:///techblog", "root", "833910s");
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return con;
	}
}
