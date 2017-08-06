package com.services;

public class AuthorityCheckerService {
	
	public static boolean isAdmin(int type) {
		return type==3;
	}

	public static boolean isManager(int type) {
		return type==2;
	}
	
	public static boolean isStaff(int type) {
		return type==1;
	}
	
	public static boolean isStudent(int type) {
		return type==0;
	}
}
