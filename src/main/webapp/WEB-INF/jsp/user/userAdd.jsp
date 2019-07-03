<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
 
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
     <script src="assets/layui.all.js"></script>
    <script src="assets/jquery-3.3.1.js"></script>
    <script src="assets/layui-xtree.js"></script>
    <script src="assets/jquery.form.js"></script>
    <!-- <link rel="stylesheet" href="assets/css/view.css"/> -->
    <link rel="stylesheet" href="assets/css/layui.css"/>
    <link rel="icon" href="favicon.ico">
    <title></title>
    <style>
		 .xtree_contianer {
		            width: 500px;
		            border: 1px solid #9C9C9C;
		            overflow: auto;
		            margin-bottom: 30px;
		            background-color: #fff;
		            padding: 10px 0 25px 5px;
        }
</style>
</head>
<body class="layui-view-body">
    <div class="layui-content">
        <div class="layui-row">
            <div class="layui-card">
                <form id="form"   class="layui-form layui-card-body" action="userAdd.do" onsubmit="return false">
                  <div class="layui-form-item">
                    <label class="layui-form-label">用户名</label>
                    <div class="layui-input-block"  style="width: 300px">
                      <input type="text" id="name" name="name" required  lay-verify="required"   autocomplete="off" class="layui-input">
                    </div>
                  </div>
                   
                   <div class="layui-form-item">
                    <label class="layui-form-label">密码</label>
                    <div class="layui-input-block"  style="width: 300px">
                    <input type="password"  id="userPass"  name="userPass"  required      autocomplete="off" class="layui-input">
                    </div>
                  </div>
                  
                   <div class="layui-form-item">
                    <label class="layui-form-label">重复密码</label>
                    <div class="layui-input-block"  style="width: 300px">
                    <input type="password"  id="rpassword"  name="rpassword"  required      autocomplete="off" class="layui-input">
                    </div>
                  </div>
                  
                   <div class="layui-form-item">
                    <label class="layui-form-label">选择角色</label>
                    <div class="layui-input-block"  style="width: 300px">
                   		 <select id="roleid" name="roleid" lay-verify="required" lay-search="" >
				          <option value="">直接选择或搜索选择</option>
					          <c:forEach items="${ roleList}" var="role">
					          		 <option value="${role.roleid }">${role.roleName }</option>
					          </c:forEach>
				        </select>
                    </div>
                  </div>
                  
                  <div class="layui-form-item">
                    <label class="layui-form-label">选择角色</label>
                    <div class="layui-input-block"  style="width: 300px">
                   		 <select id="classId" name="classId">
				          <option value="">选择班级</option>
					          <c:forEach items="${ classList}" var="nj">
					          		 <option value="${nj.classId }">${nj.grade }|${nj.className }</option>
					          </c:forEach>
				        </select>
                    </div>
                  </div>
                  
                  <div class="layui-form-item">
                    <div class="layui-input-block">
                      <button class="layui-btn layui-btn-blue" id="submit" lay-submit lay-filter="formDemo">立即提交</button>
                      <button type="reset" class="layui-btn layui-btn-primary">重置</button>
                    </div>
                  </div>
                </form>  
            </div>
        </div>
    </div>
    <script>
      var form = layui.form
        ,layer = layui.layer;
      var index = parent.layer.getFrameIndex(window.name);
      var laydate = layui.laydate;
      form.render();
      /* laydate.render({
		    elem: '#hmxpayTime' //指定元素
	  }); */
      
      $("#submit").click(function(){
    	  if($("#userName").val()==""){ layer.msg("请输入用户名称！"); return false; }
    	  if($("#userName").val()==""){ layer.msg("请输入用户名称！"); return false; }
    	  if($("#userPass").val()!=$("#rpassword").val()){
    		  layer.msg("两次密码输入不一致，请重新输入！"); return false;
    		  return false;
    	  }
    		  $("#form").ajaxSubmit({
                  success:function (data) {
               	   parent.layer.msg(data);
               	   parent.layer.close(index);
                      parent.$("#search1").click();
                  },
                  error:function(){
               	   layer.msg("添加失败！");
                  }
   	  		});
    	  
      });
	  
	 
       
    </script>
    
    
        
</body>
</html>