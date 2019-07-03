package com.fszj.service;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import com.fszj.bean.Menu;
import com.fszj.bean.Role;
import com.fszj.bean.User;
import com.fszj.dao.MenuDao;
import com.fszj.dao.system.LoginDao;

@Component
public class MenuService {

	@Resource
	private MenuDao menuDao;
	
	public void setMenuDao(MenuDao menuDao) {
		this.menuDao = menuDao;
	}
	
	@Resource
	private LoginDao loginDao;
	
	public void setLoginDao(LoginDao loginDao) {
		this.loginDao = loginDao;
	}
	
	public String getMenu(User u){
		String roleId = u.getRoleid();
		List<Integer> list = getRks(roleId);
		List<Menu> parentList = menuDao.getMenu("0",list);
		StringBuffer menuStr= new StringBuffer();
		for (int i = 0; i < parentList.size(); i++) {
			Menu menu = parentList.get(i);
			String menuStr_=" <li class=\"layui-nav-item\">"
			          +"<a href=\"javascript:;\"><i class=\"layui-icon\">&#xe612;</i>"+menu.getName()+"</a>"
			          +"<dl class=\"layui-nav-child\">";
			          List<Menu> childList = menuDao.getMenu(menu.getId()+"",list);
			          for (int j = 0; j < childList.size(); j++) {
			        	  Menu menu_ = childList.get(j);
			        	  menuStr_+="<dd><a href=\""+menu_.getUrl()+"\">"+menu_.getName()+"</a></dd>";
			          }
			          menuStr_+="</dl></li>";
			          menuStr.append(menuStr_);
		}
		return menuStr.toString();
	}

	public List<Integer> getRks(String roleId) {
		Role r = loginDao.getRole(roleId);
		String rk =  r.getRk();
		List<Integer> list = new ArrayList<Integer>();
		if(!rk.equals("")){
			String[] rks = rk.split(",");
			for (String str : rks) {
				list.add(Integer.valueOf(str));
			}
		}
		return list;
	}
	
	
	
}
