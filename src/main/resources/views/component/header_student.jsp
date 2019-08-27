<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <nav class="navbar navbar-inverse navbar-static-top">
    	<div class="navbar-header">
          <a class="navbar-brand" href="/homework/s/complete.do">中小学语文在线作业系统</a>
        </div>
      <div class="container">
        
        <div id="navbar" class="navbar-collapse collapse">
          <ul id="top-bar" class="nav navbar-nav">
          	<li id = "personalCenter" class="active student"><a href="/homework/s/personal.do">个人中心</a></li>
          	<li id = "classHomework" class = "manage"><a href="/homework/s/complete.do">班级作业</a></li>
          </ul>
          <ul class="nav navbar-nav navbar-right">
            <li class="dropdown">
              <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">当前用户:${sessionScope.student_name} <span class="caret"></span></a>
              <input type="hidden" id="id" value="${sessionScope.student_id}">
              <ul class="dropdown-menu">
                <li><a href="#">修改个人信息</a></li>

                <li role="separator" class="divider"></li>
                <li><a href="#">修改密码</a></li>
                <li role="separator" class="divider"></li>
                <li><a href="#" id="logout">退出系统</a></li>
              </ul>
            </li>          </ul>
        </div><!--/.nav-collapse -->
      </div>
    </nav>