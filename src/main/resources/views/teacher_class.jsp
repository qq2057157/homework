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

<title>班级管理</title>
</head>
<body>
	<!-- 页头导航栏 -->
	<%@ include  file='/component/header_teacher.jsp'%>
	
    <div class="container-fluid">
    	<div class="row">
       		<div class="col-sm-3 col-md-2 sidebar">
	          	<ul class="nav nav-pills nav-tabs nav-stacked"  id="myTabs" role="tablist">
			    			<li role="presentation" class="active privilege"><a href="#stuClass " role="tab" id="class-tab" data-toggle="tab" aria-controls="stuClass" aria-expanded="false">查看班级</a></li>      
							<li role="presentation" class="privilege institute"><a href="#stuDepartment" id="changeDepart" role="tab" id="department-tab" data-toggle="tab" aria-controls="stuDepartment" aria-expanded="true">学生管理</a></li>      
	      		</ul>
	        </div>
			<div class="col-sm-9 col-md-10 main">
	    		<div id="myTabContent" class="tab-content">
		<div role="tabpanel" class="tab-pane active in fade privilege" id="stuClass" aria-labelledby="class-tab">
						       <h2 class="sub-header">班级管理</h2>

          <div class="table-responsive">
          <div class="row  bottom-border">
          	<div class="col-sm-6 col-sm-6" >
          		<button id="add_class" type="button" class="btn btn-info"  data-target="#addClassModal"  data-toggle="modal" role="button">新增班级</button>
          	</div>
          	<div class="col-sm-6 col-sm-6" >
          	</div>
          </div>
          	<div id ="tbl" >
	         	<table id="stuTbl" class="table table-striped table-bordered table-condensed">
		 	  		<thead>
		 	  			<tr>
		 	  				<th>班级名称</th>
							<th>班级密码</th>
							<th>学校</th>
							<th>任课教师</th>
							<th>操作</th>
						</tr>
						
					</thead>
					<tbody id="stuTbody" class="changes">
						<template v-for="classm in classes">
							<tr>
			 	  				<td>{{ classm.class_name }}</td>
								<td>{{ classm.class_password }}</td>
								<td>{{ classm.school_name }}</td>
								<td>{{ classm.teacher_id }}</td>
								<td><a class="btn btn-info">修改密码</a></td>
							</tr>
						</template>
					</tbody>
				</table>
				 <div class="row text-center">
				 	<ul id='paginator' style="cursor:hand;"></ul>
				 </div>
			</div>
          </div>
					</div>
					<div role="tabpanel" class="tab-pane fade privilege institute" id="stuDepartment" aria-labelledby="department-tab">
						        <jsp:include page="/component/homework/t_class_stu.jsp"></jsp:include>		      
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
	<script src="/js/vue.js"></script>
	<script  src="/js/common.js"></script>
	<%@ include  file='/component/MessageModal.jsp'%>
	<%@ include  file='/component/homework/t_class_add.jsp'%>
	<script type="text/javascript">
	$('#myTabs a').click(function (e) {
		  e.preventDefault();
		  $(this).tab('show');
		})
	$(document).ready(function(){  
		$('#classManege').attr("class","active");
		$('#homeworkManage').removeClass("active");
		$('#questionManege').removeClass("active");
	}) ;
	var addclass = new Vue({
		el:'#addClassModal',
		data:{
			classname:'',
			classpassword:''
		},
		 methods:{
			 addclass:function(event){
				 if(isEmpty(this.classname)){
					 alertModalMessage("班级名称不能为空");
				 } else if(isEmpty(this.classpassword)){
					 alertModalMessage("班级密码不能为空");
				 } else {
					 $.ajax({
			 	            type: 'get',
			 	            url: "/homework/t/school/addclass.do",
			 	            data:{
			 	            	class_name:this.classname,
			 	            	class_password:this.classpassword
			 	            	},
			 	            datatype:"json",
			 	            success: function (data) {
			 	            	var dataJson = eval("(" + data +")");
			 	            	alert(dataJson.info);
			 	            	}
			 	    		}) 
				 }
				 
			 	}
			} 
		});
	
	var tbl = new Vue({
		el:'#tbl',
		data:{
			classes:[],
			currentPage:1,
			sumNum:0,
			pageSize:3
		},
		mounted: function () {
            this.$nextTick(function () {
                $.ajax({
    	            type: 'post',
    	            url: "/homework/t/school/getclassinfobypage.do",
    	            data:{
    	            	currentPage:this.currentPage
    	            },
    	            datatype:"json",
    	            success: function (data) {
    	            	var dataJson = eval("(" + data +")");
    	            	tbl.classes = dataJson.array;
    	            	tbl.currentPage = dataJson.pageInfo.currentPage;
    	            	tbl.sumNum = dataJson.pageInfo.sumNum;
    	            	tbl.pageSize = dataJson.pageInfo.pageSize;
    	            	setPaginator();
    	            }
    	    })
            });
          }
	});
	//专业调整页面异步刷新方法
	function setPaginator(){
		var sumNum = tbl.sumNum; //取到pageCount的值(把返回数据转成object类型)
		var currentPage = tbl.currentPage; //得到urrentPage
		var pageSize = tbl.pageSize; //得到urrentPage
		
		//alert(sumNum+","+currentPage+","+pageSize);
		if(sumNum==null ||sumNum==''|| sumNum==0){
			sumNum=1;
		}
		if(currentPage==null ||currentPage==''){
			currentPage =1;
		}
		if(pageSize==null ||pageSize==''){
			pageSize =1;
		} 
		var element = $("#paginator");//获得数据装配的位置
		//初始化所需数据
		var options = {
		    bootstrapMajorVersion:3,//版本号。3代表的是第三版本
		    currentPage: currentPage,//当前页数
		    numberOfPages: 5, //显示页码数标个数
		    totalPages:Math.ceil(sumNum/pageSize), //总共的数据所需要的总页数
		    itemTexts: function (type, page, current) {  
		    		//图标的更改显示可以在这里修改。
		    switch (type) {  
		            case "first":  
		                return "首页";  
		            case "prev":  
		                return "上一页";  
		            case "next":  
		                return "下一页";  
		            case "last":  
		                return "末页";  
		            case "page":  
		                return  page;  
		        }                 
		    }, 
	    tooltipTitles: function (type, page, current) {
			//如果想要去掉页码数字上面的预览功能，则在此操作。例如：可以直接return。
	        switch (type) {
	            case "first":
	                return "Go to first page";
	            case "prev":
	                return "Go to previous page";
	            case "next":
	                return "Go to next page";
	            case "last":
	                return "Go to last page";
	            case "page":
	                return (page === current) ? "Current page is " + page : "Go to page " + page;
	        }
	    },
	    onPageClicked: function (event, originalEvent, type, page) {
	    	$.ajax({
	            type: 'get',
	            url: "/homework/t/school/getclassinfobypage.do",
	            data:{
	            	currentPage:page
	            },
	            datatype:"json",
	            success: function (data) {
	            	var dataJson = eval("(" + data +")");
	            	tbl.classes = dataJson.array;
	            	tbl.currentPage = dataJson.pageInfo.currentPage;
	            	tbl.sumNum = dataJson.pageInfo.sumNum;
	            	tbl.pageSize = dataJson.pageInfo.pageSize;
	            }
	   		})
			}// end onClickfunction
		};//end option
		element.bootstrapPaginator(options);	//进行初始化
	}
	</script>

	<script type="text/javascript">
		var stutbl = new Vue({
			el:'#stu-tbl',
			data:{
				students:[],
				classes:[],
				class_id:-1,
				currentPage:1,
				sumNum:0,
				pageSize:3
			},
			mounted: function () {
				$.ajax({
		            type: 'get',
		            url: "/homework/t/school/getclassinfo.do",
		            data:{
		            },
		            datatype:"json",
		            success: function (data) {
		            	var dataJson = eval("(" + data +")");
		            	stutbl.classes = dataJson.array;
		            	stutbl.currentPage = dataJson.pageInfo.currentPage;
		            	stutbl.sumNum = dataJson.pageInfo.sumNum;
		            	stutbl.pageSize = dataJson.pageInfo.pageSize;
		            }
		   		})
	          },
	          methods:{
	        	  getStudents:function(ele){
	        		  stutbl.class_id = ele.target.value;
	        		  $.ajax({
		    	            type: 'get',
		    	            url: "/homework/t/school/getstudentsbyclass.do",
		    	            data:{
		    	            	class_id:stutbl.class_id
		    	            },
		    	            datatype:"json",
		    	            success: function (data) {
		    	            	var dataJson = eval("(" + data +")");
		    	            	stutbl.students = dataJson.array;
		    	            	stutbl.currentPage = dataJson.pageInfo.currentPage;
		    	            	stutbl.sumNum = dataJson.pageInfo.sumNum;
		    	            	stutbl.pageSize = dataJson.pageInfo.pageSize;
		    	            	setStuPaginator();
		    	            }
		    	    })
	        	  }
	          }
		});
		
		//专业调整页面异步刷新方法
		function setStuPaginator(){
			var sumNum = stutbl.sumNum; //取到pageCount的值(把返回数据转成object类型)
			var currentPage = stutbl.currentPage; //得到urrentPage
			var pageSize = stutbl.pageSize; //得到urrentPage
			
			//alert(sumNum+","+currentPage+","+pageSize);
			if(sumNum==null ||sumNum==''|| sumNum==0){
				sumNum=1;
			}
			if(currentPage==null ||currentPage==''){
				currentPage =1;
			}
			if(pageSize==null ||pageSize==''){
				pageSize =1;
			} 
			var element = $("#stupaginator");//获得数据装配的位置
			//初始化所需数据
			var options = {
			    bootstrapMajorVersion:3,//版本号。3代表的是第三版本
			    currentPage: currentPage,//当前页数
			    numberOfPages: 5, //显示页码数标个数
			    totalPages:Math.ceil(sumNum/pageSize), //总共的数据所需要的总页数
			    itemTexts: function (type, page, current) {  
			    		//图标的更改显示可以在这里修改。
			    switch (type) {  
			            case "first":  
			                return "首页";  
			            case "prev":  
			                return "上一页";  
			            case "next":  
			                return "下一页";  
			            case "last":  
			                return "末页";  
			            case "page":  
			                return  page;  
			        }                 
			    }, 
		    tooltipTitles: function (type, page, current) {
				//如果想要去掉页码数字上面的预览功能，则在此操作。例如：可以直接return。
		        switch (type) {
		            case "first":
		                return "Go to first page";
		            case "prev":
		                return "Go to previous page";
		            case "next":
		                return "Go to next page";
		            case "last":
		                return "Go to last page";
		            case "page":
		                return (page === current) ? "Current page is " + page : "Go to page " + page;
		        }
		    },
		    onPageClicked: function (event, originalEvent, type, page) {
		    	$.ajax({
		            type: 'get',
		            url: "/homework/t/school/getstudentsbyclass.do",
		            data:{
		            	currentPage:page,
		            	class_id:stutbl.class_id
		            },
		            datatype:"json",
		            success: function (data) {
		            	var dataJson = eval("(" + data +")");
		            	stutbl.students = dataJson.array;
		            	stutbl.currentPage = dataJson.pageInfo.currentPage;
		            	stutbl.sumNum = dataJson.pageInfo.sumNum;
		            	stutbl.pageSize = dataJson.pageInfo.pageSize;
		            }
		    })
				}// end onClickfunction
			};//end option
			element.bootstrapPaginator(options);	//进行初始化
		}
	</script>
</body>
</html>