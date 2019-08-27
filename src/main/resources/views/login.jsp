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

<title>中小学语文在线作业系统</title>
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
     <form class="form-signin">
      	<ul class="nav nav-tabs" role="tablist">
    	<li role="presentation" class="active"><a href="#stutbl" aria-controls="stutbl" role="tab" data-toggle="tab">学生登录</a></li>
    	<li role="presentation"><a href="#teatbl" aria-controls="teatbl" role="tab" data-toggle="tab">教师登录</a></li>
  		</ul>

  <!-- Tab panes -->
  <div class="tab-content">
    <div role="tabpanel" class="tab-pane active" id="stutbl">
        <h3 class="form-signin-heading">学生登录</h3>
        <label for="inputUsername" class="sr-only">用户名</label>
        <input type="text" id="username" class="form-control student" placeholder="请输入学生账号" required autofocus>
        <label for="inputPassword" class="sr-only">密码</label>
        <input type="password" id="password" class="form-control student" placeholder="请输入密码" required>
        <div class="checkbox">
          <label>
            <input type="checkbox" value="remember-me"> 记住密码
          </label>
        </div>
        <div class="row">
        <div class="col-xs-6 col-md-6">
        	<a  class="btn btn-lg btn-info btn-block" href="/student_register.jsp">注册</a>
        </div>
        <div class="col-xs-6 col-md-6">
        	<button class="btn btn-lg btn-info btn-block student" type="button" id="submit">登录</button>
        </div>
        </div>
      </div>
    <div role="tabpanel" class="tab-pane" id="teatbl">
        <h3 class="form-signin-heading">教师登录</h3>
        <label for="inputUsername" class="sr-only">用户名</label>
        <input type="text" id="username" class="form-control teacher" placeholder="请输入教师账号" required autofocus>
        <label for="inputPassword" class="sr-only">密码</label>
        <input type="password" id="password" class="form-control teacher" placeholder="请输入密码" required>
        <div class="checkbox">
          <label>
            <input type="checkbox" value="remember-me"> 记住密码
          </label>
        </div>
        <div class="row">
        <div class="col-xs-6 col-md-6">
        <a  class="btn btn-lg btn-info btn-block" href="/teacher_register.jsp">注册</a>
        </div>
        <div class="col-xs-6 col-md-6">
        	<button class="btn btn-lg btn-info btn-block teacher" type="button" id="submit">登录</button>
        </div>      
        </div>
      </form>
  </div>
 

    </div> <!-- /container -->
    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script  src="js/jquery-1.12.0.min.js"></script>
	<script  src="js/bootstrap.min.js"></script>
	<script  src="js/common.js"></script>
	<script type="text/javascript">
	// 教师登录提交按钮
	$("#submit.teacher").click(function()
		{	
			$.ajax({
	    		url:"user/login/teacher.do",
	    		data:{
	    			username:$("#username.teacher").val(),
	    			password:$("#password.teacher").val()
	    		},
	    		type:'post',
	    		dataType:'json',
	    		success:function(data){
	    			
	    			if(data.code ==99999){
	    				alertModalMessage("登录成功");
	    				location.href = '/homework/t/homework.do';
	    			} else if(data.code == 505){
	    				alertModalMessage(data.info);
	    			} else {
	    				alertModalMessage(data.info);
	    			}
	    		}
	    		});
			// ajax end;
	    });
	
	// 学生登录提交按钮
	$("#submit.student").click(function()
		{	
			$.ajax({
	    		url:"/user/login/student.do",
	    		data:{
	    			username:$("#username.student").val(),
	    			password:$("#password.student").val()
	    		},
	    		type:'post',
	    		dataType:'json',
	    		success:function(data){
	    			
	    			if(data.code ==99999){
	    				alertModalMessage("登录成功");
	    				location.href = '/homework/s/personal.do';
	    			} else if(data.code == 505){
	    				alertModalMessage(data.info);
	    			} else {
	    				alertModalMessage(data.info);
	    			}
	    		}
	    		});
			// ajax end;
	    });
	$('#myTabs a').click(function (e) {
		  e.preventDefault()
		  $(this).tab('show')
		})
	$('#myTabs a[href="#teatbl"]').tab('show') // Select tab by name
$('#myTabs a:first').tab('show') // Select first tab
$('#myTabs a:last').tab('show') // Select last tab
$('#myTabs li:eq(2) a').tab('show') // Select third tab (0-indexed)
	</script>
	<%@ include  file='component/MessageModal.jsp'%>
</body>
</html>