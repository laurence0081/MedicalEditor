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
    <form id="articleForm" name="articleForm" method="post" style="width:800px;margin:0 auto;text-align:center">
		<!-- 加载编辑器的容器 -->
        <script id="container" name="content" type="text/plain">
         	   请在此处输入文章内容...
    	</script>
    	<label for="articleName">文章名称</label>
    	<input type="text" id="articleName" name="articleName" placeholder="在这里输入文章名称"/>
    	<label for="articleTime">转载时间</label>
    	<input type="text" id="articleTime" name="articleTime" placeholder="在这里输入转载时间"/>
    	<label for="articleGroup">所属学组</label>
    	<input type="text" id="articleGroup" name="articleGroup" placeholder="在这里输入所属学组（没有就填0）"/>
    	<input type="button" id="articleButton" name="articleButton" value="保存" onclick="return findContent()"/><br/>
    	<label for="articleType">文章类型</label>
    	<input type="text" id="articleType" name="articleType" placeholder="学科新闻填0，行业资讯填1"/>
    	<label for="articleWriter">编辑名称</label>
    	<input type="text" id="articleWriter" name="articleWriter" placeholder="在这里输入编辑名称"/>
    	<label for="articleFrom">原文地址</label>
    	<input type="text" id="articleFrom" name="articleFrom" placeholder="在这里输入原文地址"/>
    	<input type="button" id="backButton" name="backButton" value="返回" onclick="javascript:history.back(-1);"/>
    </form>
    <script src="third-party/jquery-1.10.2.js"></script>
    <!-- 配置文件 -->
    <script type="text/javascript" src="ueditor.config.js"></script>
    <!-- 编辑器源码文件 -->
    <script type="text/javascript" src="ueditor.all.js"></script>
    <!-- 实例化编辑器 -->
    <script type="text/javascript">
        var ue = UE.getEditor('container');
    </script>
    
    <script>
	    var path = "editor/";
		
    	function findContent(){   	
    	$('#articleButton').attr('disabled',"true");
    	var uec = UE.getEditor('container');
    	ue.ready(function() {
   			var html = uec.getContent();
	    	$.post(path + "addArticle",
	  		{
	  		  articleContent:html,
	  		  articleName:$('#articleName').val(),	
	  		  articleTime:$('#articleTime').val(),	
	  		  articleGroup:$('#articleGroup').val(),	
	  		  articleType:$('#articleType').val(),
	  		  articleWriter:$('#articleWriter').val(),	
	  		  articleFrom:$('#articleFrom').val()
	 		 }, function(data,status){
		   		 alert("Data: " + data + "\nStatus: " + status);
		   		 $('#articleButton').removeAttr("disabled");
		   		 $('#articleName').val("");
		   		 $('#articleTime').val("");
		   		 $('#articleWriter').val("");
		   		 $('#articleGroup').val("");
		   		 $('#articleType').val("");
		   		 $('#articleFrom').val("");
		   		 var editor = UE.getEditor('container');
		   		 editor.execCommand('cleardoc');
	  		});
		});
    	
	   return true;
    }
    </script>
  </body>
</html>