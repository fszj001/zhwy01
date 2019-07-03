<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
 
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <script src="<%=basePath %>/assets/layui.all.js"></script>
    <script src="<%=basePath %>/assets/jquery-3.3.1.js"></script>
    <script src="<%=basePath %>/assets/jquery.form.js"></script>
    <link rel="stylesheet" href="<%=basePath %>/assets/css/view.css"/>
    <link rel="stylesheet" href="<%=basePath %>/assets/css/layui.css"/>
    
	
    
    <link rel="icon" href="/favicon.ico">
    <title></title>
</head>
<body class="layui-view-body">
    <div class="layui-content">
    <div class="layui-page-header">
            <div class="pagewrap">
                <span class="layui-breadcrumb">
                  <a href="javascript:void(0)">用户管理</a>
                  <a><cite>密码修改</cite></a>
                </span>
            </div>
        </div>
        <div class="layui-row">
            <div class="layui-card">
                <form id="form" class="layui-form layui-card-body" action="update.do" onsubmit="return false">
                  <div class="layui-form-item">
                    <label class="layui-form-label">输入新密码</label>
                    <div class="layui-input-block" style="width: 300px">
                      <input type="password" id="userPass" name="userPass" required  lay-verify="required"   autocomplete="off" class="layui-input">
                    </div>
                  </div>
                   
                   <div class="layui-form-item">
                    <label class="layui-form-label">再次输入新密码</label>
                    <div class="layui-input-block"  style="width: 300px">
                    <input type="password"  id="newpass"  name="newpass"  required  lay-verify="required"   autocomplete="off" class="layui-input">
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
    	  var userPass=  $("#userPass").val();
    	  var newpass = $("#newpass").val();
    	  if($("#userPass").val()==""){ layer.msg("请输入新密码！"); return false; }
    	  if($("#newpass").val()==""){ layer.msg("请再次输入新密码！"); return false; }
    	  if(userPass!=newpass){
    		  layer.msg("两次密码输入不一致,请重新输入！"); return false;  
    	  }
    		  $("#form").ajaxSubmit({
                  success:function (data) {
               	   layer.msg(data);
               	$("#userPass").val("");
               	$("#newpass").val("");
                  },
                  error:function(){
               	   layer.msg("修改失败！");
                  }
   	  		});
    	  
      });
    </script>
</body>
</html>