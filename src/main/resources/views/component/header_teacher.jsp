<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <nav class="navbar navbar-inverse navbar-static-top">
    	<div class="navbar-header">
          <a class="navbar-brand" href="/homework/t/homework.do">中小学语文在线作业管理系统</a>
        </div>
      <div class="container">
        
        <div id="navbar" class="navbar-collapse collapse">
          <ul class="nav navbar-nav" id="top-bar">
          	<li id = "classManege" class = "manage"><a href="/homework/t/class.do">班级管理</a></li>
            <li id = "homeworkManage" class="active student"><a href="/homework/t/homework.do">作业管理</a></li>
            <li id = "questionManege" class = "manage"><a href="/homework/t/question.do">题库管理</a></li>
          </ul>
          <ul class="nav navbar-nav navbar-right">
            <li class="dropdown">
              <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">当前用户:${sessionScope.teacher_name} <span class="caret"></span></a>
              <input type="hidden" id="id" value="${sessionScope.teacher_id}">
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