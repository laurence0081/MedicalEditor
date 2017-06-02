<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE HTML>
<html lang="en-US">
  <head>
    <base href="<%=basePath%>">
    
    <title>Medical editor</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<meta charset="UTF-8">
  </head>
  
  <body>
  
    <form id="articleForm" name="articleForm" method="post">
		<!-- 加载编辑器的容器 -->
        <script id="container" name="content" type="text/plain">
         	   请在此处输入文章内容...
    	</script>
    	<input type="text" id="articleName" name="articleName" placeholder="在这里输入文章名称"/>
    	<input type="text" id="articleTime" name="articleTime" placeholder="在这里输入文章时间"/>
    	<input type="text" id="articleWriter" name="articleWriter" placeholder="在这里输入编辑名称"/>
    	<input type="text" id="articleFrom" name="articleFrom" placeholder="在这里输入原文地址"/>
    	<input type="button" value="发送" onclick="return findContent()"/>
    </form>
    
    <!-- 配置文件 -->
    <script type="text/javascript" src="ueditor.config.js"></script>
    <!-- 编辑器源码文件 -->
    <script type="text/javascript" src="ueditor.all.js"></script>
    <!-- 实例化编辑器 -->
    <script type="text/javascript">
        var ue = UE.getEditor('container');
    </script>
    
    <script>
    	var ue = UE.getContent();
		//对编辑器的操作最好在编辑器ready之后再做
    </script>
    <script>
    	function findContent(){
    	var content = UE.getEditor('editor').getAllHtml();
    	
    	$.post("addArticle",
  		{
  		  articleContent:content,
  		  articleName:$('#articleName').val(),	
  		  articleTime:$('#articleTime').val(),
  		  articleWriter:$('#articleWriter').val(),	
  		  articleFrom:$('#articleFrom').val()
 		 }, function(data,status){
   		 alert("Data: " + data + "\nStatus: " + status);
  		});
	   return true;
    }
    </script>
  </body>
</html>