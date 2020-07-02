package com.onwardpath.wem.controller;

import java.sql.Date;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import com.onwardpath.wem.entity.Segment;
import com.onwardpath.wem.entity.User;
import com.onwardpath.wem.model.SegmentCreateFormDTO;
import com.onwardpath.wem.service.SegmentService;
import com.onwardpath.wem.service.UserService;


@Service
public class SegmentControllerImpl {
	
	private SegmentService segService;
	private UserService userService;
	HttpSession session;
		
	
	public SegmentControllerImpl(SegmentService segService,UserService userService ,HttpSession session) {
		
		this.segService = segService;
		this.userService = userService;
		this.session = session;
	}



	public ModelAndView saveSegment (SegmentCreateFormDTO segmentCreateFormDTO) {
		ModelAndView modelAndView = new ModelAndView();
		
		String seg_name = segmentCreateFormDTO.getSegmentName();
		String rules = segmentCreateFormDTO.getSegmentRules();
		
		int user_id = (int) session.getAttribute("user_id");
		int org_id = (int) session.getAttribute("org_id");
		
		boolean segExists = segService.segExists(org_id, seg_name);
		System.out.println("segexists="+segExists);
		System.out.println("rules="+rules);
		
		if (segExists) {
			String message = "Error: Segment name "+seg_name+" already exist. Try another name.";
			session.setAttribute("message", message);
		}
		else
		{
			
			int seg_id = saveSegment(seg_name, rules, org_id, user_id);
		
			System.out.println("seg_id="+seg_id);
			
			session.setAttribute("message", "Segment <b>"+seg_name+"</b> Saved.");
			
		}
		return modelAndView;
		
	}
	
	// Storing values into Experience Table
		public int saveSegment(String seg_name, String rules, int org_id, int user_id) {
			int seg_id = 0;
			String name = seg_name;
			String segrules = rules;
			
			User user = userService.findById(user_id);
			String UserFirstname = user.getFirstname();
			String lastname = user.getLastname();
			String username = UserFirstname + " " + lastname;
			int org_Id = user.getOrgid();
			
			DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");  
	    	LocalDateTime now = LocalDateTime.now();  
	    	System.out.println(dtf.format(now));  
			
			Segment seg = new Segment();
			seg.setName(name);
			seg.setRule(segrules);
			seg.setCreatedBy(username);
			seg.setOrgId(org_Id);
			seg.setCreatedTime(now);
			seg.setModBy(username); 
			seg.setModTime(now);
			seg.setUserid(user_id);
			seg = segService.saveSegment(seg);
			seg_id = seg.getId();
			return seg_id ;
			
		}

}
