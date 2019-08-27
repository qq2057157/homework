<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
              
         

          <div id = "htbl" class="container-fluid">
				  <div class="row">
				      <div class="col-md-12">
				          <h2 class="sub-header">作业名称：${homework_name}</h2>
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
							          <div class="col-xs-9">
							          	<label class="control-label">{{choice.question}}</label>
						          	  </div>
							          	<div class="col-md-2">
							          			<label>分值：{{choice.score}}</label>
							          	</div>
						          </div>
						          <div class="form-group">
						          		<label class="col-md-2 control-label text-right">
						          			选项：
						          		</label>
						          		<form action="">
							          		<label class="col-md-2 control-label text-center">
							          			<input type="radio" v-bind:id="choice.id" v-bind:name="'radio'+choice.id" v-if="choice.student_answer==='A'"  checked v-bind:value="A" v-on:click="choiceChange(index,'A')"/> A: {{choice.choice_a}}
												<input type="radio" v-bind:id="choice.id" v-bind:name="'radio'+choice.id" v-else v-bind:value="A" v-on:click="choiceChange(index,'A')"/> A: {{choice.choice_a}}
							          		</label>
							          		<label class="col-md-2 control-label text-center">
							          			<input type="radio"  v-bind:id="choice.id" v-bind:name="'radio'+choice.id"  v-if="choice.student_answer==='B'"  checked  v-bind:value="B" v-on:click="choiceChange(index,'B')"/> B: {{choice.choice_b}}
												<input type="radio"  v-bind:id="choice.id" v-bind:name="'radio'+choice.id"  v-else v-bind:value="B" v-on:click="choiceChange(index,'B')"/> B: {{choice.choice_b}}
							          		</label>
							          		<label class="col-md-2 control-label text-center">
							          			<input type="radio"  v-bind:id="choice.id" v-bind:name="'radio'+choice.id" v-if="choice.student_answer==='C'"  checked v-bind:value="C" v-on:click="choiceChange(index,'C')"/> C: {{choice.choice_c}}
												<input type="radio"  v-bind:id="choice.id" v-bind:name="'radio'+choice.id" v-else  v-bind:value="C" v-on:click="choiceChange(index,'C')"/> C: {{choice.choice_c}}
							          		</label>
							          		<label class="col-md-2 control-label text-center">
							          			<input type="radio"  v-bind:id="choice.id" v-bind:name="'radio'+choice.id" v-if="choice.student_answer==='D'" checked v-bind:value="D" v-on:click="choiceChange(index,'D')"/> D: {{choice.choice_d}}
							          			<input type="radio"  v-bind:id="choice.id" v-bind:name="'radio'+choice.id"  v-else v-bind:value="D" v-on:click="choiceChange(index,'D')"/> D: {{choice.choice_d}}
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
							          <div class="col-xs-9">
							          	<label class="control-label">{{fillblank.question}}</label>
						          	  </div>
						          	  <div class="col-md-2">
							          			<label>分值：{{fillblank.score}}</label>
							          </div>
							       </div>
						          <div class="form-group">
						          		<label class="col-md-1 control-label">答案</label>
						          		<div class="col-md-2">
						          			<input type="text" class="form-control" v-bind:value="fillblank.student_answer" v-on:change="fbChange($event,index)"/>
						          		</div>
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
						          
							          <label for="question" class="col-xs-1 control-label">第{{index+1}}题:</label>
							          <div class="col-xs-9">
							          	<label>{{saq.question}}</label>
						          	  </div>
						          	  <div class="col-xs-2">
						          	  	<label>分值：{{saq.score}}</label>
						          	  </div>
						          </div>
						          <div class="form-group">
						          		<label class="col-md-1 control-label">答案</label>
						          		<div class="col-md-3">
						          			<input type="text" class="form-control" v-bind:value="saq.student_answer" v-on:change="saqChange($event,index)"/>
						          		</div>
						          </div>
						   	</template>
					   	</div>
				  </div>
	          <!-- 简答题 -->
	          <div class="text-center">
						   		<a id="addChoice" class="btn btn-info" href="javascript:history.go(-1)">返回</a> <a id="addChoice" class="btn btn-info" v-on:click="saveAnswer()">提交</a>
						   	</div>
          </div>
