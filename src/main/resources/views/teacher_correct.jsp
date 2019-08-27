<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
<link rel="stylesheet" href="/css/bootstrap.min.css"/>
<link rel="stylesheet" href="/css/bootstrap.css.map"/>
<link rel="stylesheet" href="/css/bootstrap-theme.min.css"/>
<link rel="stylesheet" href="/css/bootstrap-theme.css.map"/>
<link rel="stylesheet" href="/css/bootstrap-datetimepicker.min.css"/>
<title>作业批改</title>
</head>
<body>
	<!-- 页头导航栏 -->
	<%@ include  file='/component/header_teacher.jsp'%>
	
    <div class="container-fluid">
 			<div class="form-horizontal">
			<table class="table table-striped table-bordered table-condensed">
			<thead>
		 	  			<tr>
		 	  				<th>学生姓名</th>
							<th>是否完成</th>
							<th>学生得分</th>
							<th>操作</th>
						</tr>
					</thead>
					<tbody id="studentHomeworkTbody" class="changes">
						<template v-for="(item,index) in students">
							<tr>
								<td>
									{{item.name}}
								</td>
								<td>
									<p v-if="item.homework.status>0">
										已完成
									</p>
									<p v-else>
										未完成
									</p>
								</td>
								<td>
									{{item.homework.score}}
								</td>
								<td>
									<a class="btn btn-info" v-on:click="toCorrect(item.id)" v-if="item.homework.status>0">去批改</a>
								</td>
							</tr>
						</template>
					</tbody>
			</table>
			</div>
			<div class="text-center">
						   		<a id="addChoice" class="btn btn-info" href="javascript:history.go(-1)">返回</a>
						   	</div>
    </div> <!-- /container -->


    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script  src="/js/jquery-1.12.0.js"></script>
	<script  src="/js/bootstrap.min.js"></script>
	<script  src="/js/bootstrap-paginator.js"></script>
	<script  src="/js/bootstrap-datetimepicker.min.js"></script>
	<script  src="/js/locales/bootstrap-datetimepicker.zh-CN.js"></script>
	<script  src="/js/common.js"></script>
	<script  src="/js/moment.min.js"></script>
	<script  src="/js/vue.js"></script>
	<%@ include  file='/component/MessageModal.jsp'%>
	<script type="text/javascript">
	$('#myTabs a').click(function (e) {
		  e.preventDefault();
		  $(this).tab('show');
		})
		
	$(document).ready(function(){  
			$('#top-bar').remove();
	
	}) ;
	var hid = "${homework_id}";
	var cid = "${class_id}";
	var correcttbl = new Vue({
		el:"#studentHomeworkTbody",
		data:{
			students:[]
		},
		mounted:function(){
			$.ajax({
	            type: 'post',
	            url: "/homework/t/getStudentHomeworkByClass.do",
	            data:{
	           		class_id:cid,
	           		homework_id:hid
	            },
	            datatype:"json",
	            success: function (data) {
	            	var dataJson = eval("(" + data +")");
	            		correcttbl.students = dataJson.array;
	            }
	    	})

		},
		methods:{
			toCorrect:function(id){
				document.location="/homework/t/correctStudent.do?student_id="+id+"&homework_id="+hid;
			}
		}
	});

	</script>
</body>
</html>