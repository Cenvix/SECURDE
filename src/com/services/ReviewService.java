package com.services;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.DB.DBPool;
import com.beans.Book;
import com.beans.Review;

public class ReviewService {
	public static ArrayList<Review> getBookReviews(int bookid){
		ArrayList<Review> reviews = new ArrayList();
		
		String sql = "Select * from "+ Review.TABLE_NAME+ " where "+Review.COLUMN_BOOKID+"=?;";
		
		Connection connection = DBPool.getInstance().getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			pstmt = connection.prepareStatement(sql);
			pstmt.setInt(1, bookid);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				Review r = new Review();
				r.setBookID(rs.getInt(Review.COLUMN_BOOKID));
				r.setReviewID(rs.getInt(Review.COLUMN_ID));
				r.setUserID(rs.getInt(Review.COLUMN_USERID));
				r.setRating(rs.getInt(Review.COLUMN_RATING));
				r.setReview(rs.getString(Review.COLUMN_REVIEW));
				reviews.add(r);
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
				
		return reviews;
		
	}
	
	public static boolean addReview(Review r){
		boolean success = false;
		
		String sql = "insert into "+Review.TABLE_NAME+" values(?,?,?,?,?)";

        Connection connection = DBPool.getInstance().getConnection();
        PreparedStatement pstmt = null;
        Boolean out=false;

        
        
        try {
            pstmt = connection.prepareStatement(sql);
            
            pstmt.setInt(1, r.getReviewID());
            pstmt.setInt(2, r.getBookID());
            pstmt.setInt(3, r.getUserID());
            pstmt.setInt(4, r.getRating());
            pstmt.setString(5, r.getReview());
            pstmt.executeUpdate();
            success=true;
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

        return success;
		
	
		
	}
}
