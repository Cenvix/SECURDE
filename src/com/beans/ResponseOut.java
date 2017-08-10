package com.beans;

import com.services.Sanitizer;

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
		this.message = Sanitizer.sanitizeXSS(message);
	}
	public boolean isSucess() {
		return sucess;
	}
	public void setSucess(boolean status) {
		this.sucess = status;
	}
}
