<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
              
         <h2 class="sub-header">作业列表</h2>

         <div class="row  bottom-border">
         <table id="tblMain" class="table depart table-striped table-bordered">
 	  		<thead>
 	  			<tr>
 	  				<th>作业名称</th>
					<th>分值</th>
					<th>创建时间</th>
					<th>操作</th>
				</tr>
			</thead>
			<tbody id="departTbody" class="changes">
			</tbody>
		</table>
          </div>
          <div class="row text-center">
		 	<ul id='departPaginator' style="cursor:hand;"></ul>
		 </div>