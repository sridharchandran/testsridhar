package com.onwardpath.wem.controller;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.util.Optional;
import java.util.zip.DataFormatException;
import java.util.zip.Inflater;

import javax.servlet.http.HttpSession;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
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
	public String login() {
		
		return "login";
	}
	
	
	@GetMapping("/DisplayImageController/{id}")
	public ResponseEntity<byte[]>  DisplayImage(@PathVariable("id") int id) throws IOException {
		
		User image  = userRepo.findById(id);
		
		return ResponseEntity.ok().contentType(MediaType.IMAGE_JPEG).body(image.getProfile_pic());
	}
	
	
	

	@RequestMapping (value = "/login", method = RequestMethod.POST)
    
    public  String loginsave(@ModelAttribute("user") User user, HttpSession session) {
		 
		
    	System.out.println("response email==="+user.toString());
    	System.out.println("user emajl=="+user.getUserName());
    	User user1 = userRepo.findByEmail(user.getUserName()) ;
    	
    	System.out.println("result=="+user);
    	if(user != null)
    	{
    		session.setAttribute("authenticated", "true");
    		session.setAttribute("org_name", user1.getOrg_id());
    		session.setAttribute("firstname", user1.getFirstname());
    		session.setAttribute("lastname", user1.getLastname());
    		session.setAttribute("profile_pic", user1.getProfile_pic());
    		session.setAttribute("userid", user1.getId());
    		System.out.println("organization id=="+user1.getOrg_id());
    		System.out.println("firstname=="+user1.getFirstname());
    	}
    	
		/* return userRepo.findById(88); */
    	return "index";
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
	
	@PostMapping("/logout")
	public String logouts(HttpSession session) {
		System.out.println("User logged out");
		if (session != null) {
			session.invalidate();
		}
		return "login";
	}
	
	@GetMapping("/logout")
	public String logout(HttpSession session) {
		System.out.println("User logged out");
		if (session != null) {
			session.invalidate();
		}
		return "login";
	}
}
