package com.altmm.model.sys;

import static org.hibernate.search.annotations.FieldCacheType.CLASS;
import static org.hibernate.search.annotations.FieldCacheType.ID;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import org.apache.lucene.analysis.cn.smart.SmartChineseAnalyzer;
import org.codehaus.jackson.annotate.JsonIgnoreProperties;
import org.codehaus.jackson.map.annotate.JsonSerialize;
import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;
import org.hibernate.search.annotations.Analyzer;
import org.hibernate.search.annotations.CacheFromIndex;
import org.hibernate.search.annotations.DocumentId;
import org.hibernate.search.annotations.Field;
import org.hibernate.search.annotations.Index;
import org.hibernate.search.annotations.Indexed;
import org.hibernate.search.annotations.Store;

import com.altmm.model.sys.param.InformationParameter;
import com.google.common.base.Objects;

import core.support.DateTimeSerializer;

/**
 * 信息发布的实体类
 * 
 */
@Entity
@Table(name = "information")
@Cache(region = "all", usage = CacheConcurrencyStrategy.NONSTRICT_READ_WRITE)
@JsonIgnoreProperties(value = { "maxResults", "firstResult", "topCount", "sortColumns", "cmd", "queryDynamicConditions",
		"sortedConditions", "dynamicProperties", "success", "message", "sortColumnsString", "flag" })
@Indexed
@CacheFromIndex({ CLASS, ID })
public class Information extends InformationParameter {

	// 各个字段的含义请查阅文档的数据库结构部分
	private static final long serialVersionUID = 7306241552815502398L;
	@DocumentId
	@Id
	@GeneratedValue
	@Column(name = "id")
	private Long id;
	@Field(index = Index.YES, analyzer = @Analyzer(impl = SmartChineseAnalyzer.class) , store = Store.YES)
	@Column(name = "title", length = 100, nullable = false)
	private String title;
	@Field(index = Index.YES, analyzer = @Analyzer(impl = SmartChineseAnalyzer.class) , store = Store.YES)
	@Column(name = "author", length = 40)
	private String author;
	@Column(name = "refresh_time")
	@Temporal(TemporalType.TIMESTAMP)
	private Date refreshTime;
	@Field(index = Index.YES, analyzer = @Analyzer(impl = SmartChineseAnalyzer.class) , store = Store.YES)
	@Column(name = "content", columnDefinition = "LONGTEXT")
	private String content;

	public Information() {

	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getAuthor() {
		return author;
	}

	public void setAuthor(String author) {
		this.author = author;
	}

	@JsonSerialize(using = DateTimeSerializer.class)
	public Date getRefreshTime() {
		return refreshTime;
	}

	public void setRefreshTime(Date refreshTime) {
		this.refreshTime = refreshTime;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public boolean equals(Object obj) {
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		final Information other = (Information) obj;
		return Objects.equal(this.id, other.id) && Objects.equal(this.title, other.title)
				&& Objects.equal(this.author, other.author) && Objects.equal(this.content, other.content);
	}

	public int hashCode() {
		return Objects.hashCode(this.id, this.title, this.author, this.content);
	}

}
