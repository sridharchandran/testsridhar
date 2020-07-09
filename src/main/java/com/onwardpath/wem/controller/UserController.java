package com.onwardpath.wem.controller;

import java.io.IOException;
import java.util.List;
import java.util.Optional;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
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

import com.onwardpath.wem.AppProperties;
import com.onwardpath.wem.entity.Experience;
import com.onwardpath.wem.entity.Organization;
import com.onwardpath.wem.entity.Role;
import com.onwardpath.wem.entity.User;
import com.onwardpath.wem.model.ExperienceViewDTO;
import com.onwardpath.wem.model.SignupFormDTO;
import com.onwardpath.wem.projections.Expinterface;
import com.onwardpath.wem.repository.ExperienceRepository;
import com.onwardpath.wem.repository.NativeRepository;
import com.onwardpath.wem.repository.OrgRepository;
import com.onwardpath.wem.repository.RoleRepository;
import com.onwardpath.wem.repository.SegmentRepository;
import com.onwardpath.wem.repository.UserRepository;
import com.onwardpath.wem.service.AnalyticsService;
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
	ExperienceRepository expRepo;

	@Autowired
	SegmentRepository segRepo;

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
		Organization org = orgRepo.findById(user.getOrgid());
		System.out.println("Authenticated User ID" + user.getId());
		session.setAttribute("authenticated", "true");
		session.setAttribute("user", user);
		session.setAttribute("org", org);
		session.setAttribute("user_id", user.getId());
		session.setAttribute("org_id", user.getOrgid());
		session.setAttribute("site_id", user.getAnalytics_id());
		return "redirect:/home";
	}

	@GetMapping("/DisplayImageController")
	public ResponseEntity<byte[]> DisplayImage(HttpSession session) throws IOException {

		byte[] pic = ((User) session.getAttribute("user")).getProfile_pic();

		return ResponseEntity.ok().contentType(MediaType.IMAGE_JPEG).body(pic);
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
	public String profile_setting() {

		return "/index.jsp?view=pages/profile-view-settings";
	}

	@GetMapping("/userprofilesetting")
	public String userprofilesetting() {

		return "/index.jsp?view=pages/profile-view-myprofile";
	}

	@PostMapping("/profile")

	public ModelAndView myprofile(SignupFormDTO signupFormDTO, HttpSession session) throws IOException {
		ModelAndView modelAndView = userControllerImpl.profile(signupFormDTO, session);
		return modelAndView;
	}

	@GetMapping(value = "/byid", produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public ResponseEntity<Object> byID(@ModelAttribute("user") User user, HttpSession session) throws IOException {
		// return new ResponseEntity<Object>(userRepo.findByOrgidIs(70), HttpStatus.OK);
		// AnalyticsService analyticsService = new AnalyticsServiceImpl();
		// return new ResponseEntity<Object>(myAppProperties.getMatomo_url(),
		// HttpStatus.OK);
		return new ResponseEntity<Object>(userRepo.findById(5), HttpStatus.OK);
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