package com.services;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.encrypt.Encryptors;

public class EncryptionService {

	public static String pepper="iThoughtItWasSalt";
	public static int strength=13;
	
	public static String encryptPass(String password){
		BCryptPasswordEncoder encoder = new BCryptPasswordEncoder(strength);
		return encoder.encode(password+pepper);
	}
	
	public static boolean matchPass(String raw,String encoded){

		BCryptPasswordEncoder encoder = new BCryptPasswordEncoder(strength);
		return(encoder.matches(raw+pepper, encoded));
	}
	
}
