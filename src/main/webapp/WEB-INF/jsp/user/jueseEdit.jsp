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
                <form id="form"   class="layui-form layui-card-body" action="roleEdit.do" onsubmit="return false">
                  <div class="layui-form-item">
                    <label class="layui-form-label">角色名称</label>
                    <div class="layui-input-block" style="width: 300px">
                      <input type="text" id="roleName" name="roleName" value="${role.roleName }" required  lay-verify="required"   autocomplete="off" class="layui-input">
                      <input type="hidden" id="roleid" name="roleid" value="${role.roleid }" >
                    </div>
                  </div>
                   
                   <div class="layui-form-item">
                    <label class="layui-form-label">资源选择</label>
                    <div class="layui-input-block"  style="width: 300px">
                    <input type="hidden"  id="rk"  name="rk"   required      autocomplete="off" class="layui-input">
                    <div id="xtree1" class="xtree_contianer"></div>
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
    	  if($("#roleName").val()==""){ layer.msg("请输入角色名称！"); return false; }
    	  
    	  var rk = "";
    	  var oCks = xtree1.GetAllCheckBox(); //这是方法
          for (var i = 0; i < oCks.length; i++) {
        	  if(oCks[i].checked){
        		  rk+=oCks[i].value+",";
        	  }
          }
    	  if(rk.length>0){
    		  rk = rk.substring(0, rk.length-1);
    	  }
    	  $("#rk").val(rk);
          console.log(rk);
          if($("#rk").val()==""){ layer.msg("请输入选择资源！"); return false; }
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
	  
	  var xtree1 = new layuiXtree({
          elem: 'xtree1'   //(必填) 放置xtree的容器，样式参照 .xtree_contianer
          , form: form     //(必填) layui 的 from
          , data: 'getMenuTree.do?rk=${role.rk}'     //(必填) json数据 
          , icon: {        //三种图标样式，更改几个都可以，用的是layui的图标
              open: "&#xe7a0;"       //节点打开的图标
              , close: "&#xe622;"    //节点关闭的图标
              , end: "&#xe621;"      //末尾节点的图标
          }
          , color: {       //三种图标颜色，独立配色，更改几个都可以
              open: "#EE9A00"        //节点图标打开的颜色
                  , close: "#EEC591"     //节点图标关闭的颜色
                  , end: "#828282"       //末级节点图标的颜色
              }
      });
	  
	  $("#btn111").click(function(){
          var oCks = xtree1.GetChecked(); //这是方法
          for (var i = 0; i < oCks.length; i++) {
              console.log(oCks[i].value);
          }
      });
	  
	  
	 /*  var oCks = xtree1.GetAllCheckBox(); //这是方法
      for (var i = 0; i < oCks.length; i++) {
           oCks[i].checked=true;
           console.log(oCks[i]);
           oCks[i].checked=true;
      }
	  
      form.render('checkbox'); */
       
    </script>
    
    
        
</body>
</html>