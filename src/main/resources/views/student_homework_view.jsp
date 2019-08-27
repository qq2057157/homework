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
<title>查看作业</title>
<style type="text/css">
.ok{
	color:#00FF00
}
.error{
	color:#FF0000
}
</style>
</head>
<body>
	<!-- 页头导航栏 -->
	<%@ include  file='/component/header_student.jsp'%>
	
    <div class="container-fluid">
   	<%@ include  file='/component/homework/s_homework_view.jsp'%>
    </div> <!-- /container -->


    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script  src="/js/jquery-1.12.0.js"></script>
	<script  src="/js/bootstrap.min.js"></script>
	<script  src="/js/bootstrap-paginator.js"></script>
	<script  src="/js/common.js"></script>
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
		var hid = "${id}";
		

		var tbl = new Vue({
			el:"#htbl",
			data:{
				id:hid,
				choices_new:[{'id':null,'number':'0','question':null,'choice_a':'','choice_b':'','choice_c':'','choice_d':'','answer':'','student_answer':'','score':5}],
				fillblanks_new:[{'id':null,'question':null,'answer':null,'student_answer':'','score':5}],
				saqs_new:[{'id':null,'question':null,'key_word':null,'student_answer':'','score':10}]
			},
			mounted:function(){
						$.ajax({
				            type: 'post',
				            url: "/homework/s/homeworkChoicesList.do",
				            data:{
				            		id:this.id
				            },
				            datatype:"json",
				            success: function (data) {
					            	var dataJson = eval("(" + data +")");
					            	tbl.choices_new = dataJson.array;
				            }
				    	});
						
						$.ajax({
				            type: 'post',
				            url: "/homework/s/homeworkFbList.do",
				            data:{
				            		id:this.id
				            },
				            datatype:"json",
				            success: function (data) {
					            	var dataJson = eval("(" + data +")");
					            	tbl.fillblanks_new = dataJson.array;
				            }
				    		});
						$.ajax({
				            type: 'post',
				            url: "/homework/s/homeworkSAQList.do",
				            data:{
				            		id:this.id
				            },
				            datatype:"json",
				            success: function (data) {
					            	var dataJson = eval("(" + data +")");
					            	tbl.saqs_new = dataJson.array;
				            }
				    	})
				},
				methods:{
					
						
					}
			});
	</script>
</body>
</html>