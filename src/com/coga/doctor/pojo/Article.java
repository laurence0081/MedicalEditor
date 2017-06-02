package com.coga.doctor.pojo;

import com.coga.doctor.util.PageParameter;

public class Article {
	public Integer id;
	public String articlename;
	public String articletime;
	public String articlewriter;
	public String articlefrom;
	public String articlecontent;
	public Integer articlegroup;
	public Integer articletype;
	public Integer status;
	public Integer replynum;
	public Integer favnum;
	public PageParameter page;
	
	public Integer getArticlegroup() {
		return articlegroup;
	}
	public void setArticlegroup(Integer articlegroup) {
		this.articlegroup = articlegroup;
	}
	public Integer getArticletype() {
		return articletype;
	}
	public void setArticletype(int articletype) {
		this.articletype = articletype;
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getArticlename() {
		return articlename;
	}
	public void setArticlename(String articlename) {
		this.articlename = articlename;
	}
	public String getArticletime() {
		return articletime;
	}
	public void setArticletime(String articletime) {
		this.articletime = articletime;
	}
	public String getArticlewriter() {
		return articlewriter;
	}
	public void setArticlewriter(String articlewriter) {
		this.articlewriter = articlewriter;
	}
	public String getArticlefrom() {
		return articlefrom;
	}
	public void setArticlefrom(String articlefrom) {
		this.articlefrom = articlefrom;
	}
	public String getArticlecontent() {
		return articlecontent;
	}
	public void setArticlecontent(String articlecontent) {
		this.articlecontent = articlecontent;
	}
	public Integer getStatus() {
		return status;
	}
	public void setStatus(Integer status) {
		this.status = status;
	}
	public PageParameter getPage() {
		return page;
	}
	public void setPage(PageParameter page) {
		this.page = page;
	}
	public Integer getReplynum() {
		return replynum;
	}
	public void setReplynum(Integer replynum) {
		this.replynum = replynum;
	}
	public Integer getFavnum() {
		return favnum;
	}
	public void setFavnum(Integer favnum) {
		this.favnum = favnum;
	}
	public String toString(){
		String result ="";
		
		result = "{\"id\":"+id+"\", \"articlename\":\""+articlename+"\",\"articletime\":\""+articletime+"\",\"articlewriter\":\""+articlewriter+ "\","
				+ "\"articlefrom\":"+articlefrom+"\", \"articlecontent\":\""+articlecontent+"\",\"articlegroup\":\""+articlegroup+"\","
				+ "\"articletype\":\""+articletype+ "\","+ "\"status\":"+status+"\", \"replynum\":\""+replynum+"\","
				+ "\"favnum\":"+favnum+"\"}";
		
		return result;
	}
}
