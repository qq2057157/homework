<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
              
         

          <div id = "htbl" class="container-fluid">
				  <div class="row">
				      <div class="col-md-12">
				      	<div class="col-md-6">
							 <h2 class="sub-header">作业名称：${homework.homework_name}</h2>   
							 <label >截止时间：<label class="text-danger">${homework.deadline}</label></label> 
							&nbsp;&nbsp; <label >总分：<label class="text-danger">${homework.score}</label></label>      			
						</div>
						<div class="col-md-2">
							 <label >学生：<label class="text-danger">${student.name}</label></label>
						</div>
						<div class="col-md-2">
							 <label >班级：<label class="text-danger">${student.class_name}</label></label>
						</div>
				         <div class="col-md-2">
							 <label >学生总得分：<label class="text-danger">${sumscore}</label></label>
						</div>
				      </div>
				  </div>

	          <!-- 简答题 -->
	          <div id="saqtbl">
		          		<div class="row">
				          	<div class="col-md-10">
				          		<h3>&nbsp;&nbsp;&nbsp;&nbsp;三、简答题</h3>
				          	</div>
		          		</div>
			          <div class="form-horizontal">
			          		<template v-for="(saq,index) in saqs_new">
						          <div class="form-group">
						          
							          <label for="question" class="col-md-1 control-label">第{{index+1}}题:</label>
							          <div class="col-md-6">
							          	<label>{{saq.question}}</label>
						          	  </div>
						          	  <div class="col-md-1">
							          		<label>分值：{{saq.score}}</label>
							          	</div>
							          	<div class="col-md-2">
							          	<label>
							          			他的得分： 
							          			<label class="text-danger">
							          				{{saq.student_score}}
							          			</label>
							          	</label>
							          	
							          	</div>
							          	
							          	<div class="col-md-2">
							          		<label class="text-info">教师评分：</label>	<input type="text" v-model="saq.student_score" style="width:30px"/>
							          	</div>
						          </div>
						          <div class="form-group">
						          	 <div class="col-md-3">
						          		<label class="control-label text-center">
							          			答案要点： {{saq.key_word}}
							          	</label>
							          </div>
							          <div class="col-md-9">
							          	<label class="control-label">
							          			他的答案：
							          			<label v-if="saq.student_answer" class="text-danger">
							          				{{saq.student_answer}}
							          			</label>
							          			<label v-else class="text-danger">
							          				未作答
							          			</label>
							          	</label>
							          </div>
						          </div>
						   	</template>
					   	</div>
				  </div>
	          <!-- 简答题 -->
	          <div class="text-center">
						   		<a id="addChoice" class="btn btn-info" href="javascript:history.go(-1)">返回</a> <a id="addChoice" class="btn btn-info" v-on:click="teacherCorrect()">提交</a>
						   	</div>
          </div>
