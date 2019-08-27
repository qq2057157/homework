<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>LibGoodsController测试页面</title>
    <meta name="layout" content="main"/>
    <script  src="js/jquery-1.12.0.min.js"></script>
    <script src="/js/vue.js"></script>
  <link rel="stylesheet" href="https://unpkg.com/element-ui/lib/theme-chalk/index.css">
<link rel="stylesheet" href="https://unpkg.com/element-ui@2.0.11/lib/theme-chalk/index.css">

  	<script src="https://unpkg.com/element-ui/lib/index.js"></script>
</head>

<body>
 <div id="pag">
<div class="line"></div>
<el-menu :default-active="activeIndex2" class="el-menu-demo" mode="horizontal" @select="handleSelect" background-color="#545c64" text-color="#fff" active-text-color="#ffd04b">
  <el-menu-item index="1">作业管理</el-menu-item>
  <el-menu-item index="2">班级管理</el-menu-item>
  <el-menu-item index="3">题库管理</el-menu-item>
</el-menu>
			<el-pagination background layout="prev, pager, next" :total="30">
			</el-pagination>
		</div>
		<script type="text/javascript">
		new Vue().$mount('#pag')
		</script>
</body>
</html>