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
<title>测验与作业</title>
</head>
<body>
	<!-- 页头导航栏 -->
	<%@ include  file='/component/header_student.jsp'%>
	
    <div class="container-fluid">
    	<div class="row">
       		<div class="col-sm-3 col-md-2 sidebar">
          	<ul class="nav nav-pills nav-tabs nav-stacked"  id="myTabs" role="tablist">
		    			<li role="presentation" class="active privilege"><a href="#stuClass " role="tab" id="class-tab" data-toggle="tab" aria-controls="stuClass" aria-expanded="false">作业列表</a></li>      
			</ul>
        </div>
		<div class="col-sm-9 col-md-10 main">
    		<div id="myTabContent" class="tab-content">
		    		<div role="tabpanel" class="tab-pane active in fade privilege" id="stuClass" aria-labelledby="class-tab">
					<jsp:include page="/component/homework/s_homework_do.jsp"></jsp:include>
				</div>
		    </div>
          </div>
        </div>
    </div> <!-- /container -->


    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script  src="/js/jquery-1.12.0.js"></script>
	<script  src="/js/bootstrap.min.js"></script>
	<script  src="/js/bootstrap-paginator.js"></script>
	<script  src="/js/moment.min.js"></script>
	<script  src="/js/common.js"></script>
	<script  src="/js/vue.js"></script>
	<%@ include  file='/component/MessageModal.jsp'%>
	<script type="text/javascript">
	Vue.filter('moment', function (value, formatString) {
	    formatString = formatString || 'YYYY-MM-DD HH:mm:ss';
	    return moment(value).format(formatString);
	});
	</script>
	<script type="text/javascript">
	$('#myTabs a').click(function (e) {
		  e.preventDefault();
		  $(this).tab('show');
		})
	$(document).ready(function(){  
		$('#classHomework').attr("class","active");
		$('#personalCenter').removeClass("active");
	}) ;

	var homeworkTbl = new Vue({
		el:"#homeworkTbody",
		data:{
			homeworks:[]
		},
		mounted:function(){
			$.ajax({
				url:"/homework/s/getClassHomework.do",
				data:{
				},
				type:'post',
				datatype:'json',
				success:function(data){
					var jsonResult = eval("("+data+")");
					homeworkTbl.homeworks = jsonResult.array;
				}
			});
		},
		methods:{
			doHomework:function(id,index){
				alert(id+";"+index);
			}
		}
	});
	</script>
</body>
</html>