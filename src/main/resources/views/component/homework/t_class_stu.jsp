<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 	<h2 class="sub-header">班级学生管理</h2>

          <div id ="stu-tbl" class="table-responsive">
          <div class="row  bottom-border">
          	<div class="col-sm-6 col-sm-6" >
	          	 <form class="form-inline" role="form">
				      <div class="form-group">
				        <label class="form-label">选择班级</label>
				        <select id="slctclass" class="form-control" v-on:change="getStudents" style="width:200px;">
						<option value="">请选择</option>
						<template v-for="classm in classes">
							<option v-bind:value="classm.id">{{classm.class_name}}</option>
						</template>
					</select>	  
				      </div>
			     </form>
          	</div>
          	<div class="col-sm-6 col-sm-6" >
          		          		          
          		          		          
          	</div>
          </div>
          	<div>
	         	<table id="stuTbl" class="table table-striped table-bordered table-condensed">
		 	  		<thead>
		 	  			<tr>
		 	  				<th>学生姓名</th>
		 	  				<th>登录账号</th>
							<th>所属班级</th>
							<th>联系电话</th>
							<th>邮箱</th>
							<th>操作</th>
						</tr>
						
					</thead>
					<tbody id="stuTbody" class="changes">
						<template v-for="student in students">
							<tr>
			 	  				<td>{{ student.name }}</td>
								<td>{{ student.username }}</td>
								<td>{{ student.class_name }}</td>
								<td>{{ student.phone }}</td>
								<td>{{ student.email }}</td>
								<td> <a class="btn btn-info">修改班级</a></td>
							</tr>
						</template>
					</tbody>
				</table>
				 <div class="row text-center">
				 	<ul id='stupaginator' style="cursor:hand;"></ul>
				 </div>
			</div>
          </div>