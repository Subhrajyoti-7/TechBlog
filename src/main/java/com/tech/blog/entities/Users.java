package com.tech.blog.entities;

import java.sql.Timestamp;

public class Users {

	private Integer id;
	private String name;
	private String email;
	private String password;
	private String gender;
	private Timestamp redg_date;
	private String profile;
	
	//No-arg constructor
	public Users() {
		super();
	}
	
	//Required-arg constructor
	public Users(String name, String email, String password, String gender) {
		super();
		this.name = name;
		this.email = email;
		this.password = password;
		this.gender = gender;
	}
	
	//All-arg constructor
	public Users(Integer id, String name, String email, String password, String gender, Timestamp redg_date) {
		super();
		this.id = id;
		this.name = name;
		this.email = email;
		this.password = password;
		this.gender = gender;
		this.redg_date = redg_date;
	}

	//Getters and Setters
	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public Timestamp getRedg_date() {
		return redg_date;
	}

	public void setRedg_date(Timestamp redg_date) {
		this.redg_date = redg_date;
	}

	public String getProfile() {
		return profile;
	}

	public void setProfile(String profile) {
		this.profile = profile;
	}
	
}
