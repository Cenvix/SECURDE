package com.services;

import java.util.Random;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

public class EncryptionService {

	private static String pepper="A1!C2@E3#G4$I5%K6^M7&O8*Q9(S0)U";
	private static String salt="N0+_s0_r@nd0M";

	public String encryptPass(String password){
		BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
		Random rng = new Random();
		
		return encoder.encode(salt+password+pepper.charAt(rng.nextInt(pepper.length())));
	}
	
	public boolean matchPass(String raw,String encoded){

		BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
		for(int i=0; i<pepper.length();i++)
		if(encoder.matches(salt+raw+pepper.charAt(i), encoded))return true;
		
		return false;
	}
	
}
