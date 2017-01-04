package com.altmm.model.sys;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import org.codehaus.jackson.annotate.JsonIgnoreProperties;
import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;

import com.altmm.model.sys.param.AttachmentParameter;
import com.google.common.base.Objects;

/**
 * 附件的实体类
 * 
 */
@Entity
@Table(name = "attachment")
@Cache(region = "all", usage = CacheConcurrencyStrategy.NONSTRICT_READ_WRITE)
@JsonIgnoreProperties(value = { "maxResults", "firstResult", "topCount", "sortColumns", "cmd", "queryDynamicConditions",
		"sortedConditions", "dynamicProperties", "success", "message", "sortColumnsString", "flag" })
public class Attachment extends AttachmentParameter {

	// 各个字段的含义请查阅文档的数据库结构部分
	private static final long serialVersionUID = 7296680169194828397L;
	@Id
	@GeneratedValue
	@Column(name = "id")
	private Long id;
	@Column(name = "file_name", length = 100)
	private String fileName;
	@Column(name = "file_path", length = 1000)
	private String filePath;
	@Column(name = "type")
	private Short type;
	@Column(name = "type_id")
	private Long typeId;

	public Attachment() {

	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public String getFilePath() {
		return filePath;
	}

	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}

	public Short getType() {
		return type;
	}

	public void setType(Short type) {
		this.type = type;
	}

	public Long getTypeId() {
		return typeId;
	}

	public void setTypeId(Long typeId) {
		this.typeId = typeId;
	}

	public boolean equals(Object obj) {
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		final Attachment other = (Attachment) obj;
		return Objects.equal(this.id, other.id) && Objects.equal(this.fileName, other.fileName)
				&& Objects.equal(this.filePath, other.filePath) && Objects.equal(this.type, other.type)
				&& Objects.equal(this.typeId, other.typeId);
	}

	public int hashCode() {
		return Objects.hashCode(this.id, this.fileName, this.filePath, this.type, this.typeId);
	}

}
