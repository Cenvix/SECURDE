package com.beans;

import java.io.Serializable;
import java.sql.Date;
import java.util.ArrayList;
import java.util.Random;

//import com.mysql.fabric.xmlrpc.base.Array;

public class User implements Serializable {
    
    public final static String TABLE_NAME = "users";
    public final static String COLUMN_ID = "idusers";
    public final static String COLUMN_FIRSTNAME = "firstname";
    public final static String COLUMN_MIDDLENAME = "middlename";
    public final static String COLUMN_LASTNAME = "lastname";
    public final static String COLUMN_EMAIL = "emailaddress";
    public final static String COLUMN_PASSWORD = "password";
    public final static String COLUMN_USERNUMBER = "usernumber";
    public final static String COLUMN_USERTYPE = "usertype";
    public final static String COLUMN_SECRETQUESTION = "secretquestion";
    public final static String COLUMN_SECRETANSWER = "secretanswer";
    
    private int id;
    private String firstName;
    private String middleName;
    private String lastName;
    private String email;
    private String password;
    private String userNumber;
    private String userType;
    private String secretQuestion;
    private String secretAnswer;
    
    
    
    public User(){
    }
    

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}
	
	public void setNewId(){
		Random r = new Random();
    	int first = r.nextInt(899999)+100000;
    	int last = 0;
    	

    	String id = ""+ first;
    	
    	for(int i = 0; i<6;i++){
    		last+=first%10;
    		first/=10;
    	}
    	 
    	id+=last;
    	
    	this.id = Integer.parseInt(id); 
	}


	public String getFirstName() {
		return firstName;
	}


	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}


	public String getMiddleName() {
		return middleName;
	}


	public void setMiddleName(String middleName) {
		this.middleName = middleName;
	}


	public String getLastName() {
		return lastName;
	}


	public void setLastName(String lastName) {
		this.lastName = lastName;
	}


	public String getEmail() {
		return email;
	}


	public void setEmail(String email) {
		this.email = email;
	}


	public String getPassword() {
		return password;
	}


	public void setPassword(String password) {
		this.password = password;
	}


	public String getUserNumber() {
		return userNumber;
	}


	public void setUserNumber(String userNumber) {
		this.userNumber = userNumber;
	}


	public String getUserType() {
		return userType;
	}


	public void setUserType(String userType) {
		this.userType = userType;
	}


	public String getSecretQuestion() {
		return secretQuestion;
	}


	public void setSecretQuestion(String secretQuestion) {
		this.secretQuestion = secretQuestion;
	}


	public String getSecretAnswer() {
		return secretAnswer;
	}


	public void setSecretAnswer(String secretAnswer) {
		this.secretAnswer = secretAnswer;
	}

	

	
	
    //Pls just generate all the other stuff :c//
}