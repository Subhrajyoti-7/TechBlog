package com.tech.blog.entities;

import java.sql.Timestamp;

public class Posts {
	private Integer pid;
	private String ptitle;
	private String pcontent;
	private String pcode;
	private String ppic;
	private Timestamp pdate;
	private int cid;
	private int uid;
	
	//Constructors
	public Posts(Integer pid, String ptitle, String pcontent, String pcode, String ppic, Timestamp pdate, int cid, int uid) {
		super();
		this.pid = pid;
		this.ptitle = ptitle;
		this.pcontent = pcontent;
		this.pcode = pcode;
		this.ppic = ppic;
		this.pdate = pdate;
		this.cid = cid;
		this.uid = uid;
	}

	public Posts(String ptitle, String pcontent, String pcode, String ppic, int cid, int uid) {
		super();
		this.ptitle = ptitle;
		this.pcontent = pcontent;
		this.pcode = pcode;
		this.ppic = ppic;
		this.cid = cid;
		this.uid = uid;
	}

	public Posts() {
		super();
	}

	//Getters and Setters
	public Integer getPid() {
		return pid;
	}

	public void setPid(Integer pid) {
		this.pid = pid;
	}

	public String getPtitle() {
		return ptitle;
	}

	public void setPtitle(String ptitle) {
		this.ptitle = ptitle;
	}

	public String getPcontent() {
		return pcontent;
	}

	public void setPcontent(String pcontent) {
		this.pcontent = pcontent;
	}

	public String getPcode() {
		return pcode;
	}

	public void setPcode(String pcode) {
		this.pcode = pcode;
	}

	public String getPpic() {
		return ppic;
	}

	public void setPpic(String ppic) {
		this.ppic = ppic;
	}

	public Timestamp getPdate() {
		return pdate;
	}

	public void setPdate(Timestamp pdate) {
		this.pdate = pdate;
	}

	public int getCid() {
		return cid;
	}

	public void setCid(int cid) {
		this.cid = cid;
	}

	public int getUid() {
		return uid;
	}

	public void setUid(int uid) {
		this.uid = uid;
	}
	
}
