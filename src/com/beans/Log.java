package com.beans;

import java.sql.Date;
import java.time.LocalDate;

public class Log {
	
	public final static String TABLENAME = "logs";
	public final static String COLUMN_PAGENAME = "pagename";
	public final static String COLUMN_REQUEST = "request";
	public final static String COLUMN_DATE= "datetime";
	public final static String COLUMN_USERID = "userid";
	public final static String COLUMN_IDLOGS= "idlogs";
	
	
	
	private String pagename, request, date;
	private int userid, logid;
	
	
	public Log(String pagename, String request, String date, int userid, int logid) {
		this.pagename = pagename;
		this.request = request;
		this.date = date;
		this.userid = userid;
		this.logid = logid;
	}
	public Log(String pagename, String request, int userid) {
		this.pagename = pagename;
		this.request = request;
		this.userid = userid;
	}
	public Log() {
		// TODO Auto-generated constructor stub
	}
	public String getPagename() {
		return pagename;
	}
	public void setPagename(String pagename) {
		this.pagename = pagename;
	}
	public String getRequest() {
		return request;
	}
	public void setRequest(String request) {
		this.request = request;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public int getUserid() {
		return userid;
	}
	public void setUserid(int userid) {
		this.userid = userid;
	}
	public int getLogid() {
		return logid;
	}
	public void setLogid(int logid) {
		this.logid = logid;
	}
	
	
	
	
}
