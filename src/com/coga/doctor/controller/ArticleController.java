package com.coga.doctor.controller;

import java.io.File;
import java.io.IOException;
import java.util.Iterator;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;

import com.coga.doctor.pojo.Article;
import com.coga.doctor.service.IArticleService;
import com.coga.doctor.util.PageParameter;

@Controller
public class ArticleController {

	@Resource
	private IArticleService articleService;
		
	@RequestMapping(value="/editor/addArticle")
	@ResponseBody
	public String addArticle (HttpServletRequest request) {
		String resultStr = "ok";
				
		String articleContent = request.getParameter("articleContent");	
		String articleName = request.getParameter("articleName");		
		String articleTime = request.getParameter("articleTime"); 
		String articleWriter = request.getParameter("articleWriter"); 
		String articleFrom = request.getParameter("articleFrom"); 	
		int articleGroup = Integer.parseInt(request.getParameter("articleGroup")); 
		int articleType = Integer.parseInt(request.getParameter("articleType")); 	
		
		Article article = new Article();
		article.setArticlecontent(articleContent);
		article.setArticlefrom(articleFrom);
		article.setArticlename(articleName);
		article.setArticletime(articleTime);
		article.setArticlewriter(articleWriter);
		article.setArticlegroup(articleGroup);
		article.setArticletype(articleType);
		article.setStatus(0);
		article.setFavnum(0);
		article.setReplynum(0);
		
		int result = articleService.insert(article);
		if(result == 0) resultStr = "false";
		
		return resultStr;
	}
	
	@RequestMapping(value="/editor/newsList")
	public String showSujectNewsList (HttpServletRequest request, Model model) {		
		int pageNum = Integer.parseInt(request.getParameter("pageNum")); 	
		int pageSize = Integer.parseInt(request.getParameter("pageSize")); 	
		int type = Integer.parseInt(request.getParameter("type"));
		
		Article article = new Article();
		article.setArticletype(type);
		PageParameter page = new PageParameter();
		page.setCurrentPage(pageNum);
		page.setPageSize(pageSize);
		article.setPage(page);
		List<Article> articleList = articleService.getArticleByPage(article);
		page = article.getPage();
						
		if(pageNum > 1) page.setPrePage(pageNum - 1); else page.setPageSize(1);
		if(pageNum < page.getTotalPage())	page.setNextPage(pageNum + 1); else page.setNextPage(pageNum);
		page.setCurrentPage(pageNum);
		page.setPageSize(pageSize);
		
		model.addAttribute("articleList", articleList);
		model.addAttribute("page",page);
		model.addAttribute("type",type);
		model.addAttribute("order",0);
		
		
		return "listEditor";
	}
	
	@RequestMapping(value="/editor/newsListByChinese")
	public String showSujectNewsListByChinese (HttpServletRequest request, Model model) {		
		int pageNum = Integer.parseInt(request.getParameter("pageNum")); 	
		int pageSize = Integer.parseInt(request.getParameter("pageSize")); 	
		int type = Integer.parseInt(request.getParameter("type"));
		
		Article article = new Article();
		article.setArticletype(type);
		PageParameter page = new PageParameter();
		page.setCurrentPage(pageNum);
		page.setPageSize(pageSize);
		article.setPage(page);
		List<Article> articleList = articleService.getArticleByChineseByPage(article);
		page = article.getPage();
						
		if(pageNum > 1) page.setPrePage(pageNum - 1); else page.setPageSize(1);
		if(pageNum < page.getTotalPage())	page.setNextPage(pageNum + 1); else page.setNextPage(pageNum);
		page.setCurrentPage(pageNum);
		page.setPageSize(pageSize);
		
		model.addAttribute("articleList", articleList);
		model.addAttribute("page",page);
		model.addAttribute("type",type);
		model.addAttribute("order",1);
		
		
		return "listEditor";
	}
	
	@RequestMapping(value="/editor/checkArticle")
	public String checkArticle (HttpServletRequest request, Model model) {		
		int articleId = Integer.parseInt(request.getParameter("articleId")); 		
		int pageNum = Integer.parseInt(request.getParameter("pageNum")); 	
		int pageSize = Integer.parseInt(request.getParameter("pageSize")); 	
		int type = Integer.parseInt(request.getParameter("type"));
		
		Article article = new Article();
		article = articleService.getArticleById(articleId);
		
		model.addAttribute("article",article);
		model.addAttribute("pageNum",pageNum);
		model.addAttribute("pageSize",pageSize);
		model.addAttribute("type",type);		
		
		return "checkContent";
	}
	
