<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%  
String path = request.getContextPath();  
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";  
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
<meta name="description" content="">
<meta name="author" content="">
<link rel="stylesheet" href="css/bootstrap.min.css"/>
<link rel="stylesheet" href="css/bootstrap.css.map"/>
<link rel="stylesheet" href="css/bootstrap-theme.min.css"/>
<link rel="stylesheet" href="css/bootstrap-theme.css.map"/>
<link rel="stylesheet" href="css/login.css"/>
<link rel="stylesheet" href="css/reg.css"/>
<title>教师注册</title>
</head>

<body style="background-image: url(pic/1024768.jpg);">
     <nav class="navbar navbar-inverse navbar-fixed-top">
      <div class="container-fluid">
      
        <div class="navbar-header">
        <a class="navbar-brand">中小学语文在线作业系统</a>
        </div>
        
        <div id="navbar" class="navbar-collapse collapse">
          <ul class="nav navbar-nav navbar-right">
            <li><a href="#">Help</a></li>
          </ul>
        </div>
      </div>
    </nav>
    <div class="container">
    	<div class="row ">
	         <h3 class="form-signin-heading">教师注册</h3>
        </div>
        <div class="row">
	        <div class="col-xs-4 col-md-4 text-right">
	        	<label>用户名：</label>
	        </div>
	        <div class="col-xs-8 col-md-8 text-left">
	        	<input type="text" id="username" class="form-control" placeholder="用户名" required autofocus>
	        </div>
        </div>
      	<div class="row">
	        <div class="col-xs-4 col-md-4 text-right">
	        	<label>密码：</label>
	        </div>
	        <div class="col-xs-8 col-md-8 text-left">
	        	<input type="password" id="password" class="form-control" placeholder="密码" required>
	        </div>
        </div>
        <div class="row">
	        <div class="col-xs-4 col-md-4 text-right">
	        	<label>真实姓名：</label>
	        </div>
	        <div class="col-xs-8 col-md-8 text-left">
	        	<input type="text" id="name" class="form-control" placeholder="真实姓名" required>
	        </div>
        </div>
        <div class="row">
	        <div class="col-xs-4 col-md-4 text-right">
	        	<label>手机号：</label>
	        </div>
	        <div class="col-xs-8 col-md-8 text-left">
	        	<input type="text" id="phone" class="form-control" placeholder="手机号" required>
	        </div>
        </div>
        <div class="row">
	        <div class="col-xs-4 col-md-4 text-right">
	        	<label>邮箱：</label>
	        </div>
	        <div class="col-xs-8 col-md-8 text-left">
	        	<input type="text" id="email" class="form-control" placeholder="邮箱" required>
	        </div>
	    </div>
	    
        <div class="row">
	        <div class="col-xs-4 col-md-4 text-right">
	        	<label>所属学校：</label>
	        </div>
	        <div class="col-xs-8 col-md-8 text-left">
	        		<select id=slctschool class="form-control" onchange="selectOnchang(this)" style="width:200px;">
						<option value="all">请选择</option>
					</select>	    	
			</div>
	    </div>
	    
        <div class="row text-center">
	        <div class="col-xs-4 col-md-4">
	        	<button class="btn btn-lg btn-info btn-block" type="button" id="regist">取消</button>
	        </div>
	        <div class="col-xs-4 col-md-4">
	        	<button class="btn btn-lg btn-info btn-block student" type="button" id="submit">注册</button>
	        </div>
        </div>
    </div> 
    <!-- /container -->
    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script  src="js/jquery-1.12.0.min.js"></script>
	<script  src="js/bootstrap.min.js"></script>
	<script  src="js/common.js"></script>
	<script type="text/javascript">
	$(document).ready(function(){  
		getSchool();
	});
	
	function getSchool(){
		$.ajax({
    		url:"/homework/t/school/getinfo.do",
    		data:{
    		},
    		type:'get',
    		dataType:'json',
    		success:function(data){
    			if(data.code ==99999){
    				var array = data.array;
    				var slctI = $('#slctschool');
    				for(var i = 0;i<array.length;i++){
    					var a =array[i];
    						slctI.append("<option value='"+a.id+"'>"+a.schoolname+"</option>");
    							
    				}
    			} else if(data.code == 505) {
    				alertModalMessage("服务器发生异常，请联系管理员");
    			} else {
    				alertModalMessage("未查询到学校信息信息");
    			}
    		}
    		});
	}
	$("#submit").click(function(e){
		var username = $("#username").val();
		var password = $("#password").val();
		var name = $("#name").val();
		var phone = $("#phone").val();
		var email = $("#email").val();
		var schoolid = $("#slctschool").find("option:selected").val();
		$.ajax({
    		url:"/user/regist/teacher.do",
    		data:{
    			username:username,
    			password:password,
    			name:name,
    			phone:phone,
    			email:email,
    			school_id:schoolid
    		},
    		type:'post',
    		dataType:'json',
    		success:function(data){
    			if(data.code ==99999){
    				alert("注册成功");
    				window.location.href="/login.jsp";
    			} else if(data.code == 505) {
    				alertModalMessage("服务器发生异常，请联系管理员");
    			} else {
    				alertModalMessage("未查询到学校信息信息");
    			}
    		}
    		});
	});
	function selectOnchang(obj){ 
		var value = obj.options[obj.selectedIndex].value;
		//alert(value);
		};
	</script>
	<%@ include  file='component/MessageModal.jsp'%>
</body>
</html>