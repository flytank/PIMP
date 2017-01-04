package com.altmm.model.sys;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import org.codehaus.jackson.annotate.JsonIgnoreProperties;
import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;
import org.hibernate.annotations.GenericGenerator;

import com.altmm.model.sys.param.BqxxParameter;
import com.google.common.base.Objects;

/*
 * 病区的实体类
 */
@Entity
@Table(name = "bqxx")
@Cache(region = "all", usage = CacheConcurrencyStrategy.NONSTRICT_READ_WRITE)
@JsonIgnoreProperties(value = { "maxResults", "firstResult", "topCount",
		"sortColumns", "cmd", "queryDynamicConditions", "sortedConditions",
		"dynamicProperties", "success", "message", "sortColumnsString", "flag" })
public class Bqxx extends BqxxParameter {
	private static final long serialVersionUID = 2819535446750616409L;
	@Id
	@GenericGenerator(name = "idGenerator", strategy = "uuid")
	@GeneratedValue(generator = "idGenerator")
	@Column(name = "bqid")
	private String bqid;
	@Column(name = "bqmc", length = 64)
	private String bqmc;
	@Column(name = "bqlx", length = 64)
	private String bqlx;
	@Column(name = "czdrcf")
	private Long czdrcf;
	@Column(name = "dytzyz")
	private Long dytzyz;
	@Column(name = "zdcfyz")
	private Long zdcfyz;
	@Column(name = "zdcfsj", length = 2)
	private String zdcfsj;

	public Bqxx() {
	}

	public String getBqid() {
		return bqid;
	}

	public void setBqid(String bqid) {
		this.bqid = bqid;
	}

	public String getBqmc() {
		return bqmc;
	}

	public void setBqmc(String bqmc) {
		this.bqmc = bqmc;
	}

	public String getBqlx() {
		return bqlx;
	}

	public void setBqlx(String bqlx) {
		this.bqlx = bqlx;
	}

	public Long getCzdrcf() {
		return czdrcf;
	}

	public void setCzdrcf(Long czdrcf) {
		this.czdrcf = czdrcf;
	}

	public Long getDytzyz() {
		return dytzyz;
	}

	public void setDytzyz(Long dytzyz) {
		this.dytzyz = dytzyz;
	}

	public Long getZdcfyz() {
		return zdcfyz;
	}

	public void setZdcfyz(Long zdcfyz) {
		this.zdcfyz = zdcfyz;
	}

	public String getZdcfsj() {
		return zdcfsj;
	}

	public void setZdcfsj(String zdcfsj) {
		this.zdcfsj = zdcfsj;
	}

	public boolean equals(Object obj) {
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		final Bqxx other = (Bqxx) obj;
		return Objects.equal(this.bqid, other.bqid)
				&& Objects.equal(this.bqmc, other.bqmc)
				&& Objects.equal(this.bqlx, other.bqlx)
				&& Objects.equal(this.czdrcf, other.czdrcf)
				&& Objects.equal(this.dytzyz, other.dytzyz)
				&& Objects.equal(this.zdcfyz, other.zdcfyz)
				&& Objects.equal(this.zdcfsj, other.zdcfsj);
	}

	public int hashCode() {
		return Objects.hashCode(this.bqid, this.bqmc, this.bqlx, this.czdrcf,
				this.dytzyz, this.zdcfyz, this.zdcfsj);
	}

}
