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
<title>题库管理</title>
</head>
<body>
	<!-- 页头导航栏 -->
	<%@ include  file='/component/header_teacher.jsp'%>
	
    <div class="container-fluid">
    	<div class="row">
       		<div id ="tab-btn" class="col-sm-3 col-md-2 sidebar">
	          	<ul class="nav nav-pills nav-tabs nav-stacked"  id="myTabs" role="tablist">
			    			<li role="presentation" class="active"><a href="#choice " role="tab" id="class-tab" data-toggle="tab" aria-controls="class-tab" aria-expanded="false">选择题</a></li>      
							<li role="presentation" class=""><a href="#fillBlanks" id="changeDepart" role="tab" id="department-tab" data-toggle="tab" aria-controls="changeDepart" aria-expanded="true" v-on:click="goFillBlanks">填空题</a></li>      
							<li role="presentation" class=""><a href="#SAQ_content" id="saq" role="tab" id="department-tab" data-toggle="tab" aria-controls="SAQ_content" aria-expanded="true" v-on:click="goSAQ">简答题</a></li>      
	      		</ul>
	        </div>
			<div class="col-sm-9 col-md-10 main">
	    		<div id="myTabContent" class="tab-content">
			    	<div role="tabpanel" class="tab-pane active in fade privilege" id="choice" aria-labelledby="class-tab">
						       <jsp:include page="/component/homework/t_question_choice.jsp"></jsp:include>
					</div>
					<div role="tabpanel" class="tab-pane fade privilege institute" id="fillBlanks" aria-labelledby="department-tab">
						        <jsp:include page="/component/homework/t_question_fillblank.jsp"></jsp:include>		      
					</div>	
					<div role="tabpanel" class="tab-pane fade privilege institute" id="SAQ_content" aria-labelledby="department-tab">
						        <jsp:include page="/component/homework/t_question_saq.jsp"></jsp:include>		      
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
	<script  src="/js/common.js"></script>
	<script src="/js/vue.js"></script>
	<%@ include  file='/component/MessageModal.jsp'%>
	<script type="text/javascript">
	 var tab = new Vue({
	 	el:"#tab-btn",
	 	data:{
	 		
	 	},
	 	methods:{
		 		goFillBlanks:function(){
		 			$.ajax({
			            type: 'post',
			            url: "/homework/t/question/getfillblanksinfo.do",
			            data:{
			            	currentPage:this.currentPage
			            },
			            datatype:"json",
			            success: function (data) {
			            	var dataJson = eval("(" + data +")");
			            	fbtbl.fillblanks = dataJson.array;
			            	fbtbl.currentPage = dataJson.pageInfo.currentPage;
			            	fbtbl.sumNum = dataJson.pageInfo.sumNum;
			            	fbtbl.pageSize = dataJson.pageInfo.pageSize;
			            	setFbPaginator();
			            }
			    	})
		 		},
			 	goSAQ:function(){
			 		$.ajax({
			            type: 'get',
			            url: "/homework/t/question/getsaqinfo.do",
			            data:{
			            	currentPage:this.currentPage
			            },
			            datatype:"json",
			            success: function (data) {
			            	var dataJson = eval("(" + data +")");
			            	saqtbl.saqs = dataJson.array;
			            	saqtbl.currentPage = dataJson.pageInfo.currentPage;
			            	saqtbl.sumNum = dataJson.pageInfo.sumNum;
			            	saqtbl.pageSize = dataJson.pageInfo.pageSize;
			            	setSAQPaginator();
			            }
		    		})
			 	}
	 	}
	 })
	</script>
	<script type="text/javascript">
	$('#myTabs a').click(function (e) {
		  e.preventDefault();
		  $(this).tab('show');
		})
	$(document).ready(function(){  
		$('#questionManege').attr("class","active");
		$('#classManage').removeClass("active");
		$('#homeworkManage').removeClass("active");
	}) ;

	var choice = new Vue({
		el:"#choice_tbl",
		data:{
			choices:[],
			currentPage:1,
			sumNum:0,
			pageSize:3
		},
		mounted: function () {
			$.ajax({
	            type: 'post',
	            url: "/homework/t/question/getchoicesinfo.do",
	            data:{
	            	currentPage:this.currentPage
	            },
	            datatype:"json",
	            success: function (data) {
	            	var dataJson = eval("(" + data +")");
	            	choice.choices = dataJson.array;
	            	choice.currentPage = dataJson.pageInfo.currentPage;
	            	choice.sumNum = dataJson.pageInfo.sumNum;
	            	choice.pageSize = dataJson.pageInfo.pageSize;
	            	setCPaginator();
	            }
	    })
		}
	});
	
	//单选题页面异步刷新方法
	function setCPaginator(){
		var sumNum = choice.sumNum; //取到pageCount的值(把返回数据转成object类型)
		var currentPage = choice.currentPage; //得到urrentPage
		var pageSize = choice.pageSize; //得到urrentPage
		
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
		var element = $("#choicepaginator");//获得数据装配的位置
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
	            url: "/homework/t/question/getchoicesinfo.do",
	            data:{
	            	currentPage:page
	            },
	            datatype:"json",
	            success: function (data) {
	            	var dataJson = eval("(" + data +")");
	            	choice.choices = dataJson.array;
	            	choice.currentPage = dataJson.pageInfo.currentPage;
	            	choice.sumNum = dataJson.pageInfo.sumNum;
	            	choice.pageSize = dataJson.pageInfo.pageSize;
	            }
	    })
			}// end onClickfunction
		};//end option
		element.bootstrapPaginator(options);	//进行初始化
	}
	</script>
	
	<!-- 填空题js -->
	<script type="text/javascript">
		var fbtbl = new Vue({
			el:"#fillblanks_tbl",
			data:{
				fillblanks:[],
				currentPage:1,
				sumNum:0,
				pageSize:3
			},
			mounted: function () {
				
			}
		});
		
		//专业调整页面异步刷新方法
		function setFbPaginator(){
			var sumNum = fbtbl.sumNum; //取到pageCount的值(把返回数据转成object类型)
			var currentPage = fbtbl.currentPage; //得到urrentPage
			var pageSize = fbtbl.pageSize; //得到urrentPage
			
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
			var element = $("#fillblankpaginator");//获得数据装配的位置
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
		            url: "/homework/t/question/getfillblanksinfo.do",
		            data:{
		            	currentPage:page
		            },
		            datatype:"json",
		            success: function (data) {
		            	var dataJson = eval("(" + data +")");
		            	fbtbl.fillblanks = dataJson.array;
		            	fbtbl.currentPage = dataJson.pageInfo.currentPage;
		            	fbtbl.sumNum = dataJson.pageInfo.sumNum;
		            	fbtbl.pageSize = dataJson.pageInfo.pageSize;
		            }
		    })
				}// end onClickfunction
			};//end option
			element.bootstrapPaginator(options);	//进行初始化
		}
	</script>
	
	
	<!-- 填空题js -->
	<script type="text/javascript">
		var saqtbl = new Vue({
			el:"#saq_tbl",
			data:{
				saqs:[],
				currentPage:1,
				sumNum:0,
				pageSize:3
			},
			mounted: function () {
			}
		});
		
		//专业调整页面异步刷新方法
		function setSAQPaginator(){
			var sumNum = saqtbl.sumNum; //取到pageCount的值(把返回数据转成object类型)
			var currentPage = saqtbl.currentPage; //得到urrentPage
			var pageSize = saqtbl.pageSize;  //得到urrentPage
			
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
			var element = $("#saqpaginator");//获得数据装配的位置
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
		            url: "/homework/t/question/getsaqinfo.do",
		            data:{
		            	currentPage:page
		            },
		            datatype:"json",
		            success: function (data) {
		            	var dataJson = eval("(" + data +")");
		            	saqtbl.saqs = dataJson.array;
		            	saqtbl.currentPage = dataJson.pageInfo.currentPage;
		            	saqtbl.sumNum = dataJson.pageInfo.sumNum;
		            	saqtbl.pageSize = dataJson.pageInfo.pageSize;
		            }
		    	})
			}// end onClickfunction
			};//end option
			element.bootstrapPaginator(options);	//进行初始化
		}
	</script>
</body>
</html>