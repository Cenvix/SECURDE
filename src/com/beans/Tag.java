package com.beans;

import java.io.Serializable;


//import com.mysql.fabric.xmlrpc.base.Array;

public class Tag implements Serializable {
    
    public final static String TABLE_NAME = " tags ";
    public final static String COLUMN_ID = " idtags ";
    public final static String COLUMN_IDBOOK = " idbooks ";
    public final static String COLUMN_TAG = " tag ";
    
    private int id;
    private int idBook;
    private String tag;


    
    public Tag(int id, int idBook,String tag) {
    	this.id = id;
    	this.idBook = idBook;
    	this.tag = tag;

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

	public String getTag() {
		return tag;
	}

	public void setTag(String tag) {
		this.tag = tag;
	}

	
}