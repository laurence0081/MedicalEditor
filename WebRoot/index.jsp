<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML>
<html lang="cn-ZH">
  <head>
    <base href="<%=basePath%>">
    
    <title>Medical editor</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<meta charset="UTF-8">
	
   <style>
     .divMain{
       width:480px;/*(一定要设置这个值)*/
       height:320px;/*(一定要设置这个值)*/
       margin-left: auto; 
       margin-right: auto;	
	   text-align:center;
       vertical-align:middle;
       /*想要两个滚动条的话就把下面的去掉*/
       left:50%;/*FF IE7*/
       top: 50%;/*FF IE7*/
       margin-left:-240px!important;/*FF IE7 该值为本身宽的一半(一定要设置这个值)*/
       margin-top:-160px!important;/*FF IE7 该值为本身高的一半(一定要设置这个值)*/	
       margin-top:0px;	        
       position:fixed!important;/*FF IE7*/
       position:absolute;/*IE6*/
       _top:expression(eval(document.compatMode &&
      document.compatMode=='CSS1Compat') ?
      documentElement.scrollTop + (document.documentElement.clientHeight-this.offsetHeight)/2 :/*IE6*/
      document.body.scrollTop + (document.body.clientHeight - this.clientHeight)/2);/*IE5 IE5.5*/
     } 
     form{margin-top:25%!important}
	</style>
  </head>
  
  <body>
  	<div class="divMain">	
	  <form>
	    <input type="button" id="subjectNews" name="subjectNews" value="学科新闻" onclick="return jumpToSN()"/>
	  	<input type="button" id="industryNews" name="industryNews" value="行业资讯" onclick="return jumpToIN()"/>
	  </form>
  	</div>
  	<script type="text/javascript">
  		function jumpToSN(){
  			location.href = "editor/newsList?pageNum=1&pageSize=50&type=0";
  		}
  		function jumpToIN(){
  			location.href = "editor/newsList?pageNum=1&pageSize=50&type=1";
  		}
  	</script>
  </body>
</html>
