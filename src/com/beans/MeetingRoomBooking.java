package com.beans;

import java.io.Serializable;
import java.sql.Date;
import java.util.ArrayList;

//import com.mysql.fabric.xmlrpc.base.Array;

public class MeetingRoomBooking implements Serializable {
    
    public final static String TABLE_NAME = "meetingroombooking";
    public final static String COLUMN_ID = "idmeetingroombooking";
    public final static String COLUMN_IDUSER = "iduser";
    public final static String COLUMN_IDMEETINGROOM = "idmeetingroom";
    public final static String COLUMN_TIMESTART = "timestart";
    public final static String COLUMN_TIMEEND = "timeend";
    public final static String COLUMN_DATE = "date";
    
    private int id;
    private int idUser;
    private int idMeetingRoom;
    private int timeStart;
    private int timeEnd;
    private Date date;
    
    public MeetingRoomBooking(int id, int idUser, int idMeetingRoom, int timeStart, int timeEnd, Date date) {
    	this.id = id;
        this.idUser = idUser;
        this.idMeetingRoom = idMeetingRoom;
        this.timeStart = timeStart;
        this.timeEnd = timeEnd;
        this.date = date;
    }

	public MeetingRoomBooking() {
		// TODO Auto-generated constructor stub
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

	public int getTimeStart() {
		return timeStart;
	}

	public void setTimeStart(int timeStart) {
		this.timeStart = timeStart;
	}

	public int getTimeEnd() {
		return timeEnd;
	}

	public void setTimeEnd(int timeEnd) {
		this.timeEnd = timeEnd;
	}

	public int getIdUser() {
		return idUser;
	}

	public void setIdUser(int idUser) {
		this.idUser = idUser;
	}

	public int getIdMeetingRoom() {
		return idMeetingRoom;
	}

	public void setIdMeetingRoom(int idMeetingRoom) {
		this.idMeetingRoom = idMeetingRoom;
	}

	public Date getDate() {
		return date;
	}

	public void setDate(Date date) {
		this.date = date;
	}
	
    //Pls just generate all the other stuff :c//
}