package com.services;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.DB.DBPool;
import com.beans.Transaction;

public class TransactionService {
	public static ArrayList<Transaction> getUserTransactions(int userID){
		ArrayList<Transaction> transactions = new ArrayList();
		
		String sql = "Select * from "+Transaction.TABLE_NAME+" where "+Transaction.COLUMN_IDUSER+"=?;";
		Connection connection = DBPool.getInstance().getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			pstmt = connection.prepareStatement(sql);
			pstmt.setInt(1, userID);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				Transaction t = new Transaction();
				
				t.setId(rs.getInt(Transaction.COLUMN_ID));
				t.setIdBook(rs.getInt(Transaction.COLUMN_IDBOOK));
				t.setIdUser(rs.getInt(Transaction.COLUMN_IDUSER));
				t.setStatus(rs.getString(Transaction.COLUMN_STATUS));
				t.setBorrowDate(rs.getDate(Transaction.COLUMN_BORROWDATE));
				t.setReturnDate(rs.getDate(Transaction.COLUMN_RETURNDATE));
				
				transactions.add(t);
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
		
		
		return transactions;
		
		
	}
	public static boolean addTransaction(Transaction t){
		boolean success = false;
		String sql = "Insert into "+Transaction.TABLE_NAME + " Values(?,?,?,CURDATE(),DATE_ADD(CURDATE(), INTERVAL 10 DAY),?);";
		Connection connection = DBPool.getInstance().getConnection();
		PreparedStatement pstmt = null;

		try {
			pstmt = connection.prepareStatement(sql);
			pstmt.setInt(1, t.getId());
			pstmt.setInt(2, t.getIdBook());
			pstmt.setInt(3, t.getIdUser());
			pstmt.setString(4, t.getStatus());
			
			pstmt.executeUpdate();
			success=true;
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
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
