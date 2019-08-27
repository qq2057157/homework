<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
		<h2 class="sub-header">单选题</h2>

          <div class="table-responsive">
          <div class="row  bottom-border">
          	<div class="col-sm-6 col-sm-6" >
          		<button id="add_choice" type="button" class="btn btn-info"  data-target="#addChoiceModal"  data-toggle="modal" role="button">添加题目</button>
          	</div>
          	<div class="col-sm-6 col-sm-6" >
          	</div>
          </div>
          	<div id ="choice_tbl" >
	         	<table class="table table-striped table-bordered table-condensed">
		 	  		<thead>
		 	  			<tr>
		 	  				<th>类型</th>
		 	  				<th>问题</th>
							<th>选项A</th>
							<th>选项B</th>
							<th>选项C</th>
							<th>选项D</th>
							<th>答案</th>
							<th>分值</th>
							<th>操作</th>
						</tr>
						
					</thead>
					<tbody id="stuTbody" class="changes">
						<template v-for="choice in choices">
							<tr>
								<td>
									<p v-if="choice.question_type===0">单选题</p>
									<p v-else>多选题</p>
								</td>
			 	  				<td>{{ choice.question }}</td>
								<td>{{ choice.choice_a }}</td>
								<td>{{ choice.choice_b }}</td>
								<td>{{ choice.choice_c }}</td>
								<td>{{ choice.choice_d }}</td>
								<td>{{ choice.answer }}</td>
								<td>{{ choice.score }}</td>
								<td><a class="btn btn-info">修改</a> <a class="btn btn-info">删除</a></td>
							</tr>
						</template>
					</tbody>
				</table>
				 <div class="row text-center">
				 	<ul id='choicepaginator' style="cursor:hand;" ></ul>
				 </div>
			</div>
          </div>