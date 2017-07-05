package com.services;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.DB.DBPool;
import com.beans.Book;
import com.beans.MeetingRoomBooking;
import com.beans.User;

public class MeetingRoomService {
	 public static boolean addMeetingRoomBooking(MeetingRoomBooking mrb) {
         String sql = "INSERT INTO " + MeetingRoomBooking.TABLE_NAME + " ( "
             + MeetingRoomBooking.COLUMN_ID + ", "
             + MeetingRoomBooking.COLUMN_IDUSER +", "
             + MeetingRoomBooking.COLUMN_TIMESTART + ", "
             + MeetingRoomBooking.COLUMN_TIMEEND +") "
             + "VALUES (?,?,?,?)";

      //   String url = "jdbc:mysql://localhost:3306/userID";

         Connection connection = DBPool.getInstance().getConnection();
         PreparedStatement pstmt = null;
         Boolean out=false;

         try {
             pstmt = connection.prepareStatement(sql);
             
             
             pstmt.setInt(1, mrb.getId());
             pstmt.setInt(2,mrb.getIduser());
             pstmt.setDate(3, mrb.getTimeStart());
             pstmt.setDate(4, mrb.getTimeEnd());
             
             pstmt.executeUpdate();
             out=true;
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

         return out;
	 }
	 public static ArrayList<MeetingRoomBooking> getMeetingRoomBookings(){
		 ArrayList<MeetingRoomBooking> meetingroombookings= new ArrayList();
			String sql = "SELECT * FROM "+ MeetingRoomBooking.TABLE_NAME+";";
			
			Connection connection = DBPool.getInstance().getConnection();
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			
			try {
				pstmt = connection.prepareStatement(sql);
				rs = pstmt.executeQuery();
				
				while(rs.next()){
					MeetingRoomBooking mrb = new MeetingRoomBooking();
						
					mrb.setId(rs.getInt(MeetingRoomBooking.COLUMN_ID));
					mrb.setIduser(rs.getInt(MeetingRoomBooking.COLUMN_IDUSER));
					mrb.setTimeEnd(rs.getDate(MeetingRoomBooking.COLUMN_TIMEEND));

					mrb.setTimeStart(rs.getDate(MeetingRoomBooking.COLUMN_TIMESTART));
					meetingroombookings.add(mrb);
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
			
			
			
			return meetingroombookings;
	 }
}
