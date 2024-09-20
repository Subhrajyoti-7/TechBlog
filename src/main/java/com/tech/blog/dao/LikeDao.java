package com.tech.blog.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class LikeDao {
	private Connection con;
	private String likeInsertQuery = "INSERT INTO likes(pid, uid) VALUES(?, ?)";
	private String likeDeleteQuery = "DELETE FROM likes WHERE pid=? AND uid=?";
	private String likeCountQuery = "SELECT count(*) FROM likes WHERE pid=?";
	private String likeCkeckQuery = "SELECT * FROM likes WHERE pid=? AND uid=?";

	public LikeDao(Connection con) {
		super();
		this.con = con;
	}
	
	//Like insert
	public boolean saveLike(int pid, int uid) {
		boolean flag = false;
		try(PreparedStatement ps = con.prepareStatement(likeInsertQuery)){
			ps.setInt(1, pid);
			ps.setInt(2, uid);
			ps.executeUpdate();
			flag = true;
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return flag;
	}
	
	//Like count
	public int getLikeCount(int pid) {
		int count = 0;
		try(PreparedStatement ps = con.prepareStatement(likeCountQuery)){
			ps.setInt(1, pid);
			try(ResultSet rs = ps.executeQuery()){
				if(rs.next()) {
					count = rs.getInt(1);
				}
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return count;
	}
	
	//Post is liked by the User or not
	public boolean isLikedByUser(int pid, int uid) {
		boolean flag = false;
		try(PreparedStatement ps = con.prepareStatement(likeCkeckQuery)){
			ps.setInt(1, pid);
			ps.setInt(2, uid);
			try(ResultSet rs = ps.executeQuery()){
				if(rs.next()) {
					flag = true;
				}
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return flag;
	}
	
	//Delete like
	public boolean deleteLike(int pid, int uid) {
		boolean flag = false;
		try(PreparedStatement ps = con.prepareStatement(likeDeleteQuery)){
			ps.setInt(1, pid);
			ps.setInt(2, uid);
			ps.executeUpdate();
			flag = true;
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return flag;
	}
}
