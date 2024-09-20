package com.tech.blog.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.tech.blog.entities.Users;

public class UsersDao {

	private Connection con;
	private String insertQuery = "INSERT INTO users(name, email, password, gender) VALUES(?, ?, ?, ?)";
	private String selectQuery = "SELECT * FROM users WHERE email=? AND password=?";
	private String selectUserQuery = "SELECT * FROM users WHERE id=?";
	private String updateQuery = "UPDATE users SET name=?, email=?, password=?, gender=?, profile=? WHERE ID=?";

	public UsersDao(Connection con) {
		this.con = con;
	}
	
	//Method to insert user to the database
	public boolean saveUser(Users user) {
		boolean flag = false;
		try(PreparedStatement ps = con.prepareStatement(insertQuery)) {
			ps.setString(1, user.getName());
			ps.setString(2, user.getEmail());
			ps.setString(3, user.getPassword());
			ps.setString(4, user.getGender());
			
			ps.executeUpdate();
			flag = true;
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return flag;
	}//saveUser method
	
	//Fetch user by email & password
	public Users fetchUserByEmailAndPassword(String email, String password) {
		Users user = null;
		try(PreparedStatement ps = con.prepareStatement(selectQuery)){
			ps.setString(1, email);
			ps.setString(2, password);
			
			try(ResultSet rs = ps.executeQuery()){
				if(rs.next()) {
					user = new Users();
					user.setId(rs.getInt(1));
					user.setName(rs.getString(2));
					user.setEmail(rs.getString(3));
					user.setPassword(rs.getString(4));
					user.setGender(rs.getString(5));
					user.setRedg_date(rs.getTimestamp(6));
					user.setProfile(rs.getString(7));
					
					//OR
					/*user.setId(rs.getInt("id"));
					user.setName(rs.getString("name"));
					user.setEmail(rs.getString("email"));
					user.setPassword(rs.getString("password"));
					user.setGender(rs.getString("gender"));
					user.setRedg_date(rs.getTimestamp("redg_date"));*/
				}
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return user;
	}//Fetch method
	
	//Fetch user by user id
	public Users fetchUserByUserId(int uid) {
		Users user = null;
		try(PreparedStatement ps = con.prepareStatement(selectUserQuery)){
			ps.setInt(1, uid);
			
			try(ResultSet rs = ps.executeQuery()){
				if(rs.next()) {
					user = new Users();
					user.setId(rs.getInt(1));
					user.setName(rs.getString(2));
					user.setEmail(rs.getString(3));
					user.setPassword(rs.getString(4));
					user.setGender(rs.getString(5));
					user.setRedg_date(rs.getTimestamp(6));
					user.setProfile(rs.getString(7));
				}
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return user;
	}//Fetch user method
		
	
	//Update method for edit user
	public boolean updateUser(Users user) {
		boolean status = false;
		try(PreparedStatement ps = con.prepareStatement(updateQuery)){
			
			ps.setString(1, user.getName());
			ps.setString(2, user.getEmail());
			ps.setString(3, user.getPassword());
			ps.setString(4, user.getGender());
			ps.setString(5, user.getProfile());
			ps.setInt(6, user.getId());
			
			ps.executeUpdate();
			
			status = true;
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return status;
	}
}
