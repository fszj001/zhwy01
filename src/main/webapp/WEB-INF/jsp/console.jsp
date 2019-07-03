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
     <meta name="viewport" content="initial-scale=1.0, user-scalable=no" /> 
    
	<style type="text/css">
		.BMap_cpyCtrl
	{
		display:none; 
	}
	.anchorBL{
		display:none; 
	} 
		
	</style>
</head>
<body class="layui-view-body">
    <div class="layui-content">
        <div class="layui-row layui-col-space20">
            <div class="layui-col-sm6 layui-col-md3">
                <div class="layui-card">
                    <div class="layui-card-body chart-card">
                        <div class="chart-header">
                            <div class="metawrap">
                                <div class="meta">
                                    <span>试卷数量</span>
                                </div>
                                <div class="total">${sjCount }套</div>
                            </div>
                        </div>
                         
                    </div>
                </div>
            </div>
            <div class="layui-col-sm6 layui-col-md3">
                <div class="layui-card">
                    <div class="layui-card-body chart-card">
                        <div class="chart-header">
                            <div class="metawrap">
                                <div class="meta">
                                    <span>题目总数</span>
                                </div>
                                <div class="total">${tkCount }个</div>
                            </div>
                        </div>
                         
                    </div>
                </div>
            </div>
            <div class="layui-col-sm6 layui-col-md3">
                <div class="layui-card">
                    <div class="layui-card-body chart-card">
                        <div class="chart-header">
                            <div class="metawrap">
                                <div class="meta">
                                    <span>学生总数</span>
                                </div>
                                <div class="total">${stuCount }个</div>
                            </div>
                        </div>
                         
                         
                    </div>
                </div>
            </div>
            <div class="layui-col-sm6 layui-col-md3">
                <div class="layui-card">
                    <div class="layui-card-body chart-card">
                        <div class="chart-header">
                            <div class="metawrap">
                                <div class="meta">
                                    <span>考试总数</span>
                                </div>
                                <div class="total">${startExamCount }次</div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="layui-col-sm12 layui-col-md12">
                <div class="layui-card">
                    <div class="layui-tab layui-tab-brief"  id="container" style="height: 500px">
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script>
     var element = layui.element;
     var map;
     
     
     function initialize() {
    	 
    	 
    	//异步获取房屋地理位置以及房东
     	map = new BMap.Map("container");          // 创建地图实例  
     	var point = new BMap.Point(115.777463,33.894776);  // 创建点坐标  
     	map.centerAndZoom(point, 18);   
     	map.enableScrollWheelZoom(true);   
     	map.setMapType(BMAP_HYBRID_MAP); 
     	map.setCurrentCity("合肥");
     	
  	    
       
	        
     	$.ajax({
	    	   url:'getBaiduInfo.do',
	    	   type:'post',
	    	   success:function(data){
	    		   for (var i =0;i<data.length;i++) {
	                (function (x) {
	    			   if(data[i].jd!=='' && data[i].jd!==null 
	    					 && data[i].wd!=='' && data[i].wd!==null){
	    			   var  p = new BMap.Point(data[i].jd ,data[i].wd);
	    			   var marker = new BMap.Marker(p);  // 创建标注   
	    			   map.addOverlay(marker); 
	    	   	       var label = new BMap.Label(data[i].hname, { offset: new BMap.Size(30, -10) });
	    	   	       marker.setLabel(label);
	    	   	       label.setStyle({
		    	   	       color: "White",
		    	   	       fontSize: "14px",
		    	   	       backgroundColor: "#5CACEE",
		    	   	       border: "0"
	                   });
	    	   	       var opts = {    
	   	   	        	    width : 150,     // 信息窗口宽度    
	   	   	        	    height: 120,     // 信息窗口高度    
	   	   	        	    title : "<strong style=\"font-size:16px;font-weight:bold\">"+ data[i].hname +"</strong>" // 信息窗口标题   
	   	   	        	};
	    	   	      var showInfo = "房东姓名：" + data[i].hfd + "<br/>" +"房东电话：" + data[i].hphone + "<br/>"+ "房屋分割：" + data[i].fgs + "个<br/>下次交租：" + data[i].hnextpay + "<br/>租房时间：" + data[i].hrentTime;
	    	   	       var infoWindow = new BMap.InfoWindow(showInfo, opts);
	    	   	       marker.addEventListener("click", function(e){   
	    	   	    	   marker.openInfoWindow(infoWindow,  p);
	    		       });
	    	   	       map.addOverlay(marker);
	    			   }})(i);
	                }
	    		   
	    	   },
	    	   error:function(){
	    		   layer.msg("获取信息失败！");
	    	   }
	       });
       }  
    </script>
    <script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=1LcbFvVtDsLQYdu3IuCOym1ast22eniw&callback=initialize"></script>
</body>
</html>