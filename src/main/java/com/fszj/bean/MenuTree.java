package com.fszj.bean;

import java.util.List;

public class MenuTree {

	private String title;
	
	private boolean checked=false;
	
	private int value;
	
	private List<MenuTree> data;

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public boolean isChecked() {
		return checked;
	}

	public void setChecked(boolean checked) {
		this.checked = checked;
	}

	public List<MenuTree> getData() {
		return data;
	}

	public void setData(List<MenuTree> data) {
		this.data = data;
	}

	public int getValue() {
		return value;
	}

	public void setValue(int value) {
		this.value = value;
	}
	
	
}
