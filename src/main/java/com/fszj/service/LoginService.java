package com.fszj.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Component;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.fszj.bean.Menu;
import com.fszj.bean.MenuTree;
import com.fszj.bean.Page;
import com.fszj.bean.Role;
import com.fszj.bean.User;
import com.fszj.dao.MenuDao;
import com.fszj.dao.system.LoginDao;
import com.fszj.utils.MathUtil;
@Component
public class LoginService {
	@Resource
	private LoginDao loginDao;

	public void setLoginDao(LoginDao loginDao) {
		this.loginDao = loginDao;
	}
	@Resource
	private MenuDao menuDao;
	
	public void setMenuDao(MenuDao menuDao) {
		this.menuDao = menuDao;
	}

	public Map userList(  Page page,User user) {
		int start = page.getStart();
		int end   = page.getEnd();
		List list =  loginDao.userList(user.getUserName(),start,end);
		int count =  loginDao.userCount(user.getUserName());
		JSONArray array = (JSONArray) JSON.toJSON(list);
		return page.getResult(count, array);
	}
	
	public void userAdd(User user){
		user.setUid(MathUtil.getUUID());
		loginDao.userAdd(user);
	}
	
	public void userDel(User user){
		loginDao.userDel(user);
	}

	public User getUser(String uid) {
		 
		return loginDao.getUser(uid);
	}

	public Map roleList(Page page, Role role) {
		int start = page.getStart();
		int end   = page.getEnd();
		List list =  loginDao.roleList(role.getRoleName(),start,end);
		int count =  loginDao.roleCount(role.getRoleName());
		JSONArray array = (JSONArray) JSON.toJSON(list);
		return page.getResult(count, array);
	}

	public void roleAdd(Role role) {
		// TODO Auto-generated method stub
		role.setRoleid(MathUtil.getUUID());
		loginDao.roleAdd(role);
	}

	/*
	 * rk为资源id数组，如果rk为空，则新增
	 * rk不为空时，说明是修改角色时传过来的参数
	 */
	public String getMenuTree(String rk) {
		List<String> rks = new ArrayList<String>();
		if("".equals(rk)|| null==rk){
			//rk为空 ，不关系
		}else{
			String[]  s = rk.split(",");
			for (String s1 : s) {
				rks.add(s1);
			}
		}
		List<Menu> parentList = menuDao.getMenu("0",null);
		List<MenuTree> menuTrees = new ArrayList();
		for (int i = 0; i < parentList.size(); i++) {
			
			Menu menu = parentList.get(i);
			MenuTree  menuTree = new MenuTree();
			menuTree.setTitle(menu.getName());
			menuTree.setValue(menu.getId());
			List<MenuTree> data = new ArrayList();
	          List<Menu> childList = menuDao.getMenu(menu.getId()+"",null);
	          for (int j = 0; j < childList.size(); j++) {
	        	  MenuTree  menuTree_ = new MenuTree();
	        	  Menu menu_ = childList.get(j);
	        	  if(menu_.getId()==15){
	        		  System.out.println("1111111");
	        	  }
  				  if(rks.contains(menu_.getId()+"")){
  					menuTree_.setChecked(true);  
  				  }
	        	  
	        	  menuTree_.setValue(menu_.getId());
	        	  menuTree_.setTitle(menu_.getName());
	        	  data.add(menuTree_);
	          }
	          menuTree.setData(data);
	          menuTrees.add(menuTree);
		}
		String jsonstr = JSON.toJSONString(menuTrees);
		System.out.println(jsonstr);
		return jsonstr;
	}

	public Role getRole(String roleid) {
		 Role r = loginDao.getRole(roleid);
		return r;
	}

	public void roleEdit(Role role) {
		// TODO Auto-generated method stub
		loginDao.roleEdit(role);
	}

	public List getRoleAll() {
		// TODO Auto-generated method stub
		List<Role> list = loginDao.getRoleAll();
		return list;
	}

	public void userEdit(User user) {
		// TODO Auto-generated method stub
		user.setCreateTime(MathUtil.getTimeNow());
		loginDao.userEdit(user);
	}

	public void roleDel(Role role) {
		// TODO Auto-generated method stub
		loginDao.roleDel(role);
	}

	public void update(User user) {
		// TODO Auto-generated method stub
		loginDao.update(user);
	}

	 


}
