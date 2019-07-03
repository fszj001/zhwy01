package com.fszj.dao.system;


import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Component;

import com.fszj.bean.Role;
import com.fszj.bean.User;


@Component
public interface LoginDao {
	public User check(User user);
	public User getUser(@Param("uid") String uid);
	public List userList(@Param("userName") String userName, @Param("start") int start
            , @Param("end") int end);
	public int userCount(@Param("userName") String userName);
	public void userAdd(User user);
	public void userDel(User user);
	public List roleList(@Param("roleName") String roleName, @Param("start") int start
            , @Param("end") int end);
	public int roleCount(@Param("roleName") String roleName);
	public void roleAdd(Role role);
	public Role getRole(@Param("roleid") String roleid);
	public void roleEdit(Role role);
	public List<Role> getRoleAll();
	public void userEdit(User user);
	public void roleDel(Role role);
	public void update(User user);

}
 