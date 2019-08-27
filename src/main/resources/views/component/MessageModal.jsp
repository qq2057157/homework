<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	<!-- 提示框 -->
	<div class="modal fade bs-example-modal-sm closeMessage" id="dialogModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel">
		<div class="modal-dialog modal-sm" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close closeMessage" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">提示</h4>
				</div>
				<div class="modal-body text-center">
					<div class="row">
						<div class="col-xs-12">
							<strong><span id="message"></span></strong>
						</div>
					</div>
				</div>
				<div class="modal-footer">
					<button id="allDone" type="button" data-dismiss="modal" class="closeMessage btn btn-primary">确定</button>
				</div>
			</div>
		</div>
	</div>