package com.fszj.bean;

public class Menu {

	private int id;
	
	private String name;
	
	private int parentid;
	
	private String desc;
	
	private String url;
	
	private String xssx;//显示顺序

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public int getParentid() {
		return parentid;
	}

	public void setParentid(int parentid) {
		this.parentid = parentid;
	}

	public String getDesc() {
		return desc;
	}

	public void setDesc(String desc) {
		this.desc = desc;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}
	
	public Menu() {
		// TODO Auto-generated constructor stub
	}

	public Menu(int id, String name, int parentid, String desc, String url) {
		super();
		this.id = id;
		this.name = name;
		this.parentid = parentid;
		this.desc = desc;
		this.url = url;
	}
	
	
}
