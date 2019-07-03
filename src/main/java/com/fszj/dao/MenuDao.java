package com.fszj.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Component;

import com.fszj.bean.Menu;

@Component
public interface MenuDao {

	/*public List<Menu> getMenu(String pid);*/
	public List<Menu> getMenu(@Param("pid") String pid, @Param("list") List list);
}
