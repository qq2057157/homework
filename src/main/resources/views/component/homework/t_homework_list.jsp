<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
		<h2 class="sub-header">作业列表</h2>

          <div class="table-responsive">
          	<div id ="disribute" class="modal fade bs-example-modal-md" tabindex="-1" role="dialog">
					  <div class="modal-dialog" role="document">
					    <div class="modal-content">
					      <div class="modal-header">
					        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
					        <h4 id="dialogtitle" class="modal-title">发布作业</h4>
					      </div>
					      <div class="modal-body">
					      
					      	 <div class="row">
						          <div class="col-md-12">
						          	<template v-for="(item,index) in class_info">
						          	<label class="checkbox-inline">
								         <span>
								         <input type="checkbox" id="check" v-model="checkedNames" v-bind:value="item.id" v-if="item.status==0"/><a class="label label-info" v-on:click="toCorrect(item.class_id)">{{item.class_name}}</a></span> &nbsp;
								    </label>
							      	</template>
						          </div>
						      </div>
						      <div class="row">
						          <div class="col-md-12 text-center" >
						          	<input id="deadline" type="text" class="form-control" placeholder="yyyy-MM-dd hh:mm:ss" data-date-format="yyyy-mm-dd hh:ii:ss"/>
						          </div>
						      </div>
						      <div class="row">
						          <div id="msgcorrect" class="col-md-12 text-center" >
						          	<p  class="text-info">是否需要教师手动批改主观题：<input id="teachercorrct" type="checkbox" v-on:click="setTeacherCorret($event)"/></p>
						          </div>
						      </div>
						      <div class="row">
						          <div id="msgarea" class="col-md-12 text-center" >
						          	<p  class="text-danger">提示:一经发布便不可修改，请仔细确认信息！</p>
						          </div>
						      </div>
						      
					      </div>
					      <div class="modal-footer">
							
					        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					        <button id="savebt" type="button" class="btn btn-primary" v-on:click="distributeHomework()">保存</button>
					      </div>
					    </div><!-- /.modal-content -->
					  </div><!-- /.modal-dialog -->
					</div><!-- /.modal -->
          	<div id ="homework_tbl" >
	         	<table class="table table-striped table-bordered table-condensed">
		 	  		<thead>
		 	  			<tr>
		 	  				<th>作业名称</th>
							<th>选择题数量</th>
							<th>填空题数量</th>
							<th>简答题数量</th>
							<th>分值</th>
							<th>状态</th>
							<th>截止时间</th>
							<th>操作 <button id="add_choice" type="button" class="btn btn-info"  data-target="#create_homework"  data-toggle="modal" role="button">新建作业</button>
							</th>
						</tr>
					</thead>
					<tbody id="stuTbody" class="changes">
						<template v-for="(item,index) in homeworks">
							<tr>
			 	  				<td>{{ item.homework_name }}</td>
			 	  				<td>{{ item.choice_num }}</td>
			 	  				<td>{{ item.fb_num }}</td>
			 	  				<td>{{ item.saq_num }}</td>
								<td>{{ item.score }}</td>
								<td><p v-if="item.status===0">未发布</p><p v-if="item.status===2">批改中</p><p v-if="item.status===1">已发布</p><p v-if="item.status===4">已结束</p></td>
								<td><p v-if="item.deadline===null | item.deadline===''">未设置</p><p v-else>{{ item.deadline | moment }}</p></td>
								<td>
									<a :href="'/homework/t/homeworkedit.do?id='+item.id+'&homework_name='+item.homework_name" target="_blank" class="btn btn-info" v-if="item.status===0">编辑</a> <a class="btn btn-info" v-if="item.status===0">删除</a> 
									<a class="btn btn-info" v-if="item.status===0" v-on:click="distributeHomework(item.id,index)">发布</a>
									<a class="btn btn-info" v-if="item.status===1" v-on:click="viewHomework(item.id)">查看</a>
									<a class="btn btn-info" v-if="item.status===2" v-on:click="correctHomework(item.id)">批改</a>
									<a class="btn btn-info" v-if="item.status===2" v-on:click="correctedHomework(item.id,index)">结束批改</a>
									<a class="btn btn-info" v-if="item.status===4" v-on:click="viewHomework(item.id)">查看成绩</a>
								</td>
							</tr>
						</template>
					</tbody>
				</table>
				 <div class="row text-center">
				 	<ul id='homeworkpaginator' style="cursor:hand;" ></ul>
				 </div>
				 
			</div>
			<div id ="create_homework" class="modal fade bs-example-modal-md" tabindex="-1" role="dialog">
					  <div class="modal-dialog" role="document">
					    <div class="modal-content">
					      <div class="modal-header">
					        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
					        <h4 id="dialogtitle" class="modal-title">新建作业</h4>
					      </div>
					      <div class="modal-body">
					      
					      	 <div class="row">
						          <br>
							<form class="form-horizontal">
								<div class="form-group">
									<label for="inputName"
										class="col-xs-5 control-label text-right">作业名称</label>
									<div class="col-xs-4">
										<input type="text" class="form-control inputName"
											id="hn"  maxlength="10" onpaste="return false;" 
											v-model = "homework_name"
											>
									</div>
								</div>
							</form>
						      </div>
					      </div>
					      <div class="modal-footer">
							
					        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					        <button id="savebt" type="button" class="btn btn-primary" v-on:click="createHomework()">保存</button>
					      </div>
					    </div><!-- /.modal-content -->
					  </div><!-- /.modal-dialog -->
					</div><!-- /.modal -->
          </div>