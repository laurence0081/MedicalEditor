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
  	<center>
    <form id="articleForm" name="articleForm" method="post">
		<!-- 加载编辑器的容器 -->
        <script id="container" name="content" type="text/plain">
		${article.articlecontent}
    	</script>
    	<label for="articleName">文章名称</label>
    	<input type="text" id="articleName" name="articleName" placeholder="在这里输入文章名称" value="${article.articlename}"/>
    	<label for="articleTime">转载时间</label>
    	<input type="text" id="articleTime" name="articleTime" placeholder="在这里输入转载时间" value="${article.articletime}"/>
    	<label for="articleGroup">所属学组</label>
    	<input type="text" id="articleGroup" name="articleGroup" placeholder="在这里输入所属学组（没有就填0）" value="${article.articlegroup}"/>   
    	<br></br>
    	<label for="articleType">文章类型</label>
    	<input type="text" id="articleType" name="articleType" placeholder="学科新闻填0，行业资讯填1" value="${article.articletype}"/>
    	<label for="articleWriter">编辑名称</label>
    	<input type="text" id="articleWriter" name="articleWriter" placeholder="在这里输入编辑名称" value="${article.articlewriter}"/>
    	<label for="articleFrom">原文地址</label>
    	<input type="text" id="articleFrom" name="articleFrom" placeholder="在这里输入原文地址" value="${article.articlefrom}"/>
    	<br></br>
    	<input type="button" id="backButton" name="backButton" value="返回" onclick="return backList()"/> 	
    	<input type="button" id="articleButton" name="articleButton" value="修改" onclick="return findContent()"/>
    	<input type="button" id="checkButton" name="checkButton" value="审核通过" onclick="return checkOk()"/>
    	<input type="button" id="checkButton" name="checkButton" value="审核不通过" onclick="return checkFalse()"/>
    </form>
    </<center>
    
    <div style="display:none">
    	<input id="typeV" name="typeV" type="text" value=${type}>
    	<input id="pageNum" name="pageNum" type="text" value=${pageNum}>
    	<input id="pageSize" name="pageSize" type="text" value=${pageSize}>
    </div>
    
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
    	var ue = UE.getEditor('container');
    	
    	var path = "editor/";
    	window.onload=function(){
    		if (!!window.ActiveXObject || "ActiveXObject" in window) { 
    			path = ""; 
    		} 
    	}
    	    
    	function checkOk(){
    		var articleId = ${article.id};
    		$.post("editor/modifyStatus",
    		{
    			status:1,
    			articleId:articleId
    		}, function(data,status){
		   		 alert("Data: " + data + "\nStatus: " + status);
		   		 $('#articleButton').removeAttr("disabled");
	  		});
    	}
    	
    	function checkFalse(){
    		var articleId = ${article.id};
    		$.post("editor/modifyStatus",
    		{
    			status:2,
    			articleId:articleId
    		}, function(data,status){
		   		 alert("Data: " + data + "\nStatus: " + status);
		   		 $('#articleButton').removeAttr("disabled");
	  		});
    	}
    	
    	function backList(){
    		var typeVal = $('#typeV').val();
    		var pageNumVal = $('#pageNum').val();
    		var pageSizeVal = $('#pageSize').val();
    		
    		location.href = path + "newsList?pageNum="+pageNumVal+"&pageSize="+pageSizeVal+"&type="+typeVal;
    	}
    	
    	function findContent(){   	
    	$('#articleButton').attr('disabled',"true");
    	var ue = UE.getEditor('container');
    	ue.ready(function() {
   			var html = ue.getContent();
   			var id = ${article.id};
	    	$.post("editor/modifyArticle",
	  		{
	    	  articleId:id,
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
	  		});
		});
    	
	   return true;
    }
    </script>
  </body>
</html>