package com.jiny.web.menu.model;

public class MenuVO {
	
	private int mid;
	private String code;
	private String codename;
	private int sort_num;
	private String comment;
	private String reg_id;
	private String reg_dt;
	
	public int getMid() {
		return mid;
	}
	
	public void setMid(int mid) {
		this.mid = mid;
	}
	
	public String getCode() {
		return code;
	}
	
	public void setCode(String code) {
		this.code = code;
	}
	
	public String getCodename() {
		return codename;
	}
	
	public void setCodename(String codename) {
		this.codename = codename;
	}
	
	public int getSort_num() {
		return sort_num;
	}
	
	public void setSort_num(int sort_num) {
		this.sort_num = sort_num;
	}
	
	public String getComment() {
		return comment;
	}
	
	public void setComment(String comment) {
		this.comment = comment;
	}
	
	public String getReg_id() {
		return reg_id;
	}
	
	public void setReg_id(String reg_id) {
		this.reg_id = reg_id;
	}
	
	public String getReg_dt() {
		return reg_dt;
	}
	
	public void setReg_dt(String reg_dt) {
		this.reg_dt = reg_dt;
	}

	@Override
	public String toString() {
		return "MenuVO [mid=" + mid + ", code=" + code + ", codename=" + codename + ", sort_num=" + sort_num + ", comment=" + comment + ", reg_id=" + reg_id + ", reg_dt=" + reg_dt + "]";
	}
}
