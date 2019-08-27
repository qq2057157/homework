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
<title>学生注册</title>
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
    <div id="login" class="container">
    	<div class="row ">
	         <h3 class="form-signin-heading">学生注册</h3>
        </div>
        <div class="row">
	        <div class="col-xs-4 col-md-4 text-right">
	        	<label>用户名：</label>
	        </div>
	        <div class="col-xs-8 col-md-8 text-left">
	        	<input type="text" id="username" class="form-control" v-model="username" placeholder="用户名(必填)" required autofocus>
	        </div>
        </div>
      	<div class="row">
	        <div class="col-xs-4 col-md-4 text-right">
	        	<label>密码：</label>
	        </div>
	        <div class="col-xs-8 col-md-8 text-left">
	        	<input type="password" id="password" class="form-control" v-model="password" placeholder="密码(必填)" required>
	        </div>
        </div>
        <div class="row">
	        <div class="col-xs-4 col-md-4 text-right">
	        	<label>真实姓名：</label>
	        </div>
	        <div class="col-xs-8 col-md-8 text-left">
	        	<input type="text" id="name" class="form-control" v-model="name" placeholder="真实姓名(必填)" required>
	        </div>
        </div>
        <div class="row">
	        <div class="col-xs-4 col-md-4 text-right">
	        	<label>手机号：</label>
	        </div>
	        <div class="col-xs-8 col-md-8 text-left">
	        	<input type="text" id="phone" class="form-control" v-model="phone" placeholder="手机号(必填)" required>
	        </div>
        </div>
        <div class="row">
	        <div class="col-xs-4 col-md-4 text-right">
	        	<label>邮箱：</label>
	        </div>
	        <div class="col-xs-8 col-md-8 text-left">
	        	<input type="text" id="email" class="form-control" v-model="email" placeholder="邮箱(必填)" required>
	        </div>
	    </div>
	    
        <div class="row">
	        <div class="col-xs-4 col-md-4 text-right">
	        	<label>所属学校：</label>
	        </div>
	        <div class="col-xs-8 col-md-8 text-left">
	        		<select id="slctschool" class="form-control" v-on:change="selectSchool" style="width:200px;">
						<option value="">请选择</option>
						<template v-for="school in school_info">
							<option v-bind:value="school.id">{{school.schoolname}}</option>
						</template>
					</select>	    	
			</div>
	    </div>
	    <div class="row">
	        <div class="col-xs-4 col-md-4 text-right">
	        	<label>所属班级：</label>
	        </div>
	        <div class="col-xs-8 col-md-8 text-left">
	        		<select id="slctclass" class="form-control" v-on:change="selectClass" style="width:200px;">
						<option value="">请选择</option>
						<template v-for="classm in class_info">
							<option v-bind:value="classm.id">{{classm.class_name}}</option>
						</template>
					</select>	    	
			</div>
	    </div>
	    <div class="row">
	        <div class="col-xs-4 col-md-4 text-right">
	        	<label>班级密码：</label>
	        </div>
	        <div class="col-xs-8 col-md-8 text-left">
	        		<input type="text" id="class_password" class="form-control" v-model="class_password" placeholder="班级密码(必填)" required>
    	
			</div>
	    </div>
        <div class="row text-center">
	        <div class="col-xs-4 col-md-4">
	        	<button class="btn btn-lg btn-info btn-block" type="button" id="regist" onclick="history.go(-1)">返回</button>
	        </div>
	        <div class="col-xs-4 col-md-4">
	        	<button class="btn btn-lg btn-info btn-block student" type="button" v-on:click="studentRegister" id="submit">注册</button>
	        </div>
        </div>
    </div> 
    <!-- /container -->
    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script  src="js/jquery-1.12.0.min.js"></script>
	<script  src="js/bootstrap.min.js"></script>
	<script src="/js/vue.js"></script>
	<script  src="js/common.js"></script>
	<script type="text/javascript">
	$(document).ready(function(){  
		//getSchool();
	});
	
	var login = new Vue({
		el:'#login',
		data:{
			
			username:'',
			password:'',
			name:'',
			phone:'',
			email:'',
			school_id:-1,
			class_id:-1,
			school_info:[],
			class_info:[],
			class_password:''
		},
		mounted:function(event){
			this.$nextTick(function () {
				$.ajax({
		            type: 'get',
		            url: "/homework/t/school/getinfo.do",
		            data:{
		            },
		            datatype:"json",
		            success: function (data) {
		            	var dataJson = eval("(" + data +")");
		            	login.school_info = dataJson.array;
		            }
		   		});
			});
		},
		methods:{
			selectSchool: function(ele) {
	            login.school_id = ele.target.value;
	            login.class_info = [];
	            $.ajax({
		            type: 'get',
		            url: "/homework/t/school/getclassinfo.do",
		            data:{
		            	school_id:login.school_id
		            },
		            datatype:"json",
		            success: function (data) {
		            	var dataJson = eval("(" + data +")");
		            	login.class_info = dataJson.array;
		            }
		   		});
	        },
	        selectClass: function(ele) {
	            login.class_id = ele.target.value;
	            
	        },
	        studentRegister:function(event){
	        	if(isEmpty(login.username) 
	        			||isEmpty(login.username) 
	        			||isEmpty(login.password) 
	        			||isEmpty(login.name) 
	        			||isEmpty(login.phone)
	        			||isEmpty(login.phone)
	        			||isEmpty(login.email)
	        			||isEmpty(login.class_password)
	        			||login.school_id<0
	        			||login.class_id<0){
	        		//todo
	        		alertModalMessage("注册信息不能为空！");
	        	} else {
	        		$.ajax({
	            		url:"/user/regist/student.do",
	            		data:{
	            			username:login.username,
	            			password:login.password,
	            			name:login.name,
	            			phone:login.phone,
	            			email:login.email,
	            			school_id:login.school_id,
	            			class_id:login.class_id,
	            			class_password:login.class_password
	            		},
	            		type:'get',
	            		dataType:'json',
	            		success:function(data){
	            			if(data.code ==99999){
	            				alert("注册成功");
	            				window.location.href="/login.jsp";
	            			} else if(data.code == 505) {
	            				alertModalMessage("服务器发生异常，请联系管理员");
	            			} else {
	            				alertModalMessage(data.info);
	            			}
	            		}
	            	});
	        		
	        	}
	        }
			
		}
	});

	function selectOnchang(obj){ 
		var value = obj.options[obj.selectedIndex].value;
		//alert(value);
		};
	</script>
	<%@ include  file='component/MessageModal.jsp'%>
</body>
</html>