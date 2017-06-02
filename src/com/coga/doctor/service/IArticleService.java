package com.coga.doctor.service;

import java.util.List;

import com.coga.doctor.pojo.Article;

public interface IArticleService {
	
	public int insert(Article article);
   
	public int update(Article article);
	
	public int updateStatus(Article article);
	
	public List<Article> getArticleByPage(Article article);
	
	public List<Article> getArticleByChineseByPage(Article article);
		
	public Article getArticleByName(String name);
	
	public Article getArticleById(int id);
	
	public int deleteByID(int id);
}
