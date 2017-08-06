package com.services;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.encrypt.Encryptors;

public class EncryptionService {

	public static void main(String[] args) {
		encryptPass("wow");
	}
	public static void encryptPass(String password){

		BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
		System.out.println("Raw = " + password);
		String encoded = encoder.encode(password);
		System.out.println("Encoded = " + encoded);
		System.out.println(encoder.matches(password, encoded));
		
		
	}
}
