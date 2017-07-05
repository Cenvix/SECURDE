package com.services;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.beans.User;
import com.DB.DBPool;

public class UserService {
    
    public static boolean addUser(User u) {
            String sql = "INSERT INTO " + User.TABLE_NAME + " ( "
                + User.COLUMN_ID + ", "
                + User.COLUMN_EMAIL +", "
                + User.COLUMN_PASSWORD + ", "
                + User.COLUMN_FIRSTNAME + ", "
                + User.COLUMN_MIDDLENAME + ", "
                + User.COLUMN_LASTNAME +", "
                + User.COLUMN_USERTYPE +", "
                + User.COLUMN_USERNUMBER +", "
                + User.COLUMN_SECRETQUESTION +", "
                + User.COLUMN_SECRETANSWER +") "
                + "VALUES (?,?,?,?,?,?,?,?,?,?)";

         //   String url = "jdbc:mysql://localhost:3306/userID";

            Connection connection = DBPool.getInstance().getConnection();
            PreparedStatement pstmt = null;
            Boolean out=false;

            try {
                pstmt = connection.prepareStatement(sql);
                pstmt.setInt(1, u.getId());
                pstmt.setString(2, u.getEmail());
                pstmt.setString(3, u.getPassword());
                pstmt.setString(4, u.getFirstName());
                pstmt.setString(5, u.getMiddleName());
                pstmt.setString(6, u.getLastName());
                pstmt.setString(7, u.getUserType());
                pstmt.setString(8, u.getUserNumber());
                pstmt.setString(9, u.getSecretQuestion());
                pstmt.setString(10, u.getSecretAnswer());
                
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
    
    public static ArrayList<String> loginUser(User u) {
    	String sql = "SELECT "+User.COLUMN_ID+" , "+ User.COLUMN_USERTYPE+" FROM " + User.TABLE_NAME + " WHERE " + User.COLUMN_EMAIL + "= ? AND " + User.COLUMN_PASSWORD + "= ?";
    	
    	Connection conn = DBPool.getInstance().getConnection();
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        ArrayList<String> returnVal = new ArrayList<>();
        
        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, u.getEmail());
            pstmt.setString(2, u.getPassword());
            
            rs = pstmt.executeQuery();
            
            if(rs.next()) {
                returnVal.add(rs.getString(1));
                returnVal.add(rs.getString(2));
            }
            
        } catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				pstmt.close();
				conn.close();
                rs.close();
			} catch(SQLException e) {
				e.printStackTrace();
			}
        }
        return returnVal;
    }
    
    public static boolean checkUser(User u) {
        String sql = "SELECT * FROM " + User.TABLE_NAME + " WHERE " + User.COLUMN_EMAIL + "= ?"+
        				" OR " + User.COLUMN_USERNUMBER +"= ?";
        
        Connection conn = DBPool.getInstance().getConnection();
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        Boolean returnVal = false;
        
        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, u.getEmail());
            pstmt.setString(2, u.getUserNumber());
            
            rs = pstmt.executeQuery();
            
            if(rs.next()) {
                returnVal = false;
            }
            else {
                returnVal = true;
            }
        } catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				pstmt.close();
				conn.close();
                rs.close();
			} catch(SQLException e) {
				e.printStackTrace();
			}
        }
        
        return returnVal;
    }
}