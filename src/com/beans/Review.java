package com.beans;

public class Review {
	public final static String COLUMN_ID = "reviewid";
	public final static String COLUMN_USERID = "userid";
	public final static String COLUMN_BOOKID = "bookid";
	public final static String COLUMN_RATING = "rating";
	public final static String COLUMN_REVIEW = "review";

	public final static String TABLE_NAME = "reviews";
	
	private String review;
	private int reviewID, userID,bookID,rating;
	
	
	public Review(String review, int reviewID, int userID, int bookID, int rating) {
		
		this.review = review;
		this.reviewID = reviewID;
		this.userID = userID;
		this.bookID = bookID;
		this.rating = rating;
	}
	public Review() {
		// TODO Auto-generated constructor stub
	}
	public String getReview() {
		return review;
	}
	public void setReview(String review) {
		this.review = review;
	}
	public int getReviewID() {
		return reviewID;
	}
	public void setReviewID(int reviewID) {
		this.reviewID = reviewID;
	}
	public int getUserID() {
		return userID;
	}
	public void setUserID(int userID) {
		this.userID = userID;
	}
	public int getBookID() {
		return bookID;
	}
	public void setBookID(int bookID) {
		this.bookID = bookID;
	}
	public int getRating() {
		return rating;
	}
	public void setRating(int rating) {
		if(rating<1)
		this.rating = 1;
		else if(rating>5)
			this.rating = 5;
		else 
			this.rating = rating;
	}
	
	
}
