<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
              
         

          <div class="container-fluid">
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
				          	<div class="col-md-2">
				          		<button type="button" class="btn btn-info" v-on:click="getChoices" data-toggle="modal" data-target=".choice">从题库添加</button> 
			          		</div>
		          		</div>
		          		<div class="form-horizontal">
			          		<template v-for="(choice,index) in choices_new">
						          <div class="form-group">
						          
							          <label for="question" class="col-xs-1 control-label">第{{index+1}}题:</label>
							          <div class="col-xs-10">
							          	<input id="question" type="text" class="form-control" v-model="choice.question"/>
						          	  </div>
						          	  <div class="col-xs-1">
						          	  	<a id="saveChoice" v-if="choice.id===null" v-on:click="saveChoice(index,null,null)" class="btn btn-info">保存</a>
						          	  	<a id="removeChoice" v-else v-on:click="removeChoice(index)" class="btn btn-info">删除</a>
						          	  </div>
						          </div>
						          <div class="form-group">
						          		<label class="col-md-1 control-label">选项A</label>
						          		<div class="col-md-1">
						          			<input type="text" class="form-control" v-model="choice.choice_a"/>
						          		</div>
						          		<label class="col-md-1 control-label">选项B</label>
						          		<div class="col-md-1">
						          			<input type="text" class="form-control" v-model="choice.choice_b"/>
						          		</div>
						          		<label class="col-md-1 control-label">选项C</label>
						          		<div class="col-md-1">
						          			<input type="text" class="form-control" v-model="choice.choice_c"/>
						          		</div>
						          		<label class="col-md-1 control-label">选项D</label>
						          		<div class="col-md-1">
						          			<input type="text" class="form-control" v-model="choice.choice_d"/>
						          		</div>
						          		<label class="col-md-1 control-label">答案</label>
						          		<div class="col-md-1">
						          			<input type="text" class="form-control" v-model="choice.answer" placeholder="大写A,B,C,D"/>
						          		</div>
						          		<label class="col-md-1 control-label">分值</label>
						          		<div class="col-md-1">
						          			<input type="text" class="form-control" v-model="choice.score"/>
						          		</div>
						          </div>
						   	</template>
						   	<div class="text-center">
						   		<a id="addChoice" v-on:click="addChoice" class="btn btn-info">添加选择题</a>
						   	</div>
					   	</div>
				<div class="modal fade choice" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel">
				  <div class="modal-dialog modal-lg" role="document">
				    <div class="modal-content">
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
										<template v-for="(choice,index) in choices">
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
												<td><a class="btn btn-info" v-on:click="saveChoice(index,choice.id,choice.score)" class="btn btn-info">添加到作业</a></td>
											</tr>
										</template>
									</tbody>
								</table>
								 <div class="row text-center">
								 	<ul id='choicepaginator' style="cursor:hand;" ></ul>
								 </div>
							</div>
				    </div>
				  </div>
				</div>
	          </div>
	          <!-- 填空题 -->
	          <div id="fillblankstbl">
		          		<div class="row">
				          	<div class="col-md-10">
				          		<h3>&nbsp;&nbsp;&nbsp;&nbsp;二、填空题</h3>
				          	</div>
				          	<div class="col-md-2">
				          		<button type="button" class="btn btn-info" v-on:click="getFillBlanks" data-toggle="modal" data-target=".fillblanks_modal">从题库添加</button> 
			          		</div>
		          		</div>
			          <div class="form-horizontal">
			          		<template v-for="(fillblank,index) in fillblanks_new">
						          <div class="form-group">
						          
							          <label for="question" class="col-xs-1 control-label">第{{index+1}}题:</label>
							          <div class="col-xs-10">
							          	<input id="question" type="text" class="form-control" v-model="fillblank.question"/>
						          	  </div>
						          	  <div class="col-xs-1">
						          	  	<a id="saveFillBlank" v-if="fillblank.id===null" v-on:click="savefillblank(index,null,null)" class="btn btn-info">保存</a>
						          	  	<a id="removeFillBlank" v-else v-on:click="removeFillBlank(index)" class="btn btn-info">删除</a>
						          </div>
						          <div class="form-group">
						          		<label class="col-md-1 control-label">答案</label>
						          		<div class="col-md-3">
						          			<input type="text" class="form-control" v-model="fillblank.answer"  placeholder="答案以中文逗号隔开"/>
						          		</div>
						          		<label class="col-md-7 control-label">分值</label>
						          		<div class="col-md-1">
						          			<input type="text" class="form-control" v-model="fillblank.score"/>
						          		</div>
						          </div>
						   	</template>
						   	<div class="text-center">
						   		<a id="addFillBlank" v-on:click="addFillBlank" class="btn btn-info">添加填空题</a>
						   	</div>
					   	</div>
				<div class="modal fade fillblanks_modal" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel">
				  <div class="modal-dialog modal-lg" role="document">
				    <div class="modal-content">
					      <div id ="fillblanks_tbl" >
					         	<table class="table table-striped table-bordered table-condensed">
						 	  		<thead>
						 	  			<tr>
						 	  				<th>问题</th>
											<th>答案</th>
											<th>分值</th>
											<th>操作</th>
										</tr>
								</thead>
								<tbody id="stuTbody" class="changes">
									<template v-for="(fillblank,index) in fillblanks">
										<tr>
						 	  				<td>{{ fillblank.question }}</td>
											<td>{{ fillblank.answer }}</td>
											<td>{{ fillblank.score }}</td>
											<td><a v-on:click="savefillblank(index,fillblank.id,fillblank.score)" class="btn btn-info">添加到作业</a>
										</tr>
									</template>
								</tbody>
							</table>
							 <div class="row text-center">
							 	<ul id='fillblankpaginator' style="cursor:hand;" class="fillblank"></ul>
							 </div>
						</div>
				    </div>
				  </div>
				</div>
	          </div>
	          <!-- 填空题 -->
	          
	          <!-- 简答题 -->
	          <div id="saqtbl">
		          		<div class="row">
				          	<div class="col-md-10">
				          		<h3>&nbsp;&nbsp;&nbsp;&nbsp;三、简答题</h3>
				          	</div>
				          	<div class="col-md-2">
				          		<button type="button" class="btn btn-info" v-on:click="getSAQ" data-toggle="modal" data-target=".saq_modal">从题库添加</button> 
			          		</div>
		          		</div>
			          <div class="form-horizontal">
			          		<template v-for="(saq,index) in saqs_new">
						          <div class="form-group">
						          
							          <label for="question" class="col-xs-1 control-label">第{{index+1}}题:</label>
							          <div class="col-xs-10">
							          	<input id="question" type="text" class="form-control" v-model="saq.question"/>
						          	  </div>
						          	  <div class="col-xs-1">
						          	 	<a id="saveSAQ" v-if="saq.id===null" v-on:click="saveSAQ(index,null,null)" class="btn btn-info">保存</a>
						          	  	<a id="removeSAQ" v-else v-on:click="removeSAQ(index)" class="btn btn-info">删除</a>
						          	  </div>
						          </div>
						          <div class="form-group">
						          		<label class="col-md-1 control-label">答案关键词</label>
						          		<div class="col-md-9">
						          			<input type="text" class="form-control" v-model="saq.key_word" placeholder="关键词以中文逗号隔开"/>
						          		</div>
						          		<label class="col-md-1 control-label">分值</label>
						          		<div class="col-md-1">
						          			<input type="text" class="form-control" v-model="saq.score"/>
						          		</div>
						          </div>
						   	</template>
						   	<div class="text-center">
						   		<a id="addSAQ" v-on:click="addSAQ" class="btn btn-info">添加简答题</a>
						   	</div>
					   	</div>
				<div class="modal fade saq_modal" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel">
				  <div class="modal-dialog modal-lg" role="document">
				    <div class="modal-content">
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
										<template v-for="(saq,index) in saqs">
											<tr>
							 	  				<td>{{ saq.question }}</td>
												<td>{{ saq.key_word }}</td>
												<td>{{ saq.score }}</td>
												<td><a class="btn btn-info" v-on:click="saveSAQ(index,saq.id,saq.score)" >添加到作业</a></td>
											</tr>
										</template>
									</tbody>
								</table>
								 <div class="row text-center">
								 	<ul id='saqpaginator' style="cursor:hand;"></ul>
								 </div>
							</div>
				  </div>
				</div>
	          </div>
	         </div>
	          <!-- 简答题 -->
          </div>
