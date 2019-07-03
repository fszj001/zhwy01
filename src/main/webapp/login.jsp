<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="assets/css/layui.css">
    <link rel="stylesheet" href="assets/css/login1.css">
    <link rel="icon" href="/favicon.ico">
    <title>登录</title>
</head>
<body>
<div id="login">
     <div id="header">
     	<div id="pic"></div>
     </div>
     
     <div id="content">
     <div id="left">
     	<div id="people"></div>
     </div>
     <div id="cont">
     	<form class="login-form" action="login.do" method="post">
            <div class="input-group">
                <input type="text" placeholder="用户名" name="userName"  id="username" class="input-field">
                <label for="username" class="input-label"  title="用户名">
                    <span class="label-title"></span>
                </label>
            </div>
            <div class="input-group">
                <input type="password" placeholder="密码" name="userPass" id="userPass" class="input-field">
                <label for="password" class="input-label">
                    <span class="label-title"></span>
                </label>
            </div>
            
            <div class="input-group-1">
            <div class="radio"><!--  1 角色为教师，2 为学生  -->
            	<input type="radio"  class="radio-group" value="1" checked="checked" name="roleid" id="roleid">&nbsp;&nbsp;教师、管理员
            </div>
             <div class="radio">
            	<input type="radio"  class="radio-group" value="2"  name="roleid" id="roleid">&nbsp;&nbsp;学生
            </div>
                <label for="password" class="input-label">
                    <span class="label-title"></span>
                </label>
            </div>
            
            <button type="submit" class="login-button">登录<i class="ai ai-enter"></i></button>
        </form>
     </div>
     </div>
     <div id="footer">
     	 
     </div>
</div>
</body>
<script src="assets/layui.js"></script>
<script src="index.js" data-main="login"></script>
</html>