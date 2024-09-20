package com.tech.blog.entities;

public class Categories {
	private Integer cid;
	private String name;
	private String description;
	
	//Constructors
	public Categories(Integer cid, String name, String description) {
		super();
		this.cid = cid;
		this.name = name;
		this.description = description;
	}
	public Categories(String name, String description) {
		super();
		this.name = name;
		this.description = description;
	}
	public Categories() {
		super();
	}
	
	//Getters and Setters
	public Integer getCid() {
		return cid;
	}
	public void setCid(Integer cid) {
		this.cid = cid;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}

}
