package com.services;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.DB.DBPool;
import com.beans.Log;
import com.beans.MeetingRoomBooking;

public class LogsService {
	public static boolean insertLog(Log l){
		boolean b = false;
		String sql = "INSERT INTO " + Log.TABLENAME + " ( "
	             + Log.COLUMN_USERID +", "
	             + Log.COLUMN_PAGENAME + ", " 
	             + Log.COLUMN_REQUEST
	             + ") VALUES (?,?,?)";
		 Connection connection = DBPool.getInstance().getConnection();
         PreparedStatement pstmt = null;
         Boolean out=false;

         try {
             pstmt = connection.prepareStatement(sql);
             
             pstmt.setInt(1, l.getUserid());
             pstmt.setString(2, l.getPagename());
             pstmt.setString(3, l.getRequest());
             
             pstmt.executeUpdate();
             b=true;
         } catch (SQLException e) {
             e.printStackTrace();
         } finally {
             try {
                 pstmt.close();
                 connection.close();
             } catch(SQLException e) {
                 e.printStackTrace();
             }
         }

         return b;		
		
		
	}
	public static ArrayList<Log> getUserLogs(int userID){
		ArrayList<Log> logs = new ArrayList();
		String sql = "SELECT * FROM "+ Log.TABLENAME+" where "+Log.COLUMN_USERID+" = ?;";
		
		Connection connection = DBPool.getInstance().getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			pstmt = connection.prepareStatement(sql);
			
			pstmt.setInt(1, userID);
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				Log l = new Log();
					
				l.setLogid(rs.getInt(Log.COLUMN_IDLOGS));
				l.setUserid(rs.getInt(Log.COLUMN_USERID));
				l.setDate(rs.getString(Log.COLUMN_DATE));
				l.setPagename(rs.getString(Log.COLUMN_PAGENAME));
				l.setRequest(rs.getString(Log.COLUMN_REQUEST));
				
				logs.add(l);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally{
			try {
				rs.close();
				pstmt.close();
				connection.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
		return logs;
		
		
		
	}

	public static ArrayList<Log> getLogs(){
		ArrayList<Log> logs = new ArrayList();
		String sql = "SELECT * FROM "+ Log.TABLENAME+";";
		
		Connection connection = DBPool.getInstance().getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			pstmt = connection.prepareStatement(sql);
			;
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				Log l = new Log();
					
				l.setLogid(rs.getInt(Log.COLUMN_IDLOGS));
				l.setUserid(rs.getInt(Log.COLUMN_USERID));
				l.setDate(rs.getString(Log.COLUMN_DATE));
				l.setPagename(rs.getString(Log.COLUMN_PAGENAME));
				l.setRequest(rs.getString(Log.COLUMN_REQUEST));
				
				logs.add(l);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally{
			try {
				rs.close();
				pstmt.close();
				connection.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
		return logs;
		
		
		
	}
	
	public static void logAction(String pagename, String request, int userid){
		insertLog(new Log(pagename,request,userid));
	}

}
