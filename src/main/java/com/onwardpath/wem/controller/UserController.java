package com.onwardpath.wem.controller;

import java.io.IOException;
import java.util.List;
import java.util.Optional;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.onwardpath.wem.entity.Experience;
import com.onwardpath.wem.entity.Expinterface;
import com.onwardpath.wem.entity.Organization;
import com.onwardpath.wem.entity.Role;
import com.onwardpath.wem.entity.User;
import com.onwardpath.wem.model.ExperienceViewDTO;
import com.onwardpath.wem.model.SignupFormDTO;
import com.onwardpath.wem.repository.ExpRepository;
import com.onwardpath.wem.repository.OrgRepository;
import com.onwardpath.wem.repository.RoleRepository;
import com.onwardpath.wem.repository.UserRepository;
import com.onwardpath.wem.service.UserService;

@Controller
@Service
/* @SessionAttributes("user") */
public class UserController {

	@Autowired
	UserRepository userRepo;

	@Autowired
	OrgRepository orgRepo;
	
	@Autowired
	ExpRepository expRepo;

	@Autowired
	private UserService userService;
	
	@Autowired
	UserControllerImpl userControllerImpl;
		 
	 @Autowired
	 AppProperties myAppProperties;
	 
	 @Autowired
		private AnalyticsService analyticsService;
	 
		
		@Autowired
		private NativeRepository nr;
	
	

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

	@GetMapping("/DisplayImageController/{id}")
	public ResponseEntity<byte[]>  DisplayImage(@PathVariable("id") int id) throws IOException {
		
		User image  = userRepo.findByid(id);
		
		return ResponseEntity.ok().contentType(MediaType.IMAGE_JPEG).body(image.getProfile_pic());
	}
//    @RequestMapping(value = "/login", method = RequestMethod.POST)
//    @ResponseBody
//    public Optional<User> authenticateUser(User user) {
// 
//    	System.out.println("response email"+user.getUserName());
//		/* return userRepo.findById(88); */ 
//    	return Optional.of(userRepo.findByEmail(user.getUserName()));
//    }

	 @GetMapping("/profilesetting")
	    public String profile_setting()
	    {
	    	
	    	return "/index.jsp?view=pages/profile-view-settings";
	    }
	 
	 @GetMapping("/userprofilesetting")
	    public String userprofilesetting()
	    {
    	
	    	return "/index.jsp?view=pages/profile-view-myprofile";
	    }
	 
	 @PostMapping("/profile")
	 
	    public ModelAndView myprofile(SignupFormDTO signupFormDTO, HttpSession session) throws IOException
	    {

 	
		 	ModelAndView modelAndView = userControllerImpl.profile(signupFormDTO, session);
	    	return modelAndView;
	    }
	 
	 
	@GetMapping(value="/byid",produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public ResponseEntity<Object> byID(@ModelAttribute("user") User user) throws IOException {
		//return new ResponseEntity<Object>(userRepo.findByOrgidIs(70), HttpStatus.OK);
		//AnalyticsService analyticsService = new AnalyticsServiceImpl();
		//return new ResponseEntity<Object>(myAppProperties.getMatomo_url(), HttpStatus.OK);
		return new ResponseEntity<Object>(nr.getResultSetforExpView(),HttpStatus.OK);
	}
	
	@GetMapping("/byorgid")
	@ResponseBody
    public List<ExperienceViewDTO> experience(@ModelAttribute("experience") Experience exp) {
		 int org_id=1;
		// int limit =10;
    	return expRepo.findbyorgID(86);
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