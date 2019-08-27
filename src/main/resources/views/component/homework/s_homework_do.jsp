<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
              
         

          <div class="container-fluid">
			<div class="form-horizontal">
			<table class="table table-striped table-bordered table-condensed">
			<thead>
		 	  			<tr>
		 	  				<th>作业名称</th>
							
							<th>指导教师</th>
							<th>截止时间</th>
							<th>分值</th>
							<th>最终得分</th>
							<th>状态</th>
							<th>操作</th>
						</tr>
					</thead>
					<tbody id="homeworkTbody" class="changes">
						<template v-for="(item,index) in homeworks">
							<tr>
								<td>
									{{item.homework_name}}
								</td>
								<td>
									{{item.teacher_name}}
								</td>
								<td>
									{{item.deadline | moment}}
								</td>
								<td>
									{{item.score}}
								</td>
								<td>
									{{item.student_score}}
								</td>
								<td>
									<p v-if="item.status===0">
										未提交
									</p>
									<p v-else-if="item.status===1">
										已提交
									</p>
									<p v-else-if="item.status===2" class="text-danger">
										教师批改中
									</p>
									<p v-else>
										已结束
									</p>
								</td>
								<td>
									<a :href="'/homework/s/homeworkedit.do?id='+item.id+'&homework_name='+item.homework_name" class="btn btn-info" v-if="item.status===0">去完成</a>
									<a :href="'/homework/s/homeworkedit.do?id='+item.id+'&homework_name='+item.homework_name" class="btn btn-info" v-if="item.status===1">去修改</a>
									<a :href="'/homework/s/homeworkview.do?id='+item.id+'&homework_name='+item.homework_name" class="btn btn-info" v-if="item.status===4">查看分数</a>
								</td>
							</tr>
						</template>
					</tbody>
			</table>
			</div>
          </div>
