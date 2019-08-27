<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
		<h2 class="sub-header">填空题</h2>

          <div class="table-responsive">
          <div class="row  bottom-border">
          	<div class="col-sm-6 col-sm-6" >
          		<button id="add_choice" type="button" class="btn btn-info"  data-target="#addChoiceModal"  data-toggle="modal" role="button">添加题目</button>
          	</div>
          	<div class="col-sm-6 col-sm-6" >
          	</div>
          </div>
          	<div id ="saq_tbl" >
	         	<table class="table table-striped table-bordered table-condensed">
		 	  		<thead>
		 	  			<tr>
		 	  				<th>问题</th>
							<th>答案关键词</th>
							<th>分值</th>
							<th>操作</th>
						</tr>
						
					</thead>
					<tbody id="stuTbody" class="changes">
						<template v-for="saq in saqs">
							<tr>
			 	  				<td>{{ saq.question }}</td>
								<td>{{ saq.key_word }}</td>
								<td>{{ saq.score }}</td>
								<td><a class="btn btn-info">修改</a> <a class="btn btn-info">删除</a></td>
							</tr>
						</template>
					</tbody>
				</table>
				 <div class="row text-center">
				 	<ul id='saqpaginator' style="cursor:hand;"></ul>
				 </div>
			</div>
          </div>