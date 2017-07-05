package com.beans;

import java.io.Serializable;
import java.sql.Date;
import java.util.ArrayList;

//import com.mysql.fabric.xmlrpc.base.Array;

public class Transaction implements Serializable {
    
    public final static String TABLE_NAME = " transactions ";
    public final static String COLUMN_ID = " idtransactions ";
    public final static String COLUMN_IDBOOK = " idbook ";
    public final static String COLUMN_IDUSER = " iduser ";
    public final static String COLUMN_BORROWDATE = " borrowdate ";
    public final static String COLUMN_RETURNDATE = " returndate ";
    public final static String COLUMN_STATUS = " status ";
    
    private int id;
    private int idBook;
    private int idUser;
    private Date borrowDate;
    private Date returnDate;
    private String status;
    
    public Transaction(int id, int idBook, int idUser, Date borrowDate, Date returnDate, String status) {
    	this.id = id;
    	this.idBook = idBook;
    	this.idUser = idUser;
    	this.borrowDate = borrowDate;
    	this.returnDate = returnDate;
        this.status = status;
    }

	public Transaction() {
		// TODO Auto-generated constructor stub
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	

	public int getIdBook() {
		return idBook;
	}

	public void setIdBook(int idBook) {
		this.idBook = idBook;
	}

	public int getIdUser() {
		return idUser;
	}

	public void setIdUser(int idUser) {
		this.idUser = idUser;
	}

	public Date getBorrowDate() {
		return borrowDate;
	}

	public void setBorrowDate(Date borrowDate) {
		this.borrowDate = borrowDate;
	}

	public Date getReturnDate() {
		return returnDate;
	}

	public void setReturnDate(Date returnDate) {
		this.returnDate = returnDate;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	
    //Pls just generate all the other stuff :c//
}