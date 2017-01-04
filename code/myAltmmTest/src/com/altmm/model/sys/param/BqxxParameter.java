package com.altmm.model.sys.param;

import core.support.ExtJSBaseParameter;

/*
 * 病区信息
 */
public class BqxxParameter extends ExtJSBaseParameter {

	private static final long serialVersionUID = -3724190570490039584L;
	private String $eq_bqmc;
	private String $like_bqlx;

	public String get$eq_bqmc() {
		return $eq_bqmc;
	}

	public void set$eq_bqmc(String $eq_bqmc) {
		this.$eq_bqmc = $eq_bqmc;
	}

	public String get$like_bqlx() {
		return $like_bqlx;
	}

	public void set$like_bqlx(String $like_bqlx) {
		this.$like_bqlx = $like_bqlx;
	}

}
