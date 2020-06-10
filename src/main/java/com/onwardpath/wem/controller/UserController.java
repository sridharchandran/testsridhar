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
public class UserController {
	
	@Autowired 
	private BCryptPasswordEncoder bCryptPasswordEncoder;
	 @Autowired
	 private UserService userService;
	 
	 @Autowired
	 UserRepository userRepo;
	 
	 @Autowired
	 OrgRepository orgRepo;
	 
	 @Autowired
	 UserControllerImpl userControllerImpl;

	 HttpSession session;
	 
	
	@GetMapping("/index")
	public String signup() {
		return "index";
	}
	
	@GetMapping("/login")
	public String login(Model model) {
		///model.addAttribute("user", new User()); 
		return "login";
	}
	
	@GetMapping("/loginSuccess")
	public String loginSuccess(HttpSession session) {
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		System.out.println("Authenticated User"+ auth.getName());
		User user = userRepo.findByUserName(auth.getName());
		Organization org = orgRepo.findById(user.getOrg_id());
		System.out.println("Authenticated User"+ user.getId());
		session.setAttribute("authenticated", "true");
		session.setAttribute("user",user);
		session.setAttribute("org",org);
		session.setAttribute("user_id", user.getId());
		session.setAttribute("org_id", user.getOrg_id());
		session.setAttribute("site_id", null);
		return "redirect:index";
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
    public Optional<Organization> byID(@ModelAttribute("user") User user) {
		 
    	return Optional.ofNullable(orgRepo.findByDomain("http://www.springboot.com"));
    	
    }

    @RequestMapping(value = "/registration", method = RequestMethod.GET)
     public String registerUserForm() {
        return "signup";
    }
    

    @RequestMapping(value = "/registration", method = RequestMethod.POST)
     public ModelAndView registration(SignupFormDTO signupFormDTO, HttpSession session) throws IOException {
    	ModelAndView modelAndView = userControllerImpl.registerUser(signupFormDTO, session);
    	return modelAndView;
    }
    
    
	/*
	 * @RequestMapping(value = "/registration", method = RequestMethod.POST)
	 * 
	 * @ResponseBody public String createNewUser(SignupFormDTO
	 * signupFormDTO,HttpSession session) throws IOException { User userExists =
	 * userService.findByEmail(signupFormDTO.getEmail()); Organization orgExists =
	 * userService.findOrgIDByDomain(signupFormDTO.getDomain()); String s = "";
	 * byte[] photo = signupFormDTO.getPhoto().getBytes();
	 * 
	 * User user = new User(); Organization org = new Organization();
	 * 
	 * if (userExists != null) { session.setAttribute("message", "Error. User " +
	 * signupFormDTO.getEmail() +
	 * " already exist. <a href='index.jsp'>Click here</a> to login"); } else
	 * if(orgExists != null) { System.out.println("Organization already exists");
	 * user.setAnalytics_id(1); user.setEmail(signupFormDTO.getEmail());
	 * user.setFirstname(signupFormDTO.getFirstName());
	 * user.setLastname(signupFormDTO.getLastName());
	 * user.setUserName(signupFormDTO.getEmail());
	 * user.setOrg_id(orgExists.getId());
	 * user.setPassword(bCryptPasswordEncoder.encode(signupFormDTO.getPassword()));
	 * user.setPhone1(signupFormDTO.getPhone()); user.setProfile_pic(photo);
	 * user.setRole_id(1); userRepo.save(user);
	 * 
	 * 
	 * }
	 * 
	 * else { s = signupFormDTO.toString();
	 * 
	 * org.setName(signupFormDTO.getOrgName());
	 * org.setDomain(signupFormDTO.getDomain()); org.setLogo("logourl"); int
	 * getOrgID = orgRepo.save(org).getId();
	 * 
	 * System.out.println("orgid"+getOrgID);
	 * 
	 * 
	 * 
	 * user.setAnalytics_id(1); user.setEmail(signupFormDTO.getEmail());
	 * user.setFirstname(signupFormDTO.getFirstName());
	 * user.setLastname(signupFormDTO.getLastName());
	 * user.setUserName(signupFormDTO.getEmail()); user.setOrg_id(getOrgID);
	 * user.setPassword(bCryptPasswordEncoder.encode(signupFormDTO.getPassword()));
	 * user.setPhone1(signupFormDTO.getPhone()); user.setProfile_pic(photo);
	 * user.setRole_id(1); userRepo.save(user);
	 * 
	 * 
	 * 
	 * } return "login"; }
	 */
 
	@GetMapping("/authenticate")
	public String auth() {
		return "login";
	}
	
	@GetMapping("/logout")
	public String logout() {
		
		return "";
	}
}
