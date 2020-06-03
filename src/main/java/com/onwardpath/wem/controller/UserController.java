package com.onwardpath.wem.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class UserController {

	
	@GetMapping("/signup")
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
