package com.beans;

import java.io.Serializable;
import java.sql.Date;
import java.util.ArrayList;

//import com.mysql.fabric.xmlrpc.base.Array;

public class TemporaryPassword implements Serializable {
    
    public final static String TABLE_NAME = " temporarypassword ";
    public final static String COLUMN_ID = " idtemporarypasswords ";
    public final static String COLUMN_IDUSER = " iduser ";
    public final static String COLUMN_TEMPPASS = " temppassword ";
    public final static String COLUMN_EXPDATE = " expiredate ";
    
    private int id;
    private int idUser;
    private String tempPassword;
    private Date expDate;


    public TemporaryPassword(){
    }
    
//    public TemporaryPassword(int id, int idUser,String tempPassword,Date expDate) {
//    	this.id = id;
//        this.idUser = idUser;
//        this.tempPassword = tempPassword;
//        this.expDate = expDate;
//
//    }

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getIduser() {
		return idUser;
	}

	public void setIduser(int iduser) {
		this.idUser = iduser;
	}

	public int getIdUser() {
		return idUser;
	}

	public void setIdUser(int idUser) {
		this.idUser = idUser;
	}

	public String getTempPassword() {
		return tempPassword;
	}

	public void setTempPassword(String tempPassword) {
		this.tempPassword = tempPassword;
	}

	

	
    //Pls just generate all the other stuff :c//
}