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

public class BookService {
	public static boolean addBook(Book b) {
        String sql = "INSERT INTO " + Book.TABLE_NAME + " ( "
            + Book.COLUMN_ID + ", "
            + Book.COLUMN_BOOKNAME +", "
            + Book.COLUMN_AUTHOR +", "
            + Book.COLUMN_PUBLISHER +", "
            + Book.COLUMN_YEAR +", "
            + Book.COLUMN_STATUS + ") "
            + "VALUES (?,?,?,?,?,?)";

     //   String url = "jdbc:mysql://localhost:3306/userID";

        Connection connection = DBPool.getInstance().getConnection();
        PreparedStatement pstmt = null;
        Boolean out=false;

        
        
        try {
            pstmt = connection.prepareStatement(sql);
            pstmt.setInt(1, b.getId());
            pstmt.setString(2, b.getName());
            pstmt.setString(3, b.getAuthor());
            pstmt.setString(4, b.getPublisher());
            pstmt.setString(5, b.getYear());
            pstmt.setString(6, b.getStatus());

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
	public static boolean editBookStatus(int bookId, String bookStatus){
		String sql = "UPDATE "+Book.TABLE_NAME + " "
				+"SET " + Book.COLUMN_STATUS + "=? "+
				"WHERE "+ Book.COLUMN_ID +"=?;";
		boolean out = false;
		Connection connection = DBPool.getInstance().getConnection();
        PreparedStatement pstmt = null;
        try {
            pstmt = connection.prepareStatement(sql);
            
            pstmt.setString(1, bookStatus);
            pstmt.setInt(2, bookId);

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
	public static boolean editBook(Book b){
		
		String sql = "update "+Book.TABLE_NAME + 
				" set "+Book.COLUMN_AUTHOR + "=?,"+
						Book.COLUMN_BOOKNAME+ "=?,"+
						Book.COLUMN_PUBLISHER+ "=?,"+
						Book.COLUMN_STATUS+ "=?,"+
						Book.COLUMN_YEAR+ "=?" +
				" where " + Book.COLUMN_ID +"=?;";
		
			Boolean out=false;
			Connection connection = DBPool.getInstance().getConnection();
	        PreparedStatement pstmt = null;

	        
	        
	        try {
	            pstmt = connection.prepareStatement(sql);
   
	            pstmt.setString(1, b.getAuthor());
	            pstmt.setString(2, b.getName());
	            pstmt.setString(3, b.getPublisher());
	            pstmt.setString(4, b.getStatus());
	            pstmt.setString(5, b.getYear());
	            pstmt.setInt(6, b.getId());

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
	public static ArrayList<Book> getAllBooks(){
		ArrayList<Book> books = new ArrayList();
		String sql = "SELECT * FROM "+ Book.TABLE_NAME+";";
		
		Connection connection = DBPool.getInstance().getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			pstmt = connection.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				Book b = new Book(rs.getInt(Book.COLUMN_ID), rs.getString(Book.COLUMN_BOOKNAME), 
						rs.getString(Book.COLUMN_AUTHOR), rs.getString(Book.COLUMN_PUBLISHER), 
						rs.getString(Book.COLUMN_YEAR), rs.getString(Book.COLUMN_STATUS));
				
				books.add(b);
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
		
		return books;
	}
	
	public static boolean reserveBook(String id) {
		String sql = "UPDATE "+Book.TABLE_NAME + " "
				+ "SET " + Book.COLUMN_STATUS + "='Reserved' "+
				"WHERE "+ Book.COLUMN_ID +"=?;";
		
		Boolean result = false;
		
		Connection connection = DBPool.getInstance().getConnection();
        PreparedStatement pstmt = null;
        try {
            pstmt = connection.prepareStatement(sql);
            
            pstmt.setString(1, id);

            pstmt.executeUpdate();
            
            result = true;
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
        
        return result;
	}
}
