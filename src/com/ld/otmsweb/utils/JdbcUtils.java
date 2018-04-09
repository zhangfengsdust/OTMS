package com.ld.otmsweb.utils;

import java.sql.Connection;
import java.sql.SQLException;

import javax.sql.DataSource;

import com.mchange.v2.c3p0.ComboPooledDataSource;

public class JdbcUtils {
	
	private static DataSource dataSource = null;
	
	static{
		dataSource = new ComboPooledDataSource("c3p0");
	}
	
    public static Connection getConnection() throws SQLException{
    	return dataSource.getConnection();
    }
    
    public static void releaseConnection(Connection connection){
    	try {
    		if(connection != null){
    			connection.close();
    		}
		} catch (Exception e) {
            e.printStackTrace();
		}
    }
}
