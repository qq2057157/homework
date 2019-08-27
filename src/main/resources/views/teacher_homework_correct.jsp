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
</head>
<body>
	<!-- 页头导航栏 -->
	<%@ include  file='/component/header_student.jsp'%>
	
    <div class="container-fluid">
   	<%@ include  file='/component/homework/t_homework_correct.jsp'%>
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
		var hid = "${homework_id}";
		var sid = "${student_id}";

		var tbl = new Vue({
			el:"#htbl",
			data:{
				id:hid,
				saqs_new:[{'id':null,'question':null,'key_word':null,'student_answer':'','score':10}]
			},
			mounted:function(){
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
					teacherCorrect:function(){
						var questionIds = [];
						var scores =[];
						for (var i = 0; i < tbl.saqs_new.length; i++) {
							questionIds[i] = tbl.saqs_new[i].id;
							scores[i] = tbl.saqs_new[i].student_score;
						}
						$.ajax({
				            type: 'post',
				            url: "/homework/t/correctStudentAnwser.do",
				            data:{
				            		homework_id:this.id,
				            		student_id:sid,
				            		questionIds:questionIds,
				            		scores:scores
				            },
				            traditional:true,
				            datatype:"json",
				            success: function (data) {
					            	var dataJson = eval("(" + data +")");
					            	if(dataJson.code==99999){
					            		alert("批改成功!");
					            	}
					            
				            }
				    	})
					}
				}
			});
	</script>
</body>
</html>