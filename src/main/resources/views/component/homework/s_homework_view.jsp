<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
              
         

          <div id = "htbl" class="container-fluid">
				  <div class="row">
				      <div class="col-md-12">
				      	<div class="col-md-10">
							 <h2 class="sub-header">作业名称：${homework_name}</h2>          			
						</div>
				         <div class="col-md-2">
							 <label >作业总得分：<label class="text-danger">${sumscore}</label></label>
						</div>
				      </div>
				  </div>
				  <div id="choicetbl">
		          		<div class="row">
				          	<div class="col-md-10">
				          		<h3>&nbsp;&nbsp;&nbsp;&nbsp;一、选择题</h3>
				          	</div>
		          		</div>
		          		<div class="form-horizontal">
			          		<template v-for="(choice,index) in choices_new">
						          <div class="form-group">
						          
							          <label for="question" class="col-xs-1 control-label">第{{index+1}}题:</label>
							          <div class="col-xs-8">
							          	<label class="control-label">{{choice.question}}</label>
						          	  </div>
							          	<div class="col-md-1">
							          			<label>分值：{{choice.score}}</label>
							          	</div>
							          	<div class="col-md-2">
							          			<label>
							          			你的得分： <label class="text-danger">{{choice.student_score}}</label>
							          			</label>
							          	</div>
						          </div>
						          <div class="form-group">
						          		<label class="col-md-1 control-label text-right">
						          			选项：
						          		</label>
						          		<form action="">
							          		<label class="col-md-1 control-label text-center">
							          			A: {{choice.choice_a}}
							          		</label>
							          		<label class="col-md-1 control-label text-center">
							          			B: {{choice.choice_b}}
							          		</label>
							          		<label class="col-md-1 control-label text-center">
							          			C: {{choice.choice_c}}
							          		</label>
							          		<label class="col-md-1 control-label text-center">
							          			D: {{choice.choice_d}}
							          		</label>
							          		<label class="col-md-2 control-label text-center">
							          			正确答案： {{choice.answer}}
							          		</label>
							          		<label class="col-md-2 control-label text-center">
							          			你的答案：
							          			<label v-if="choice.answer===choice.student_answer">
							          				{{choice.student_answer}} <span class="glyphicon glyphicon-ok ok"></span>
							          			</label>
							          			<label v-else class="text-danger"> 
							          				{{choice.student_answer}} <span v-if="choice.student_answer" class="glyphicon glyphicon-remove error"></span>
							          			</label>
							          		</label>
						          		</form>
						          </div>
						   </template>	
				</div>
			</div>
	          <!-- 填空题 -->
	          <div id="fillblankstbl">
		          		<div class="row">
				          	<div class="col-md-10">
				          		<h3>&nbsp;&nbsp;&nbsp;&nbsp;二、填空题</h3>
				          	</div>
		          		</div>
			          <div class="form-horizontal">
			          		<template v-for="(fillblank,index) in fillblanks_new">
						          <div class="form-group">
						          
							          <label for="question" class="col-xs-1 control-label">第{{index+1}}题:</label>
							          <div class="col-xs-8">
							          	<label class="control-label">{{fillblank.question}}</label>
						          	  </div>
						          	  <div class="col-md-1">
							          		<label>分值：{{fillblank.score}}</label>
							          	</div>
							          	<div class="col-md-2">
							          	<label>
							          			你的得分： 
							          				<label class="text-danger">
							          					{{fillblank.student_score}}
							          				</label>
							          	</label>
							          	</div>
							       </div>
						          <div class="form-group">
						          		<label class="col-md-2 control-label text-center">
							          			正确答案： {{fillblank.answer}}
							          	</label>
							          	<label class="col-md-2 control-label text-center">
							          			你的答案: 
							          			<label v-if="fillblank.answer===fillblank.student_answer">
							          				{{fillblank.student_answer}} <span class="glyphicon glyphicon-ok ok"></span>
							          			</label>
							          			<label v-else class="text-danger"> 
							          				{{fillblank.student_answer}} <span v-if="fillblank.student_answer" class="glyphicon glyphicon-remove error"></span>
							          			</label>
							          	</label>
						          </div>
						   	</template>
					 </div>
	          </div>
	          <!-- 填空题 -->
	          
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
							          <div class="col-md-8">
							          	<label>{{saq.question}}</label>
						          	  </div>
						          	  <div class="col-md-1">
							          		<label>分值：{{saq.score}}</label>
							          	</div>
							          	<div class="col-md-2">
							          	<label>
							          			你的得分： 
							          			<label class="text-danger">
							          				{{saq.student_score}}
							          			</label>
							          	</label>
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
							          			你的答案：
							          			<label class="text-danger">
							          				{{saq.student_answer}}
							          			</label>
							          	</label>
							          </div>
						          </div>
						   	</template>
					   	</div>
				  </div>
	          <!-- 简答题 -->
	           <div class="text-center">
						   		<a id="addChoice" class="btn btn-info" href="javascript:history.go(-1)">返回</a>
						   	</div>
          </div>
