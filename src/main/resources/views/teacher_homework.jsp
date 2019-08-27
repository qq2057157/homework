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
<title>作业管理</title>
</head>
<body>
	<!-- 页头导航栏 -->
	<%@ include  file='/component/header_teacher.jsp'%>
	
    <div class="container-fluid">
    	<div class="row">
       		<div class="col-sm-3 col-md-2 sidebar">
	          	<ul class="nav nav-pills nav-tabs nav-stacked"  id="myTabs" role="tablist">
			    			<li role="presentation" class="active"><a href="#homework_new" role="tab" id="class-tab" data-toggle="tab" aria-controls="stuClass" aria-expanded="false">作业列表</a></li>      
	      		</ul>
	        </div>
			<div class="col-sm-9 col-md-10 main">
	    		<div id="myTabContent" class="tab-content">
			    	<div role="tabpanel" class="tab-pane active in fade privilege" id="homework_new" aria-labelledby="class-tab">
						       <jsp:include page="/component/homework/t_homework_list.jsp"></jsp:include>
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
	<script  src="/js/bootstrap-datetimepicker.min.js"></script>
	<script  src="/js/locales/bootstrap-datetimepicker.zh-CN.js"></script>
	<script  src="/js/common.js"></script>
	<script  src="/js/moment.min.js"></script>
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
		$('#homeworkManage').attr("class","active");
		$('#classManage').removeClass("active");
		$('#questionManege').removeClass("active");
		$('#deadline').datetimepicker({
			language:  'zh-CN',                                     
	        weekStart: 1,
	        todayBtn:  1,
	        todayHighlight: 1,
	        autoclose:1,
	        pickerPosition:"bottom-left",
	        startDate:new Date(),
	        maxView:3,
	        minView:0,
	        todayHighlight:true,
	        minuteStep:10
		});
	}) ;
	function getHomeworkInfo(page){
		$.ajax({
            type: 'post',
            url: "/homework/t/homeworkList.do",
            data:{
            		currentPage:page
            },
            datatype:"json",
            success: function (data) {
            	var dataJson = eval("(" + data +")");
            	homeworktbl.homeworks = dataJson.array;
            	homeworktbl.currentPage = dataJson.pageInfo.currentPage;
            	homeworktbl.sumNum = dataJson.pageInfo.sumNum;
            	homeworktbl.pageSize = dataJson.pageInfo.pageSize;
            	setHPaginator();
            }
    	})
	}
	var homeworktbl = new Vue({
		el:"#homework_tbl",
		data:{
			homeworks:[],
			currentPage:1,
			sumNum:0,
			pageSize:3,
		},
		mounted:function(){
			getHomeworkInfo(this.currentPage)
		},
		methods:{
			distributeHomework:function(id,index){
				if(isEmpty(homeworktbl.homeworks[index].score)){
					alert("作业题目数不能为0！");
				}else{
					$('#disribute').modal('show');
					$('#deadline').show();
					$('#savebt').show();
					$('#msg').show();
					$('#dialogtitle').html("发布作业");
					distribute.homework_id=id;
					distribute.homework_index = index
					$.ajax({
			            type: 'post',
			            url: "/homework/t/school/getclassinfo.do",
			            data:{
			            },
			            datatype:"json",
			            success: function (data) {
			            	var dataJson = eval("(" + data +")");
			            		distribute.class_info = dataJson.array;
			            }
					})
				}
			},
			viewHomework:function(id){
				$('#disribute').modal('show');
				$('#deadline').hide();
				$('#savebt').hide();
				$('#msgarea').hide();
				$('#msgcorrect').hide();
				$('#dialogtitle').html("已发布的班级");
				
				$.ajax({
		            type: 'post',
		            url: "/homework/t/getDistributedClassList.do",
		            data:{
		            		homework_id:id
		            },
		            datatype:"json",
		            success: function (data) {
		            	var dataJson = eval("(" + data +")");
		            		distribute.class_info = dataJson.array;
		            }
				})
			},
			removeDistribute:function(){
				alert("hello");
			},
			correctHomework:function(id){
				$('#disribute').modal('show');
				$('#deadline').hide();
				$('#savebt').hide();
				$('#msgarea').hide();
				$('#msgcorrect').hide();
				$('#dialogtitle').html("批改作业");
				distribute.homework_id=id;
				$.ajax({
		            type: 'post',
		            url: "/homework/t/getDistributedClassList.do",
		            data:{
		            		homework_id:id
		            },
		            datatype:"json",
		            success: function (data) {
		            	var dataJson = eval("(" + data +")");
		            		distribute.class_info = dataJson.array;
		            }
				})
			},
			correctedHomework:function(id,index){
				$.ajax({
		            type: 'post',
		            url: "/homework/t/corrected.do",
		            data:{
		            		id:id
		            },
		            datatype:"json",
		            success: function (data) {
		            	var dataJson = eval("(" + data +")");
		            		alert(dataJson.info);
		            		homeworktbl.homeworks[index].status=4;
		            }
				})
			}
		}
	});
	var distribute = new Vue({
		el:"#disribute",
		data:{ 
			homework_id:null,
			class_info:[],
			checkedNames:[],
			homework_index:null,
			teacher_correct:0
		},
		methods:{
			distributeHomework:function(){
				var deadline = $('#deadline').val();
				if(isEmpty(deadline) || this.checkedNames.lenght<=0){
					alert("未选择班级或截止时间未设置！");
				} else {
					$.ajax({
			            type: 'post',
			            url: "/homework/t/distributeHomework.do",
			            data:{
			            		classIds:this.checkedNames,
			            		homework_id:this.homework_id,
			            		deadline:deadline,
			            		teacher_correct:this.teacher_correct
			            },
			            datatype:"json",
			            traditional: true,
			            success: function (data) {
			            	var dataJson = eval("(" + data +")");
			            		alert("保存成功");
			            		homeworktbl.homeworks[distribute.homework_index].status = 1;
			            		homeworktbl.homeworks[distribute.homework_index].deadline = deadline;
			            		distribute.checkedNames.splice(0,distribute.checkedNames.length);
			            		distribute.class_info.splice(0,distribute.class_info.length);
			            		$('#deadline').val(null);
			            		$('#teachercorrct').checked=false;
			            		$('#disribute').modal('hide');
			            }
					}); 
				}
				
				},
				setTeacherCorret:function(event){
					var el = event.currentTarget;
					if(el.checked==true){
						distribute.teacher_correct = 1;
					} else {
						distribute.teacher_correct = 0;
					}
				},
				toCorrect:function(id){
					document.location="/homework/t/correct.do?class_id="+id+"&homework_id="+distribute.homework_id;
				}
		}
	});
	
	var create_homework = new Vue({
		el:"#create_homework",
		data:{ 
			homework_name:''
		},
		methods:{
			createHomework:function(){
				if(isEmpty(create_homework.homework_name)){
					alert("请填写作业名称！");
				} else {
					$.ajax({
			            type: 'post',
			            url: "/homework/t/createHomework.do",
			            data:{
			            		homework_name:create_homework.homework_name
			            },
			            datatype:"json",
			            success: function (data) {
			            	var dataJson = eval("(" + data +")");
			            		alert("创建成功");
			            		getHomeworkInfo(1);
			            		create_homework.homework_name ='';
			            		$('#create_homework').modal('hide');
			            }
					}); 
				}
				
				},
		}
	});
	//单选题页面异步刷新方法
	function setHPaginator(){
		var sumNum = homeworktbl.sumNum; //取到pageCount的值(把返回数据转成object类型)
		var currentPage = homeworktbl.currentPage;  //得到urrentPage
		var pageSize = homeworktbl.pageSize; //得到urrentPage
		
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
		var element = $("#homeworkpaginator");//获得数据装配的位置
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
	    		getHomeworkInfo(page);
			}// end onClickfunction
		};//end option
		element.bootstrapPaginator(options);	//进行初始化
	}
	</script>
</body>
</html>