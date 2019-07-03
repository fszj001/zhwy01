package com.fszj.bean;

import java.util.HashMap;
import java.util.Map;

import com.alibaba.fastjson.JSONArray;

public class Page {

	private int page;
	
	private int limit;

	public int getPage() {
		return page;
	}

	public void setPage(int page) {
		this.page = page;
	}

	public int getLimit() {
		return limit;
	}

	public void setLimit(int limit) {
		this.limit = limit;
	}
	
	//获取开始页数
	public int getStart(){
		return  (page-1)*limit;
	}
	
	//获取结束条数
	public int getEnd(){
		return limit;
	}
	
	public Map<String, Object> getResult(int count, JSONArray array) {
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", 0);
		result.put("msg", "");
		result.put("count",count);
		result.put("data", array);
		return result;
	}
}
