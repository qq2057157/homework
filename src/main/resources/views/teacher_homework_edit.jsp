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
<title>编辑作业</title>
</head>
<body>
	<!-- 页头导航栏 -->
	<%@ include  file='/component/header_teacher.jsp'%>
	
    <div class="container-fluid">
   	<%@ include  file='/component/homework/t_homework_new.jsp'%>
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
		
		function getChoicesByPage(page){
			$.ajax({
	            type: 'post',
	            url: "/homework/t/question/getchoicesinfo.do",
	            data:{
	            	id:choicetbl.id,
	            	currentPage:page
	            },
	            datatype:"json",
	            success: function (data) {
	            	var dataJson = eval("(" + data +")");
	            	choicetbl.choices = dataJson.array;
	            	choicetbl.currentPage = dataJson.pageInfo.currentPage;
	            	choicetbl.sumNum = dataJson.pageInfo.sumNum;
	            	choicetbl.pageSize = dataJson.pageInfo.pageSize;
	            	setCPaginator();
	            }
	    	})
		}
		var choicetbl = new Vue({
			el:"#choicetbl",
			data:{
				id:hid,
				choices:[],
				currentPage:1,
				sumNum:0,
				pageSize:3,
				choices_new:[{'id':null,'number':'0','question':null,'choice_a':'','choice_b':'','choice_c':'','choice_d':'','answer':'','score':5}]
			},
			mounted:function(){
						$.ajax({
				            type: 'post',
				            url: "/homework/t/homeworkChoicesList.do",
				            data:{
				            	id:this.id
				            },
				            datatype:"json",
				            success: function (data) {
				            	var dataJson = eval("(" + data +")");
				            	choicetbl.choices_new = dataJson.array;
				            }
				    	})
				},
			methods:{
				getChoices:function(){
					 getChoicesByPage(choicetbl.currentPage);
				},
				addChoice:function(){
					choicetbl.choices_new.push({'id':null,'number':'','question':null,'choice_a':'','choice_b':'','choice_c':'','choice_d':'','answer':'','score':5});
				},
				saveChoice:function(index,id,score){
					if(id==null){
						if(isEmpty(choicetbl.choices_new[index].question) || 
								isEmpty(choicetbl.choices_new[index].choice_a) ||
								isEmpty(choicetbl.choices_new[index].choice_b) ||
								isEmpty(choicetbl.choices_new[index].choice_c) ||
								isEmpty(choicetbl.choices_new[index].choice_d) ||
								isEmpty(choicetbl.choices_new[index].answer) ||
								isEmpty(choicetbl.choices_new[index].score)){
							alert("参数不完整！");
						} else {
							$.ajax({
					            type: 'post',
					            url: "/homework/t/homeworkAddChoices.do",
					            data:{
						            	hid:choicetbl.id,
						            	question:choicetbl.choices_new[index].question,
						            	choice_a:choicetbl.choices_new[index].choice_a,
						            	choice_b:choicetbl.choices_new[index].choice_b,
						            	choice_c:choicetbl.choices_new[index].choice_c,
						            	choice_d:choicetbl.choices_new[index].choice_d,
						            	answer:choicetbl.choices_new[index].answer,
						            score:choicetbl.choices_new[index].score
					            },
					            datatype:"json",
					            success: function (data) {
						            	var dataJson = eval("(" + data +")");
						            	if(dataJson.code==99999){
						            		alert("保存成功");
							            	choicetbl.choices_new[index].id = data.data.id;
						            	}else {
						            		alert("保存失败");
						            	}
					            }
							});//end ajax;
						} //end if;
					} else{
						$.ajax({
				            type: 'post',
				            url: "/homework/t/homeworkAddChoices.do",
				            data:{
				            	id:id,
				            	hid:choicetbl.id,
				            	score:score
				            },
				            datatype:"json",
				            success: function (data) {
					            	var dataJson = eval("(" + data +")");
					            	if(dataJson.code==99999){
					            		choicetbl.choices_new.push(choicetbl.choices[index]);
					            		getChoicesByPage(choicetbl.currentPage);
					            		alert("保存成功");
					            	}else {
					            		alert("保存失败");
					            	}
				            }
						});
					}
					
				},
				removeChoice:function(index){
					$.ajax({
			            type: 'post',
			            url: "/homework/t/deleteHomeworkQuestion.do",
			            data:{
			            	id:choicetbl.choices_new[index].id
			            },
			            datatype:"json",
			            success: function (data) {
				            	var dataJson = eval("(" + data +")");
				            	if(dataJson.code==99999){
				            		alert("删除成功");
				            		choicetbl.choices_new.splice(index,1);
				            	}else {
				            		alert("删除失败");
				            	}
			            }
					});
				}
			}
			
		});
		//单选题页面异步刷新方法
		function setCPaginator(){
			var sumNum = choicetbl.sumNum; //取到pageCount的值(把返回数据转成object类型)
			var currentPage = choicetbl.currentPage; //得到urrentPage
			var pageSize = choicetbl.pageSize; //得到urrentPage
			
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
			    numberOfPages: 10, //显示页码数标个数
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
		    		getChoicesByPage(page);
				}// end onClickfunction
			};//end option
			element.bootstrapPaginator(options);	//进行初始化
		}
	</script>
	
	<script type="text/javascript">
	
		function getFbsByPage(page){
			$.ajax({
	            type: 'get',
	            url: "/homework/t/question/getfillblanksinfo.do",
	            data:{
	            	id:fbtbl.id,
	            	currentPage:page
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
		};
		var fbtbl = new Vue({
			el:"#fillblankstbl",
			data:{
				id:hid,
				fillblanks:[],
				currentPage:1,
				sumNum:0,
				pageSize:3,
				fillblanks_new:[{'id':null,'question':'填空题','answer':'','score':5}]
			},
			mounted:function(){
				$.ajax({
		            type: 'post',
		            url: "/homework/t/homeworkFbList.do",
		            data:{
		            	id:this.id
		            },
		            datatype:"json",
		            success: function (data) {
		            	var dataJson = eval("(" + data +")");
		            	fbtbl.fillblanks_new = dataJson.array;
		            }
		    	})
			},
			methods:{
				getFillBlanks:function () {
					getFbsByPage(fbtbl.currentPage);
				},
				addFillBlank:function(){
					fbtbl.fillblanks_new.push({'id':null,'question':null,'answer':null,'score':5});
				},
				savefillblank:function(index,id,score){
					if(id==null){
						if(isEmpty(fbtbl.fillblanks_new[index].question) || 
								isEmpty(fbtbl.fillblanks_new[index].answer) ||
								isEmpty(fbtbl.fillblanks_new[index].score)){
							alert("参数不完整！");
						} else {
							$.ajax({
					            type: 'post',
					            url: "/homework/t/homeworkAddFb.do",
					            data:{
					            	hid:fbtbl.id,
					            	question:fbtbl.fillblanks_new[index].question,
					            	answer:fbtbl.fillblanks_new[index].answer,
					            score:fbtbl.fillblanks_new[index].score
					            },
					            datatype:"json",
					            success: function (data) {
						            	var dataJson = eval("(" + data +")");
						            	if(dataJson.code==99999){
						            		fbtbl.fillblanks_new[index].id = dataJson.data.id;
						            		alert("保存成功");
						            	}else {
						            		alert("保存失败");
						            	}
					            }
							});
						}
					} else {
						$.ajax({
				            type: 'post',
				            url: "/homework/t/homeworkAddFb.do",
				            data:{
				            	hid:fbtbl.id,
				            id:id,
				            score:score
				            },
				            datatype:"json",
				            success: function (data) {
					            	var dataJson = eval("(" + data +")");
					            	if(dataJson.code==99999){
					            		fbtbl.fillblanks_new.push(fbtbl.fillblanks[index]);
					            		getFbsByPage(fbtbl.currentPage);
					            		alert("保存成功");
					            	}else {
					            		alert("保存失败");
					            	}
				            }
						});
					}
					
				},
				removeFillBlank:function(index){
					$.ajax({
			            type: 'post',
			            url: "/homework/t/deleteHomeworkQuestion.do",
			            data:{
			            	id:fbtbl.fillblanks_new[index].id
			            },
			            datatype:"json",
			            success: function (data) {
				            	var dataJson = eval("(" + data +")");
				            	if(dataJson.code==99999){
				            		alert("删除成功");
				            		fbtbl.fillblanks_new.splice(index,1);
				            	}else {
				            		alert("删除失败");
				            	}
			            }
					});
					
				}
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
			    numberOfPages: 10, //显示页码数标个数
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
		    		getFbsByPage(page);
				}// end onClickfunction
			};//end option
			element.bootstrapPaginator(options);	//进行初始化
		}
	</script>
	
	<!-- 简答题 -->
	<script type="text/javascript">
	
	function getSAQsByPage(page){
		$.ajax({
            type: 'get',
            url: "/homework/t/question/getsaqinfo.do",
            data:{
            	id:saqtbl.id,
            	currentPage:page
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
	};
		var saqtbl = new Vue({
			el:"#saqtbl",
			data:{
				id:hid,
				saqs:[],
				currentPage:1,
				sumNum:0,
				pageSize:3,
				saqs_new:[{'id':null,'question':null,'key_word':null,'score':10}]
			},
			mounted:function(){
				$.ajax({
		            type: 'post',
		            url: "/homework/t/homeworkSAQList.do",
		            data:{
		            	id:this.id
		            },
		            datatype:"json",
		            success: function (data) {
		            	var dataJson = eval("(" + data +")");
		            	saqtbl.saqs_new = dataJson.array;
		            }
		    	})
			},
			methods:{
				getSAQ:function () {
					getSAQsByPage(saqtbl.currentPage);
				},
				addSAQ:function(){
					saqtbl.saqs_new.push({'id':null,'question':'简答题','key_word':'','score':10});
				},
				saveSAQ:function(index,id,score){
					if(id==null){
						if(isEmpty(saqtbl.saqs_new[index].question) || 
								isEmpty(saqtbl.saqs_new[index].key_word) ||
								isEmpty(saqtbl.saqs_new[index].score)){
							alert("参数不完整！");
						} else {
							$.ajax({
					            type: 'post',
					            url: "/homework/t/homeworkAddSAQ.do",
					            data:{
					            	hid:saqtbl.id,
					            	question:saqtbl.saqs_new[index].question,
					            	key_word:saqtbl.saqs_new[index].key_word,
					            score:saqtbl.saqs_new[index].score
					            },
					            datatype:"json",
					            success: function (data) {
						            	var dataJson = eval("(" + data +")");
						            	if(dataJson.code==99999){
						            		saqtbl.saqs_new[index].id = dataJson.data.id;
						            		alert("保存成功");
						            	}else {
						            		alert("保存失败");
						            	}
					            }
							});
						}
					} else {
						$.ajax({
				            type: 'post',
				            url: "/homework/t/homeworkAddSAQ.do",
				            data:{
				            	id:id,
				            	hid:saqtbl.id,
				            	score:score
				            },
				            datatype:"json",
				            success: function (data) {
					            	var dataJson = eval("(" + data +")");
					            	if(dataJson.code==99999){
					            		saqtbl.saqs_new.push(saqtbl.saqs[index]);
					            		getSAQsByPage(saqtbl.currentPage);
					            		alert("保存成功");
					            	}else {
					            		alert("保存失败");
					            	}
				            }
						});
					}
					
				},
				removeSAQ:function(index){
					$.ajax({
			            type: 'post',
			            url: "/homework/t/deleteHomeworkQuestion.do",
			            data:{
			            	id:saqtbl.saqs_new[index].id
			            },
			            datatype:"json",
			            success: function (data) {
				            	var dataJson = eval("(" + data +")");
				            	if(dataJson.code==99999){
				            		alert("删除成功");
				            		saqtbl.saqs_new.splice(index,1);
				            	}else {
				            		alert("删除失败");
				            	}
			            }
					});
				}
			} 
		});
		
		//专业调整页面异步刷新方法
		function setSAQPaginator(){
			var sumNum = saqtbl.sumNum; //取到pageCount的值(把返回数据转成object类型)
			var currentPage = saqtbl.currentPage; //得到currentPage
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
			    numberOfPages: 10, //显示页码数标个数
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
		   	 	getSAQsByPage(page);
			}// end onClickfunction
			};//end option
			element.bootstrapPaginator(options);	//进行初始化
		}
	</script>
</body>
</html>