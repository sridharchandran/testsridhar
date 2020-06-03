package com.onwardpath.wem.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

@Controller
public class UserController {

	
	@PostMapping("/signup")
	public String signup() {
		
		return "";
	}
	
	
	@GetMapping("/login")
	public String login() {
		
		return "";
	}
	
	
	@GetMapping("/logout")
	public String logout() {
		
		return "";
	}
}
