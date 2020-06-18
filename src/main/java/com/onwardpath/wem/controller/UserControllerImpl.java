package com.onwardpath.wem.controller;

import java.io.IOException;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import com.onwardpath.wem.entity.Organization;
import com.onwardpath.wem.entity.User;
import com.onwardpath.wem.model.SignupFormDTO;
import com.onwardpath.wem.service.AnalyticsService;
import com.onwardpath.wem.service.UserService;

@Service
public class UserControllerImpl {
	
	@Autowired
	private UserService userService;
	
	@Autowired
	private AnalyticsService analyticsService;
	
	
	
	
	public ModelAndView registerUser(SignupFormDTO signupFormDTO,HttpSession session) throws IOException {
		ModelAndView modelAndView = new ModelAndView();
		User userExists = userService.findByEmail(signupFormDTO.getEmail());
        Organization orgExists = userService.findOrgIDByDomain(signupFormDTO.getDomain());
        byte[] photo = signupFormDTO.getPhoto().getBytes();
        
        User user = new User();
        Organization org = new Organization();

        if (userExists != null) {
           session.setAttribute("message", "Error. User " + signupFormDTO.getEmail() + " already exists. <a href='/wem/login'>Click here</a> to login");
           modelAndView.setViewName("redirect:/registration");
        }
        else
        {
        	if(orgExists != null)
        	{
        	System.out.println("Organization already exists");
          	user.setOrg_id(orgExists.getId());
			String root_domain = analyticsService.getRootDomain(orgExists.getDomain());
			int analytics_id = analyticsService.getRowIdbyRootDomain(root_domain);
			user.setAnalytics_id(analytics_id);
        	}
        	else
        	{
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
          	userService.saveUser(user);
			session.setAttribute("message","User Registration succesfully completed for user:' " +user.getFirstname()+"'");
			modelAndView.setViewName("redirect:/login");
        }
  		return modelAndView;
		
	}
	
	
}
