<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	<!-- 添加定时任务弹出框start -->
	<div class="modal fade" id="addClassModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close close-btn" data-dismiss="modal" 
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">新增班级</h4>
				</div>
				<div class="modal-body">
				<div class="row">
							<br>
							<form class="form-horizontal">
								<div class="form-group">
									<label for="inputName"
										class="col-xs-5 control-label text-right">班级名称</label>
									<div class="col-xs-4">
										<input type="text" class="form-control inputName"
											id="classname" placeholder="班级名称" maxlength="10" onpaste="return false;" 
											v-model = "classname"
											>
									</div>
									
									<label for="inputPassword"
										class="col-xs-5 control-label text-right">班级密码</label>
									<div class="col-xs-4">
										<input type="text" class="form-control inputPassword"
											id="classpassword" placeholder="班级密码" maxlength="10" onpaste="return false;" 
											v-model = "classpassword"
											>
									</div>
								</div>
							</form>
						</div>
				</div>
				<!-- modalbody end -->
				<div class="modal-footer">
					<button type="button"  data-dismiss="modal" class="btn btn-default close-btn">取消</button>
					<button id="addClassButton" type="button" class="btn btn-primary" v-on:click="addclass">确定</button>
				</div>
			</div>
		</div>
	</div>
	<!-- 添加定时任务弹出框end -->