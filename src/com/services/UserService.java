package com.services;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.beans.Book;
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
    	String sql = "SELECT "+User.COLUMN_ID+" , "+ User.COLUMN_USERTYPE+", "+User.COLUMN_PASSWORD+" FROM " + User.TABLE_NAME + " WHERE " + User.COLUMN_EMAIL + "= ?";
    	
    	Connection conn = DBPool.getInstance().getConnection();
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        ArrayList<String> returnVal = new ArrayList<>();
        
        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, u.getEmail());
            
            rs = pstmt.executeQuery();
            
            if(rs.next()) {
            	EncryptionService encoder = new EncryptionService();
            	if(encoder.matchPass(u.getPassword(), rs.getString(3))){
	                returnVal.add(rs.getString(1));
	                returnVal.add(rs.getString(2));
            	}
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
    
    public static ArrayList<String> loginUserSecret(User u) {
    	String sql = "SELECT "+User.COLUMN_ID+" , "+ User.COLUMN_USERTYPE+", "+User.COLUMN_SECRETANSWER+" FROM " + User.TABLE_NAME + " WHERE " + User.COLUMN_EMAIL + "= ?";
    	
    	Connection conn = DBPool.getInstance().getConnection();
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        ArrayList<String> returnVal = new ArrayList<>();
        
        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, u.getEmail());
            
            rs = pstmt.executeQuery();
            
            if(rs.next()) {
            	EncryptionService encoder = new EncryptionService();
            	if(encoder.matchPass(u.getSecretAnswer(), rs.getString(3))){
	                returnVal.add(rs.getString(1));
	                returnVal.add(rs.getString(2));
            	}
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
    
    public static ArrayList<User> getAllAdmins(){
    	
    	ArrayList<User> admins = new ArrayList();
		String sql = "SELECT * FROM "+ User.TABLE_NAME+" where "+ User.COLUMN_USERTYPE +" <> 0 ;";
		
		Connection connection = DBPool.getInstance().getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			pstmt = connection.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				User admin = new User();
				
				admin.setId(rs.getInt(User.COLUMN_ID));
				admin.setEmail(rs.getString(User.COLUMN_EMAIL));
				admin.setFirstName(rs.getString(User.COLUMN_FIRSTNAME));
				admin.setMiddleName(rs.getString(User.COLUMN_MIDDLENAME));
				admin.setLastName(rs.getString(User.COLUMN_LASTNAME));
				admin.setUserNumber(rs.getString(User.COLUMN_USERNUMBER));
				admin.setUserType(rs.getString(User.COLUMN_USERTYPE));
				admins.add(admin);
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
		
		return admins;
    }
    
    public static User getUser(int userID){
		String sql = "SELECT * FROM "+ User.TABLE_NAME+" where "+ User.COLUMN_ID +" = ? ;";
		
		User user = new User();
		Connection connection = DBPool.getInstance().getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			pstmt = connection.prepareStatement(sql);
			pstmt.setInt(1, userID);
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				user.setId(rs.getInt(User.COLUMN_ID));
				user.setEmail(rs.getString(User.COLUMN_EMAIL));
				user.setFirstName(rs.getString(User.COLUMN_FIRSTNAME));
				user.setMiddleName(rs.getString(User.COLUMN_MIDDLENAME));
				user.setLastName(rs.getString(User.COLUMN_LASTNAME));
				user.setUserNumber(rs.getString(User.COLUMN_USERNUMBER));
				user.setUserType(rs.getString(User.COLUMN_USERTYPE));
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
		
		return user;
    }
    
    public static User whoseUserNumber(int userNumber){
		String sql = "SELECT * FROM "+ User.TABLE_NAME+" where "+ User.COLUMN_USERNUMBER +" = ? ;";
		
		User user = new User();
		Connection connection = DBPool.getInstance().getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			pstmt = connection.prepareStatement(sql);
			pstmt.setInt(1, userNumber);
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				user.setId(rs.getInt(User.COLUMN_ID));
				user.setEmail(rs.getString(User.COLUMN_EMAIL));
				user.setFirstName(rs.getString(User.COLUMN_FIRSTNAME));
				user.setMiddleName(rs.getString(User.COLUMN_MIDDLENAME));
				user.setLastName(rs.getString(User.COLUMN_LASTNAME));
				user.setUserNumber(rs.getString(User.COLUMN_USERNUMBER));
				user.setUserType(rs.getString(User.COLUMN_USERTYPE));
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
		
		return user;
    }
    
    public static User whoseEmail(String email){
		String sql = "SELECT * FROM "+ User.TABLE_NAME+" where "+ User.COLUMN_EMAIL +" = ? ;";
		
		User user = new User();
		Connection connection = DBPool.getInstance().getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			pstmt = connection.prepareStatement(sql);
			pstmt.setString(1, email);
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				user.setId(rs.getInt(User.COLUMN_ID));
				user.setEmail(rs.getString(User.COLUMN_EMAIL));
				user.setFirstName(rs.getString(User.COLUMN_FIRSTNAME));
				user.setMiddleName(rs.getString(User.COLUMN_MIDDLENAME));
				user.setLastName(rs.getString(User.COLUMN_LASTNAME));
				user.setUserNumber(rs.getString(User.COLUMN_USERNUMBER));
				user.setUserType(rs.getString(User.COLUMN_USERTYPE));
				user.setSecretQuestion(rs.getString(User.COLUMN_SECRETQUESTION));
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
		
		return user;
    }
    
    public static boolean passwordChange(String newPass, int userID){
		String sql = "UPDATE " + User.TABLE_NAME + " SET " + User.COLUMN_PASSWORD + " = ? WHERE " + User.COLUMN_ID + "= ?";
		
		User user = new User();
		Connection connection = DBPool.getInstance().getConnection();
		PreparedStatement pstmt = null;
		boolean success = false;
		
		try {
			pstmt = connection.prepareStatement(sql);
			pstmt.setString(1, newPass);
			pstmt.setInt(2, userID);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally{
			try {
				success = true;
				pstmt.close();
				connection.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
		return success;
    }
    
    public static boolean questionChange(String newQuestion, int userID){
		String sql = "UPDATE " + User.TABLE_NAME + " SET " + User.COLUMN_SECRETQUESTION + " = ? WHERE " + User.COLUMN_ID + "= ?";
		
		User user = new User();
		Connection connection = DBPool.getInstance().getConnection();
		PreparedStatement pstmt = null;
		boolean success = false;
		
		try {
			pstmt = connection.prepareStatement(sql);
			pstmt.setString(1, newQuestion);
			pstmt.setInt(2, userID);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally{
			try {
				success = true;
				pstmt.close();
				connection.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
		return success;
    }
    
    public static boolean answerChange(String newAnswer, int userID){
		String sql = "UPDATE " + User.TABLE_NAME + " SET " + User.COLUMN_SECRETANSWER + " = ? WHERE " + User.COLUMN_ID + "= ?";
		
		User user = new User();
		Connection connection = DBPool.getInstance().getConnection();
		PreparedStatement pstmt = null;
		boolean success = false;
		
		try {
			pstmt = connection.prepareStatement(sql);
			pstmt.setString(1, newAnswer);
			pstmt.setInt(2, userID);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally{
			try {
				success = true;
				pstmt.close();
				connection.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
		return success;
    }
    
    public static boolean editEmployee(User employee){
		String sql = "UPDATE " + User.TABLE_NAME + " SET " + User.COLUMN_FIRSTNAME + "=?, " + User.COLUMN_MIDDLENAME + "=?, " + User.COLUMN_LASTNAME + "=?, " + 
					User.COLUMN_EMAIL + "=?, " + User.COLUMN_USERTYPE + "=? WHERE " + User.COLUMN_ID + "= ?";
		
		Connection connection = DBPool.getInstance().getConnection();
		PreparedStatement pstmt = null;
		boolean success = false;
		
		try {
			pstmt = connection.prepareStatement(sql);
			pstmt.setString(1, employee.getFirstName());
			pstmt.setString(2, employee.getMiddleName());
			pstmt.setString(3, employee.getLastName());
			pstmt.setString(4, employee.getEmail());
			pstmt.setString(5, employee.getUserType());
			pstmt.setInt(6, employee.getId());
			
			pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally{
			try {
				success = true;
				pstmt.close();
				connection.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
		return success;
    }
    
    public static boolean deleteEmployee(int userID){
		String sql = "DELETE FROM " + User.TABLE_NAME + " WHERE " + User.COLUMN_ID + "=? ";
		
		Connection connection = DBPool.getInstance().getConnection();
		PreparedStatement pstmt = null;
		boolean success = false;
		
		try {
			pstmt = connection.prepareStatement(sql);
			pstmt.setInt(1, userID);
			
			pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally{
			try {
				success = true;
				pstmt.close();
				connection.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
		return success;
    }
}