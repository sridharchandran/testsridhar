package com.onwardpath.wem.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

@Controller
public class UserController {
	
	@GetMapping("/signup")
	public String signup() {
		return "signup";
	}
	
	@GetMapping("/login")
	public String login() {
		
		return "login";
	}
	
    @RequestMapping(value = "/login", method = RequestMethod.POST)
    public String authenticateUser(@ModelAttribute("user") User user) {
 
        return "modelAndView";
    }

	
	@GetMapping("/authenticate")
	public String auth() {
		
		return "login";
	}
	
	@GetMapping("/logout")
	public String logout() {
		
		return "";
	}
}
