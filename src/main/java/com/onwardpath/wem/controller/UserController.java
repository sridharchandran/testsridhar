package com.onwardpath.wem.controller;

import java.io.IOException;
import java.util.Optional;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
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
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;

import com.onwardpath.wem.entity.Organization;
import com.onwardpath.wem.entity.Role;
import com.onwardpath.wem.entity.User;
import com.onwardpath.wem.model.SignupFormDTO;
import com.onwardpath.wem.repository.OrgRepository;
import com.onwardpath.wem.repository.RoleRepository;
import com.onwardpath.wem.repository.UserRepository;
import com.onwardpath.wem.service.UserService;

@Controller
/* @SessionAttributes("user") */
public class UserController {

	@Autowired
	UserRepository userRepo;

	@Autowired
	OrgRepository orgRepo;

	@Autowired
	UserControllerImpl userControllerImpl;

	HttpSession session;

	/*
	 * @ModelAttribute("user") public User userDetails() { User user = new User();
	 * Authentication auth = SecurityContextHolder.getContext().getAuthentication();
	 * 
	 * if(auth.getName().contains("anonymous")) user = new User(); else user =
	 * userRepo.findByUserName(auth.getName());
	 * 
	 * user = auth.getName().contains("anonymous") ? new User() :
	 * userRepo.findByUserName(auth.getName()); return user; }
	 */

	@GetMapping("/home")
	public String homePage() {
		return "index";
	}

	@GetMapping("/login")
	public String login(Model model) {
		// model.addAttribute("user", new User());
		return "login";
	}

	@GetMapping("/loginSuccess")
	public String loginSuccess(HttpSession session) {
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		System.out.println("Authenticated User Name" + auth.getName());
		User user = userRepo.findByUserName(auth.getName());
		Organization org = orgRepo.findById(user.getOrg_id());
		System.out.println("Authenticated User ID" + user.getId());
		session.setAttribute("authenticated", "true");
		session.setAttribute("user", user);
		session.setAttribute("org", org);
		session.setAttribute("user_id", user.getId());
		session.setAttribute("org_id", user.getOrg_id());
		session.setAttribute("site_id", null);
		return "redirect:/home";
	}

//    @RequestMapping(value = "/login", method = RequestMethod.POST)
//    @ResponseBody
//    public Optional<User> authenticateUser(User user) {
// 
//    	System.out.println("response email"+user.getUserName());
//		/* return userRepo.findById(88); */ 
//    	return Optional.of(userRepo.findByEmail(user.getUserName()));
//    }

	@GetMapping("/byid")
	@ResponseBody
	public Optional<Organization> byID(@ModelAttribute("user") User user) {

		return Optional.ofNullable(orgRepo.findByDomain("http://www.springboot.com"));

	}

	// Endpoint for SignUp Page
	@RequestMapping(value = "/registration", method = RequestMethod.GET)
	public String userRegistrationPage() {
		return "signup";
	}

	// Signup Page Submit Call
	@RequestMapping(value = "/registration", method = RequestMethod.POST)
	public ModelAndView registerUser(SignupFormDTO signupFormDTO, HttpSession session) throws IOException {
		ModelAndView modelAndView = userControllerImpl.registerUser(signupFormDTO, session);
		return modelAndView;
	}

}
