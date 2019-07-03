package com.fszj.controller.system;

import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;
import com.fszj.bean.Page;
import com.fszj.bean.Role;
import com.fszj.bean.User;
import com.fszj.dao.system.LoginDao;
import com.fszj.listener.SessionListener;
import com.fszj.service.LoginService;
import com.fszj.service.MenuService;
import com.fszj.utils.MathUtil;



@Controller
public class LoginController {
	
	@Resource
	private MenuService menuService;
	public void setMenuService(MenuService menuService) {
		this.menuService = menuService;
	}
	
	@Resource
	private LoginDao loginDao;
	
	public void setLoginDao(LoginDao loginDao) {
		this.loginDao = loginDao;
	}
	
	@Resource
	private LoginService loginService;

	public void setLoginService(LoginService loginService) {
		this.loginService = loginService;
	}


	@RequestMapping("login")
	public String login(Model model,HttpSession session,User u1 ,HttpServletRequest  request){
		String  path  = u1.getRoleid();
		User u =  null;
		u = loginDao.check(u1);
		String userid =  u.getUid();
		int count = checkLogin(session,userid,request);
		model.addAttribute("menu", menuService.getMenu(u));
		session.setAttribute("user", u);
		model.addAttribute("user", u);
		model.addAttribute("count", count);
		session.setAttribute("count", count);
		return "index";
				
	}

	private int checkLogin(HttpSession session,String userid,HttpServletRequest request) {
		 
			System.out.println(SessionListener.sessionContext.getSessionMap());
			if(SessionListener.sessionContext.getSessionMap().get(userid)!=null){
				HttpSession userSession=(HttpSession)SessionListener.sessionContext.getSessionMap().get(userid);
				//注销在线用户
				if(!userSession.getId().equals(session.getId())){
				    userSession.invalidate();	
					SessionListener.sessionContext.getSessionMap().remove(userid);
					//清除在线用户后，更新map,替换map sessionid
					SessionListener.sessionContext.getSessionMap().remove(session.getId());	
					SessionListener.sessionContext.getSessionMap().put(userid,session);	
				}
			}
			else{
				// 根据当前sessionid 取session对象。 更新map key=用户名 value=session对象 删除map
				SessionListener.sessionContext.getSessionMap().put(userid,SessionListener.sessionContext.getSessionMap().get(session.getId()));
				SessionListener.sessionContext.getSessionMap().remove(session.getId());
				System.out.println(SessionListener.sessionContext.getSessionMap());
			}
		return SessionListener.sessionContext.getSessionMap().size();
	}
	
	/*
	 * role 
	 *  1 的时候是教师或者管理员 
	 *  2 学生  
	 */
	@RequestMapping("loginOut")
	public String loginOut(Model model,HttpSession session,String userid,String role){
		System.out.println("退出开始："+SessionListener.sessionContext.getSessionMap());
		HttpSession userSession=(HttpSession) SessionListener.sessionContext.getSessionMap().get(userid);
		SessionListener.sessionContext.getSessionMap().remove(userid);
		if(role.equals("1")){
			session.removeAttribute("user");
		}else{
			session.removeAttribute("student");
		}
		System.out.println("退出结束："+SessionListener.sessionContext.getSessionMap());
		//删除session，然后退出
		return "../../login";
	}
	
	@RequestMapping("updatePass")
	public String updatePass(){
		return "updatepass";
	}
	/*
	 * 修改密码
	 */
	@RequestMapping(value="update",produces = "application/html; charset=utf-8")
	@ResponseBody
	public String update(HttpServletResponse response,User user,HttpSession session){
		response.setContentType("application/html;charset=utf-8");
		User u = (User)session.getAttribute("user");
		user.setUid(u.getUid());
		loginService.update(user);
		return "修改成功！";
	}
	
	
	/*
	 * 用户列表
	 */
	@RequestMapping(value="userListInit",produces = "application/json; charset=utf-8")
	public String useListInit(Model model){
		return "user/userList";
	}
	
	@RequestMapping(value="/userList",produces = "application/json; charset=utf-8")
	@ResponseBody
	public String userList(Page page,User user,String userName){
		Map map = loginService.userList(page,user);
		String jsonstr = JSON.toJSONString(map);
		System.out.println(jsonstr);
		return jsonstr;
	}
	
	
	/*
	 * 角色列表
	 */
	@RequestMapping(value="jueseListInit",produces = "application/json; charset=utf-8")
	public String jueseListInit(Model model){
		return "user/jueseList";
	}
	
	@RequestMapping(value="/jueseList",produces = "application/json; charset=utf-8")
	@ResponseBody
	public String jueseList(Page page,Role role){
		Map map = loginService.roleList(page,role);
		String jsonstr = JSON.toJSONString(map);
		System.out.println(jsonstr);
		return jsonstr;
	}
	
	
	@RequestMapping(value="roleAddInit",produces = "application/json; charset=utf-8")
	public String roleAddInit(Model model){
		return "user/jueseAdd";
	}
	
	@RequestMapping(value="roleAdd",produces="application/html;charset=utf-8")
	@ResponseBody
	public String roleAdd(Role role){
		loginService.roleAdd(role);
		return "添加成功！";
	}
	
	
	/*
	 * 获取资源json
	 */
	@RequestMapping(value="getMenuTree",produces="application/json;charset=utf-8")
	@ResponseBody
	public String getMenuTree(String rk){
		String str = loginService.getMenuTree(rk);
		return str;
	}
	
	@RequestMapping(value="roleEditInit",produces="application/html;charset=utf-8")
	public String roleEdit(String roleid,Model model){
		Role r =loginService.getRole(roleid);
		model.addAttribute("role", r);
		return "user/jueseEdit";
	}
	
	@RequestMapping(value="roleEdit",produces = "application/html; charset=utf-8")
	@ResponseBody
	public String roleEdit(HttpServletResponse response,Role role){
		 response.setContentType("application/json;charset=utf-8");
		 loginService.roleEdit(role);
		 return "修改成功！";
	}
	
	
	@RequestMapping(value="userAddInit",produces = "application/json; charset=utf-8")
	public String userAddInit(Model model){

		return "user/userAdd";
	}
	
	@RequestMapping(value="userAdd",produces="application/html;charset=utf-8")
	@ResponseBody
	public String userAdd(User user){
		user.setCreateTime(MathUtil.getTimeNow());
		MathUtil mathUtil = new MathUtil();
		user.setUserName("");
		loginService.userAdd(user);
		return "添加成功！";
	}
	
	@RequestMapping(value="userDel",produces="application/html; charset=utf-8")
	@ResponseBody
	public String userDel(User user,HttpServletResponse response){
		 response.setContentType("application/html;charset=utf-8");
		 loginService.userDel(user);
		return "删除成功！";
	}
	
	@RequestMapping("userEditInit")
	public String userEditInit(String uid,Model model){

		return "user/userEdit";
	}
	
	@RequestMapping(value="userEdit",produces = "application/html; charset=utf-8")
	@ResponseBody
	public String userEdit(HttpServletResponse response,User user){
		 response.setContentType("application/json;charset=utf-8");
		 MathUtil mathUtil = new MathUtil();
		 user.setUserName("");
		 loginService.userEdit(user);
		 return "修改成功！";
	}
	
	@RequestMapping(value="jueseDel",produces="application/html; charset=utf-8")
	@ResponseBody
	public String jueseDel(Role role,HttpServletResponse response){
		 response.setContentType("application/html;charset=utf-8");
		 loginService.roleDel(role);
		return "删除成功！";
	}
}
