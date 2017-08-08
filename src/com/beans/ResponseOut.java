package com.beans;

public class ResponseOut {


	String message;
	boolean sucess;
	
	public ResponseOut(){
		this.sucess = false;
		this.message=null;
	}
	
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	public boolean isSucess() {
		return sucess;
	}
	public void setSucess(boolean status) {
		this.sucess = status;
	}
}
