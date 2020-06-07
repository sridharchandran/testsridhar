package com.onwardpath.wem.controller;

import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.onwardpath.wem.entity.User;
import com.onwardpath.wem.repository.UserRepository;
import com.onwardpath.wem.service.UserService;

@Controller
public class UserController {
	
	 @Autowired
	 private UserService userService;
	 
	 @Autowired
	 UserRepository userRepo;
	
	@GetMapping("/signup")
	public String signup() {
		return "signup";
	}
	
	@GetMapping("/login")
	public String login(Model model) {
		///model.addAttribute("user", new User()); 
		return "login";
	}
	
    @RequestMapping(value = "/login", method = RequestMethod.POST)
    @ResponseBody
    public Optional<User> authenticateUser(User user) {
 
    	System.out.println("response email"+user.getUserName());
		/* return userRepo.findById(88); */
    	return Optional.of(userRepo.findByEmail(user.getUserName()));
    }
    
	@GetMapping("/byid")
	@ResponseBody
    public Optional<User> byID(@ModelAttribute("user") User user) {
		 
    	return Optional.ofNullable(userRepo.findByEmail("errorpages@gmail.com"));
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
