<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
pageContext.setAttribute("basePath",basePath); 
%>
<!DOCTYPE HTML>
<html lang="en-US">
  <head>
    <base href="<%=basePath%>">
    
    <title>医学文章列表</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta charset="UTF-8">
	<link rel="stylesheet" href="test.css" type="text/css"/>
  </head>
  
  <body>
  	<div id="dlgReply">
    <form id="articleForm" name="articleForm" method="post">
	  <table rules=all style="width:800px;margin:0 auto;text-align:center;margin-top:100px;border:1px solid #000">
	    <caption align="top" style="font-size:24px;">医学文章列表</caption>  
	    <thead>
		  <tr>
            <th>文章序号</th>
            <th onclick="orderByChinese()">文章标题</th>
            <th>转载时间</th>
            <th>文章来源</th>
            <th>上传编辑</th>
            <th>所属学组</th>
            <th>文章状态</th>
            <th>操        作</th>
          </tr>
		</thead>
					
		<tbody>
		  <c:forEach items="${articleList}" var="article">
		 	<tr>
              <td>${article.id}</td>
              <td>${article.articlename}</td>
              <td>${article.articletime}</td>
              <td>${article.articlefrom}</td>
              <td>${article.articlewriter}</td>
              <td>${article.articlegroup}</td>
              <td>
                <c:if test="${article.status == 0}">未审核</c:if>
                <c:if test="${article.status == 1}">审核通过</c:if>
                <c:if test="${article.status == 2}">审核不通过</c:if>
              </td>
              <td>
                <a onclick="deleteArticle(${article.id})">删除</a>&nbsp;&nbsp;
                <a onclick="checkArticle(${article.id})">查看</a>
              </td>
            </tr>
		  </c:forEach>
		</tbody>
      </table>      
      
      <div style="width:800px;margin:0 auto;text-align:center;">
      	<a onclick="firstPage()">首页</a>
    	<c:if test="${page.currentPage > 1}">
    	  <a onclick="prePage()">上一页</a>
    	</c:if>
    	<c:if test="${page.currentPage < page.totalPage}">
    	  <a onclick="nextPage()">下一页</a>
    	</c:if>
     	<a>当前是第${page.currentPage}页</a>   	    
     	<a onclick="lastPage()">末页</a>
     	<input type="text" name="pnum" id="pnum" /> <input type="button" value="确定" onclick="changePnum()">
     	<br/>
     	<input type="button" value="新建" onclick="addArticle()">
      </div>
    </form>
    
    
    <div style="display:none">
    	<input id="typeV" name="typeV" type="text" value=${type}>
    	<input id="pageNum" name="pageNum" type="text" value=${page.currentPage}>
    	<input id="prePage" name="prePage" type="text" value=${page.prePage}>
    	<input id="nextPage" name="prePage" type="text" value=${page.nextPage}>
    	<input id="totalPage" name="prePage" type="text" value=${page.totalPage}>
    	<input id="pageSize" name="pageSize" type="text" value=${page.pageSize}>
    	<input id="order" name="order" type="text" value=${order}>
    </div>
    
    <div style="width:800px;margin:0 auto;text-align:center">
    <label for="findId">文章id</label>
    <input type="text" id="findId" name="findId" placeholder="在这里输入文章名称"/>
    <input type="button" value="查询" onclick="findArticleById()">
    </div>
    </div>
    <script src="third-party/jquery-1.10.2.js"></script>
    <script type="text/javascript">
    	var path = "editor/";
    	
    	window.onload=function(){
    		if (!!window.ActiveXObject || "ActiveXObject" in window) { 
    			path = ""; 
    		} 
    	}
      	
    	function findArticleById(){
    		var id = $('#findId').val();
    		var typeVal = $('#typeV').val();
    		var pageNumVal = $('#pageNum').val();
    		var pageSizeVal = $('#pageSize').val();
    		location.href = path + "checkArticle?articleId="+id+"&pageNum="+pageNumVal+"&pageSize="+pageSizeVal+"&type="+typeVal;
    		return false;
    	}
    	
    	function deleteArticle(id){
    		var typeVal = $('#typeV').val();
    		var pageNumVal = $('#pageNum').val();
    		var pageSizeVal = $('#pageSize').val();
    		
    		if(confirm('确认删除该条记录吗?'))
    			location.href=path + "deleteArticle?articleId="+id+"&pageNum="+pageNumVal+"&pageSize="+pageSizeVal+"&type="+typeVal;
    		return false;
    	}
    	
    	function checkArticle(id){    		
    		var typeVal = $('#typeV').val();
    		var pageNumVal = $('#pageNum').val();
    		var pageSizeVal = $('#pageSize').val();
    		
    		location.href = path + "checkArticle?articleId="+id+"&pageNum="+pageNumVal+"&pageSize="+pageSizeVal+"&type="+typeVal;
    		return false;
    	}
      	
  		function changePnum(){
    		var typeVal = $('#typeV').val();
    		var pageNumVal = $('#pageNum').val();
    		var pageSizeVal = $('#pageSize').val();
    		var order = $('#order').val();
    		var target = "newsList";
    		
    		if(order == 1) target = target + "ByChinese";
    		
  			location.href = path + target + "?pageNum="+pageNumVal+"&pageSize="+pageSizeVal+"&type="+typeVal;
  			return false;
  		}	
  		function addArticle(){
    		var typeVal = $('#typeV').val();
    		var pageNumVal = $('#pageNum').val();
    		var pageSizeVal = $('#pageSize').val();
    		
  			location.href = path + "medicalEditor?pageNum="+pageNumVal+"&pageSize="+pageSizeVal+"&type="+typeVal;
  			return false;
  		}
  		
  		function prePage(){
    		var typeVal = $('#typeV').val();
    		var prePageVal = $('#prePage').val();
    		var pageSizeVal = $('#pageSize').val();
    		var order = $('#order').val();
    		var target = "newsList";
    		
    		if(order == 1) target = target + "ByChinese";
    		
  			location.href = path + target + "?pageNum="+prePageVal+"&pageSize="+pageSizeVal+"&type="+typeVal;
  			return false;
  		}
  		
  		function nextPage(){
    		var typeVal = $('#typeV').val();
    		var nextPageVal = $('#nextPage').val();
    		var pageSizeVal = $('#pageSize').val();

    		var order = $('#order').val();
    		var target = "newsList";
    		
    		if(order == 1) target = target + "ByChinese";
    		
  			location.href = path + target + "?pageNum="+nextPageVal+"&pageSize="+pageSizeVal+"&type="+typeVal;
  			return false;
  		}
  		
  		function firstPage(){
    		var typeVal = $('#typeV').val();
    		var pageSizeVal = $('#pageSize').val();

    		var order = $('#order').val();
    		var target = "newsList";
    		
    		if(order == 1) target = target + "ByChinese";
    		
  			location.href = path + target + "?pageNum=1&pageSize="+pageSizeVal+"&type="+typeVal;
  			return false;
  		}
  		
  		function lastPage(){
    		var typeVal = $('#typeV').val();
    		var totalPageVal = $('#totalPage').val();
    		var pageSizeVal = $('#pageSize').val();
    		var order = $('#order').val();
    		var target = "newsList";
    		
    		if(order == 1) target = target + "ByChinese";
  			    		
  			location.href = path + target + "?pageNum="+totalPageVal+"&pageSize="+pageSizeVal+"&type="+typeVal;
  			return false;
  		}
  		function orderByChinese(){
  			location.href = "editor/newsListByChinese?pageNum=1&pageSize=50&type=0";
  			return false;
  		}
  	</script>
  </body>
</html>