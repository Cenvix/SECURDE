package com.beans;

import java.io.Serializable;
import java.sql.Date;
import java.util.ArrayList;

//import com.mysql.fabric.xmlrpc.base.Array;

public class MeetingRoomBooking implements Serializable {
    
    public final static String TABLE_NAME = " meetingroombooking ";
    public final static String COLUMN_ID = " idmeetingroombooking ";
    public final static String COLUMN_IDUSER = " iduser ";
    public final static String COLUMN_TIMESTART = " timestart ";
    public final static String COLUMN_TIMEEND = " timeend ";
    
    private int id;
    private int idUser;
    private Date timeStart;
    private Date timeEnd;
    
    public MeetingRoomBooking(int id, int idUser, Date timeStart, Date timeEnd) {
    	this.id = id;
        this.idUser = idUser;
        this.timeStart = timeStart;
        this.timeEnd = timeEnd;
    }

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

	public Date getTimeStart() {
		return timeStart;
	}

	public void setTimeStart(Date timeStart) {
		this.timeStart = timeStart;
	}

	public Date getTimeEnd() {
		return timeEnd;
	}

	public void setTimeEnd(Date timeEnd) {
		this.timeEnd = timeEnd;
	}

	

	
    //Pls just generate all the other stuff :c//
}