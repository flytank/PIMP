package com.altmm.model.sys;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import org.codehaus.jackson.annotate.JsonIgnoreProperties;
import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;
import org.hibernate.annotations.GenericGenerator;

import com.altmm.model.sys.param.MessageParameter;

/**
 * @file Message.java
 * @category 留言表的实体类
 * @author xumin
 * @date 2016年3月23日 下午2:08:00
 */
@Entity
@Table(name = "message")
@Cache(region = "all", usage = CacheConcurrencyStrategy.NONSTRICT_READ_WRITE)
@JsonIgnoreProperties(value = { "maxResults", "firstResult", "topCount",
		"sortColumns", "cmd", "queryDynamicConditions", "sortedConditions",
		"dynamicProperties", "success", "message", "sortColumnsString", "flag" })
public class Message extends MessageParameter {

	private static final long serialVersionUID = 8501847576186439566L;
	@Id
	@GenericGenerator(name = "idGenerator", strategy = "uuid")
	@GeneratedValue(generator = "idGenerator")
	@Column(name = "UUID")
	private String id;
	@Column(name = "messageID", length = 40, nullable = false)
	private String messageID;// 留言对象ID
	@Column(name = "content", length = 255)
	private String content; // 内容
	@Column(name = "user", length = 40)
	private String user;// 公告者,用户主键
	@Column(name = "messageSource", length = 40)
	private int messageSource;// 留言对象来源，1为活动，2为公示
	@Column(name = "time")
	@Temporal(TemporalType.DATE)
	private Date time;// 留言时间

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getMessageID() {
		return messageID;
	}

	public void setMessageID(String messageID) {
		this.messageID = messageID;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getUser() {
		return user;
	}

	public void setUser(String user) {
		this.user = user;
	}

	public int getMessageSource() {
		return messageSource;
	}

	public void setMessageSource(int messageSource) {
		this.messageSource = messageSource;
	}

	public Date getTime() {
		return time;
	}

	public void setTime(Date time) {
		this.time = time;
	}

}