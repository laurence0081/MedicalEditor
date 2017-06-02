package com.coga.doctor.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.coga.doctor.dao.IArticleDao;
import com.coga.doctor.pojo.Article;
import com.coga.doctor.service.IArticleService;

@Service("managerService")
public class ArticleServiceImpl implements IArticleService {
	@Resource
	private IArticleDao articleDao;
	
	private int result = 0;
	
	public int insert(Article article){
		result = this.articleDao.insert(article);
		return result;
	}
   
	public int update(Article article){
		result = this.articleDao.update(article);
		return result;
	}
	

	public int updateStatus(Article article){
		result = this.articleDao.updateStatus(article);
		return result;
	}
	
	public List<Article> getArticleByPage(Article article){
		return this.articleDao.selectArticleByPage(article);
	}
	
	public List<Article> getArticleByChineseByPage(Article article){
		return this.articleDao.selectArticleByChineseByPage(article);
	}
	
	public Article getArticleByName(String name){
		return this.articleDao.selectArticleByName(name);
	}
	
	public Article getArticleById(int id){
		return this.articleDao.selectArticleById(id);
	}
	
	public int deleteByID(int id){
		return this.articleDao.deleteByID(id);
	}
	
	public void setArticleDao(IArticleDao articleDao) {
		this.articleDao = articleDao;
	}
}
