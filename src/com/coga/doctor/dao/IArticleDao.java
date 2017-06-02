package com.coga.doctor.dao;

import java.util.List;

import com.coga.doctor.pojo.Article;

public interface IArticleDao {

	int insert(Article article);
	   
	int update(Article article);

	int updateStatus(Article article);
	
	List<Article> selectArticleByPage(Article article);
	
	List<Article> selectArticleByChineseByPage(Article article);
		
	Article selectArticleByName(String name);
	
	Article selectArticleById(int id);
	
	int deleteByID(int id);
}