	@RequestMapping(value="/editor/modifyArticle", method=RequestMethod.POST)
	@ResponseBody
	public String modifyArticle (HttpServletRequest request) {
		String resultStr = "ok";
		
		System.out.println(resultStr);
		
		int articleId = Integer.parseInt(request.getParameter("articleId"));
		String articleContent = request.getParameter("articleContent");	
		String articleName = request.getParameter("articleName");		
		String articleTime = request.getParameter("articleTime"); 
		String articleWriter = request.getParameter("articleWriter"); 
		String articleFrom = request.getParameter("articleFrom"); 	
		int articleGroup = Integer.parseInt(request.getParameter("articleGroup")); 
		int articleType = Integer.parseInt(request.getParameter("articleType")); 	
		
		Article article = new Article();
		article.setId(articleId);
		article.setArticlecontent(articleContent);
		article.setArticlefrom(articleFrom);
		article.setArticlename(articleName);
		article.setArticletime(articleTime);
		article.setArticlewriter(articleWriter);
		article.setArticlegroup(articleGroup);
		article.setArticletype(articleType);
		
		int result = articleService.update(article);
		if(result == 0) resultStr = "false";
		
		return resultStr;
	}
		
	@RequestMapping(value="/editor/deleteArticle")
	public String deleteArticle (HttpServletRequest request) {
		String resultStr = "ok";
		
		int articleId = Integer.parseInt(request.getParameter("articleId"));	
		int pageNum = Integer.parseInt(request.getParameter("pageNum")); 	
		int pageSize = Integer.parseInt(request.getParameter("pageSize")); 	
		int type = Integer.parseInt(request.getParameter("type"));
				
		int result = articleService.deleteByID(articleId);
		if(result == 1) resultStr = "forward:/editor/newsList?pageNum="+pageNum+"&pageSize="+pageSize+"&type="+type;
		
		return resultStr;
	}
	
	@RequestMapping(value="/editor/modifyStatus", method=RequestMethod.POST)
	@ResponseBody
	public String modifyStatus (HttpServletRequest request) {
		String resultStr = "ok";
		
		int articleId = Integer.parseInt(request.getParameter("articleId"));
		int status = Integer.parseInt(request.getParameter("status")); 	
		
		Article article = new Article();
		article.setId(articleId);
		article.setStatus(status);
		
		int result = articleService.updateStatus(article);
		if(result == 0) resultStr = "false";
		
		return resultStr;
	}
	
	@RequestMapping(value="/editor/medicalEditor")
	public String medicalEditor (HttpServletRequest request, Model model) {		
		int pageNum = Integer.parseInt(request.getParameter("pageNum")); 	
		int pageSize = Integer.parseInt(request.getParameter("pageSize")); 	
		int type = Integer.parseInt(request.getParameter("type"));
		
		model.addAttribute("pageNum",pageNum);
		model.addAttribute("pageSize",pageSize);
		model.addAttribute("type",type);
		return "medicalEditor";
	}
	
	@RequestMapping("/editor/upload")  
	@ResponseBody
    public String upload(HttpServletRequest request,HttpServletResponse response){  		
	  	
		String path = "";
		String fileName = "";
		
        //创建一个通用的多部分解析器  
        CommonsMultipartResolver multipartResolver = new CommonsMultipartResolver(request.getSession().getServletContext());  
        //判断 request 是否有文件上传,即多部分请求  
        if(multipartResolver.isMultipart(request)){  
        	    	
            //转换成多部分request    
            MultipartHttpServletRequest multiRequest = (MultipartHttpServletRequest)request;  
            //取得request中的所有文件名  
            Iterator<String> iter = multiRequest.getFileNames();  
            while(iter.hasNext()){  
                //取得上传文件  
                MultipartFile file = multiRequest.getFile(iter.next());  
                if(file != null){  
                    //取得当前上传文件的文件名称  
                    String myFileName = file.getOriginalFilename();  
                    //如果名称不为“”,说明该文件存在，否则说明该文件不存在  
                    if(myFileName.trim() !=""){  
                        System.out.println(myFileName);  
                        //重命名上传后的文件名  
                        fileName = String.valueOf(System.currentTimeMillis()) + file.getOriginalFilename();  
                        //定义上传路径  
                        path = "/home/imgs/user/selfpic" + fileName;  
                        File localFile = new File(path);  
                        try {
							file.transferTo(localFile);
						} catch (IllegalStateException e) {
							e.printStackTrace();
						} catch (IOException e) {
							e.printStackTrace();
						}                         
						
						/*int result = userService.updateImg(id, path);
						if(result == 1) {
							data.setRetCode(200);
							data.setRetDesc("success");
							path = Constant.IMG_URL + fileName;
							data.setData("\"" + path + "\"");
						} else {
							data.setRetCode(400);
							data.setRetDesc("update fail");
						}	*/					

                    }  
                }    
            }  
              
        }  
        return fileName;  
    } 
	
	public IArticleService getArticleService() {
		return articleService;
	}

	public void setArticleService(IArticleService articleService) {
		this.articleService = articleService;
	}
}
