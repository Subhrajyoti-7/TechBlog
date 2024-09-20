package com.tech.blog.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import com.tech.blog.entities.Categories;
import com.tech.blog.entities.Posts;

public class PostDao {
	private Connection con;
	private String fetchQuery = "SELECT * FROM categories";
	private String saveQuery = "INSERT INTO posts(ptitle, pcontent, pcode, ppic, cid, uid) VALUES(?, ?, ?, ?, ?, ?)";
	private String fetchAllPosts = "SELECT * FROM posts order by pid desc";
	private String fetchPostsByCid = "SELECT * FROM posts WHERE cid=? order by pid desc";
	private String fetchPostByPostId = "SELECT * FROM posts WHERE pid=?";
	
	public PostDao(Connection con) {
		super();
		this.con = con;
	}

	//Fetching all categories
	public List<Categories> fetchAllCategories(){
		List<Categories> list = new ArrayList<Categories>();
		
		try(Statement st = con.createStatement();
			ResultSet rs = st.executeQuery(fetchQuery)){
			
			while(rs.next()) {
				int cid = rs.getInt("cid");
				String name = rs.getString("name");
				String description = rs.getString("description");
				
				Categories cat = new Categories(cid, name, description);
				list.add(cat);				
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}

	//Save post
	public boolean savePost(Posts post) {
		boolean flag = false;
		try(PreparedStatement ps = con.prepareStatement(saveQuery)){
			ps.setString(1, post.getPtitle());
			ps.setString(2, post.getPcontent());
			ps.setString(3, post.getPcode());
			ps.setString(4, post.getPpic());
			ps.setInt(5, post.getCid());
			ps.setInt(6, post.getUid());
			
			ps.executeUpdate();
			flag = true;
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return flag;
	}

	//Get all posts
	public List<Posts> getAllPosts(){
		List<Posts> posts = new ArrayList<>();
		try(Statement st = con.createStatement();
			ResultSet rs = st.executeQuery(fetchAllPosts)){
			while(rs.next()) {
				int pid = rs.getInt("pid");
				String ptitle = rs.getString("ptitle");
				String pcontent = rs.getString("pcontent");
				String pcode = rs.getString("pcode");
				String ppic = rs.getString("ppic");
				Timestamp pdate = rs.getTimestamp("pdate");
				int cid = rs.getInt("cid");
				int uid = rs.getInt("uid");
				Posts p = new Posts(pid, ptitle, pcontent, pcode, ppic, pdate, cid, uid);			
				posts.add(p);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return posts;
	}
	
	//Get posts by category
	public List<Posts> getPostsByCatId(int catId){
		List<Posts> posts = new ArrayList<>();
		try(PreparedStatement ps = con.prepareStatement(fetchPostsByCid)){
			
			ps.setInt(1, catId);
			try(ResultSet rs = ps.executeQuery()){
				while(rs.next()) {
					int pid = rs.getInt("pid");
					String ptitle = rs.getString("ptitle");
					String pcontent = rs.getString("pcontent");
					String pcode = rs.getString("pcode");
					String ppic = rs.getString("ppic");
					Timestamp pdate = rs.getTimestamp("pdate");
					int cid = rs.getInt("cid");
					int uid = rs.getInt("uid");
					Posts p = new Posts(pid, ptitle, pcontent, pcode, ppic, pdate, cid, uid);			
					posts.add(p);
				}
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return posts;
	}

	//Get single post by post id
	public Posts getPostByPostId(int pid) {
		Posts p = new Posts();
		try(PreparedStatement ps = con.prepareStatement(fetchPostByPostId)){
			ps.setInt(1, pid);
			try(ResultSet rs = ps.executeQuery()){
				if(rs.next()) {
					p.setPid(rs.getInt("pid"));
					p.setPtitle(rs.getString("ptitle"));
					p.setPcontent(rs.getString("pcontent"));
					p.setPcode(rs.getString("pcode"));
					p.setPpic(rs.getString("ppic"));
					p.setPdate(rs.getTimestamp("pdate"));
					p.setCid(rs.getInt("cid"));
					p.setUid(rs.getInt("uid"));
				}
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return p;
	}
}
