package com.onwardpath.wem.controller;

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.time.LocalDateTime;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.onwardpath.wem.entity.Organization;
import com.onwardpath.wem.entity.User;
import com.onwardpath.wem.model.SignupFormDTO;
import com.onwardpath.wem.repository.OrgRepository;
import com.onwardpath.wem.repository.UserRepository;
import com.onwardpath.wem.service.AnalyticsService;
import com.onwardpath.wem.service.UserService;

@Service
public class UserControllerImpl {

	@Autowired
	private AnalyticsService analyticsService;

	private UserService userService;
	private UserRepository userRepository;
	private BCryptPasswordEncoder bCryptPasswordEncoder;

	@Autowired
	public UserControllerImpl(UserRepository userRepository, UserService userService,
			BCryptPasswordEncoder bCryptPasswordEncoder) {
		this.userRepository = userRepository;
		this.userService = userService;
		this.bCryptPasswordEncoder = bCryptPasswordEncoder;
	}

	public ModelAndView registerUser(SignupFormDTO signupFormDTO, HttpSession session) throws IOException {
		ModelAndView modelAndView = new ModelAndView();
		System.out.println("signup" + signupFormDTO.getEmail());
		User userExists = userService.findByEmail(signupFormDTO.getEmail());
		Organization orgExists = userService.findOrgIDByDomain(signupFormDTO.getDomain());
		byte[] photo = signupFormDTO.getPhoto().getBytes();

		User user = new User();
		Organization org = new Organization();

		if (userExists != null) {
			session.setAttribute("message", "Error. User " + signupFormDTO.getEmail()
					+ " already exists. <a href='login'>Click here</a> to login");
			modelAndView.setViewName("redirect:/registration");
		} else {
			if (orgExists != null) {
				System.out.println("Organization already exists");
				user.setOrg_id(orgExists.getId());
				String root_domain = analyticsService.getRootDomain(orgExists.getDomain());
				int analytics_id = analyticsService.getRowIdbyRootDomain(root_domain);
				user.setAnalytics_id(analytics_id);
			} else {
				String orgName = signupFormDTO.getOrgName();
				String domainURL = signupFormDTO.getDomain();
				org.setName(orgName);
				org.setDomain(domainURL);
				org.setLogo("logourl");
				int getOrgID = userService.saveOrg(org).getId();
				int analytics_id = analyticsService.registerWebsite(orgName, domainURL);
				user.setOrg_id(getOrgID);
				user.setAnalytics_id(analytics_id);

			}
			org.setName(signupFormDTO.getOrgName());
			org.setDomain(signupFormDTO.getDomain());
			org.setLogo("logourl");
			int getOrgID = userService.saveOrg(org).getId();
			user.setEmail(signupFormDTO.getEmail());
			user.setFirstname(signupFormDTO.getFirstName());
			user.setLastname(signupFormDTO.getLastName());
			user.setUserName(signupFormDTO.getEmail());
			user.setPassword(signupFormDTO.getPassword());
			user.setPhone1(signupFormDTO.getPhone());
			user.setProfile_pic(photo);
			user.setRole_id(1);
			user.setCreatedTime(LocalDateTime.now());
			user = userService.saveUser(user);
			modelAndView.addObject("id", user.getId());
			session.setAttribute("message",
					"User Registration succesfully completed for user:' " + user.getFirstname() + "'");
			modelAndView.setViewName("redirect:/login");
		}

		return modelAndView;

	}

	public ModelAndView profile(SignupFormDTO signupFormDTO, HttpSession session) throws IOException {

		ModelAndView modelAndView = new ModelAndView();
		User user = new User();
		byte[] photo = signupFormDTO.getPhoto().getBytes();
		int id = ((User) session.getAttribute("user")).getId();
		
		boolean error = false;

		user = userRepository.findById(id);
		if (signupFormDTO.getFirstName() != null) {
			user.setFirstname(signupFormDTO.getFirstName());
		}

		if (signupFormDTO.getLastName() != null) {

			user.setLastname(signupFormDTO.getLastName());

		}
		if (signupFormDTO.getPhone() != null) {

			user.setPhone1(signupFormDTO.getPhone());

		}

		if (signupFormDTO.getPhoto().isEmpty() == false) {

			photo = signupFormDTO.getPhoto().getBytes();
			user.setProfile_pic(photo);

		}

		if (signupFormDTO.getPassword().isEmpty() == false) {

			System.out.println("sys pas=" + signupFormDTO.getPassword());
			if (bCryptPasswordEncoder.matches(signupFormDTO.getPassword(), user.getPassword())) {
				error = false;
				user.setPassword(bCryptPasswordEncoder.encode(signupFormDTO.getNewpassword()));
				modelAndView.setViewName("/index.jsp?view=pages/profile-view-myprofile");

			} else {
				System.out.println("coming else");
				error = true;
				modelAndView.setViewName("/index.jsp?view=pages/profile-view-myprofile");

			}

		}
		user.setModifiedTime(LocalDateTime.now());
		
		if(error)
		session.setAttribute("message", "password entered doesn't match ");
		else
		{
		userService.saveUpdateUser(user);
		session.setAttribute("message", "Update Success");
		modelAndView.setViewName("/index.jsp?view=pages/profile-view-myprofile");
		}

		return modelAndView;
	}

}
