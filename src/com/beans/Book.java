package com.beans;

import java.io.Serializable;
import java.util.ArrayList;

//import com.mysql.fabric.xmlrpc.base.Array;


public class Book implements Serializable {
    

    public final static String TABLE_NAME = "books";
    public final static String COLUMN_ID = "idbooks";
    public final static String COLUMN_BOOKNAME = "bookname";
    public final static String COLUMN_AUTHOR = "author";
    public final static String COLUMN_PUBLISHER = "publisher";
    public final static String COLUMN_YEAR = "year";
    public final static String COLUMN_STATUS = "status";
    public final static String COLUMN_DESCRIPTION = "description";
    public final static String COLUMN_TYPE = "type";
    public final static String COLUMN_DEWEY = "deweydecimal";
    
    
    private int id;
    private String dds;
    private String name;
    private String author;
    private String publisher;
    private String year;
    private String description;
    private String status;
    private String type; 
    
    public Book(int id, String dds, String name, String author, String publisher, String year, String description, String status,
			String type) {
	
		this.id = id;
		this.dds = dds;
		this.name = name;
		this.author = author;
		this.publisher = publisher;
		this.year = year;
		this.description = description;
		this.status = status;
		this.type = type;
	}

	public Book(){
    	
    }
    
	public String getDds() {
		return dds;
	}

	public void setDds(String dds) {
		this.dds = dds;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getAuthor() {
		return author;
	}

	public void setAuthor(String author) {
		this.author = author;
	}

	public String getPublisher() {
		return publisher;
	}

	public void setPublisher(String publisher) {
		this.publisher = publisher;
	}

	public String getYear() {
		return year;
	}

	public void setYear(String year) {
		this.year = year;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	
    //Pls just generate all the other stuff :c//
}