<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <base href="<%=basePath%>">
    
    <title>用户列表</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
    <link rel="stylesheet" href="assets/css/view.css"/>
    <link rel="stylesheet" href="assets/css/layui.css"/>
     <link rel="icon" href="/favicon.ico">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

  </head>
  
  <body class="layui-view-body">
    <div class="layui-content">
        <div class="layui-page-header">
            <div class="pagewrap">
                <span class="layui-breadcrumb">
                  <a href="javascript:void(0)">用户管理</a>
                  <a><cite>用户列表</cite></a>
                </span>
            </div>
        </div>
        <div class="layui-row">
            <div class="layui-card">
                <div class="layui-card-body">
                    <div class="form-box">
                        <div class="layui-form layui-form-item">
                            <div class="layui-inline">
                               <!--  <div class="layui-form-mid">开始时间:</div>
                                <div class="layui-input-inline" style="width: 100px;">
                                  <input id="startTime" type="text" autocomplete="off" class="layui-input">
                                </div>
                                <div class="layui-form-mid">开始时间:</div>
                                <div class="layui-input-inline" style="width: 100px;">
                                  <input id="endTime" type="text" autocomplete="off" class="layui-input">
                                </div> -->
                                <div class="layui-form-mid">用户名:</div>
                                <div class="layui-input-inline" style="width: 100px;">
                                  <input id="userName" type="text" autocomplete="off" class="layui-input">
                                </div>
                                <button class="layui-btn layui-btn-blue" id="search" data-type="reload">搜索</button>
                                <b id="search1"></b>
                                <button class="layui-btn layui-btn-primary">重置</button>
                                <button class="layui-btn layui-btn-blue" id="add"><i class="layui-icon">&#xe654;</i>新增</button>
                           	    <button class="layui-btn layui-btn-blue" id="downxs"><i class="layui-icon">&#xe654;</i>下载模板</button>
                           	    <input id="file" name="file" type="file"  style="width: 200" > 
                      <button class="layui-btn layui-btn-blue" id="submit" lay-submit lay-filter="formDemo">批量上传</button>
                            </div>
                           
                            </div>
                        </div>
                        <table  class="layui-table"  id="demo" lay-skin="row"  lay-filter="demo"></table>
                        <script type="text/html" id="barDemo">
							<a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
 						    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
						</script>
                    </div>
                </div>
            </div>
        </div>
    </div>
     
    </body>
    <script src="assets/layui.all.js"></script>
    <script src="assets/jquery-3.3.1.js"></script>
    <script>
    layui.use(['laydate','table'], function(){
    	  var table = layui.table;
    	  var laydate = layui.laydate;
    	  var upload = layui.upload;
    	  //展示已知数据 
    	  var tableIns = table.render({
    	    elem: '#demo'
    	    ,url: 'userList.do'
    	    ,totalRow: true
    	    ,cols: [[ //标题栏
    	      { field: 'uid',  hide:true   ,align:'center'},
    	      { type: 'numbers', title: '序号',align:'center'  },
    	      { field: 'userName',  title: '登录账户',align:'center'  }
    	      ,{ field: 'Name',  title: '姓名',align:'center'  }
    	      ,{ field: 'roleName',  title: '角色',align:'center'   ,templet: function(res){
	    		    if(res.roleid==null || res.roleid==''){
	    		    	return '--';
	    		    }else{
	    		    	return res.roleName;
	    		    }
	    	      }}
    	      ,{ field: 'createTime',  title: '创建时间',align:'center'  }
    	     
    	      ,{field: 'right', title: '操作',  toolbar: '#barDemo',align:'center'}
    	    ]]
    	    ,skin: 'line' //表格风格
    	    ,even: true
    	    ,page: true //是否显示分页
    	    ,limits: [5,10, 20, 30]
    	    ,limit: 5 //每页默认显示的数
    	  });
    	  
    	  /* table.on('row(demo)', function(obj){
    		  var data = obj.data;
    		  alert(data.uid);
    		  layer.alert(JSON.stringify(data), {
    		      title: '当前行数据：'
    		  });
    	  }); */
    	  //日期
    	 /*  laydate.render({
    		    elem: '#startTime' //指定元素
    	  });  */
    	 /*  laydate.render({
  		    elem: '#endTime' //指定元素
  	 	 }); */
    	  //重置
    	  $(".layui-btn-primary").click(function(){
    		   $("#userName").val("");
    	  });
    	  //搜索
    	  $('#search').on('click', function(){
    		  var userName =  $("#userName").val();
    		  tableIns.reload({
    			  where: { //设定异步数据接口的额外参数，任意设
    				  userName:userName
    			  }
    			  ,page: {
    			    curr: 1 //重新从第 1 页开始
    			  }
    			});   
    	  });
    	  
    	  //新增或者修改是保留当前页
    	  $('#search1').on('click', function(){
    		  var curr1=tableIns.config.page.curr;
    		  var userName =  $("#userName").val();
    		  tableIns.reload({
    			  where: { //设定异步数据接口的额外参数，任意设
    				  userName:userName
    			  }
    			  ,page: {
    			    curr: curr1 //重新从第 1 页开始
    			  }
    			});   
    	  });
    	  
    	  
    	  //新增
    	  $("#add").click(function(){
    		   layer.open({
    			  type: 2,
    			  title:'新增用户信息',
    			  skin: 'layui-layer-rim', //加上边框
    			  area: ['1100px', '500px'], //宽高
    			  content: 'userAddInit.do'
    		  });
    	  });
    	  
    	  $("#downxs").click(function(){
        	  //后台处理生成试卷json数据格式
    	    	 layer.confirm('确定下载吗？', function(index){
    	    			window.location.href="xsgl/downxs.do?name=教师信息模板.xls";
    	    			layer.close(index);
    	    	 });
        	  });
    	  //批量上传教师
    	  var uploadInst = upload.render({
	      	    elem: '#file'
	      	    ,url: 'xsgl/uploadjs.do'
	      	    ,auto: false
	      	    ,bindAction: '#submit'
	      	    ,accept: 'file'
	   	    	,done: function(res){
	   	          alert(res.msg);
	   	          $("#search1").click();
	   	        }
	   	        ,error: function(){
	   	         alert("导入失败！");
	   	        }
    		});
    	  
    	  
    	//监听工具条
    	  table.on('tool(demo)', function(obj){
    	    var data = obj.data;
  	        var uid  = data.uid;
    	    if(obj.event === 'detail'){
    	    } else if(obj.event === 'del'){
    	    	//删除
    	       layer.confirm('真的删除行么?', function(index){
    	    	      //向服务端发送删除指令
    	    	       $.ajax({
    	    	    	   url:'userDel.do',
    	    	    	   type:'post',
    	    	    	   data:{uid:uid},
    	    	    	   success:function(data){
    	    	    		   layer.msg(data);
    	    	    		   obj.del(); //删除对应行（tr）的DOM结构，并更新缓存
    	      	    	       layer.close(index);
    	    	    	   },
    	    	    	   error:function(){
    	    	    		   layer.msg("删除失败！");
    	    	    	   }
    	    	       });
    	    	     
    	   	   });
    	    } else if(obj.event === 'edit'){
    	       layer.open({
      			  type: 2,
      			  title:'新增分割房屋',
      			  skin: 'layui-layer-rim', //加上边框
      			  area: ['1100px', '500px'], //宽高
      			  content: 'userEditInit.do?uid='+uid
      		  });
    	    } 
    	  });
    	  
    });   
 
    </script>
</html>
