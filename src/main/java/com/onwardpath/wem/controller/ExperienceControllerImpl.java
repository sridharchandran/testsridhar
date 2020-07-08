package com.onwardpath.wem.controller;

import java.sql.Date;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import com.onwardpath.wem.entity.Experience;
import com.onwardpath.wem.entity.User;
import com.onwardpath.wem.model.PopupExpCreateFormDTO;
import com.onwardpath.wem.projections.SegmentNames;
import com.onwardpath.wem.repository.SegmentRepository;
import com.onwardpath.wem.service.ExperienceService;
import com.onwardpath.wem.service.SegmentService;
import com.onwardpath.wem.service.UserService;

@Service
public class ExperienceControllerImpl {

	private ExperienceService expService;
	private SegmentService segService;
	private UserService userService;
	HttpSession session;

	@Autowired
	public ExperienceControllerImpl(SegmentService segService, ExperienceService expService,UserService userService, HttpSession session) {
		this.segService = segService;
		this.expService = expService;
		this.userService = userService;
		this.session = session;
	}

	public List<SegmentNames> getSegmentNames(int orgId) {
		return segService.getSegmentNamesByOrgId(orgId);
	}

	// Adding segments list into ModelView to render Segment DropDown for Exp create
	// Page
	public ModelAndView validateAndGetSegmentList() {
		int orgId = Integer.parseInt(session.getAttribute("org_id").toString());
		List<SegmentNames> seglist = getSegmentNames(orgId);
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("seglist", seglist);
		if (seglist.size() == 0) {
			String message = "Error: No Segments are configured. Create a Segment <a class='kt-link kt-font-bold' href='?view=pages/segment-create.jsp'>here</a>";
			session.setAttribute("message", message);
		}
		return modelAndView;
	}

	// Storing values into Experience Table
	public int saveExperience(String exp_name, String exp_type, String status, int user_id) {
		int exp_id = 0;
		System.out.print("null"+user_id);
		User user = userService.findById(user_id);
		String fullname = getFullName(user.getFirstname(), user.getLastname());
		String name = exp_name;
		int org_Id = user.getOrgid();
		String type = exp_type;
		DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");  
    	LocalDateTime now = LocalDateTime.now();  
    	System.out.println(dtf.format(now)); 

		Experience newExp = new Experience();
		newExp.setCreatedBy(fullname);
		newExp.setName(name);
		newExp.setStatus(status);
		newExp.setType(type);
		newExp.setScheduleStart(dtf.format(now));
		newExp.setOrgId(org_Id);
		newExp.setModBy(fullname);
		newExp.setCreatedTime(dtf.format(now));
		newExp.setUserid(user_id);
		newExp = expService.saveExperience(newExp);

		exp_id = newExp.getId();
		return exp_id;
	}

	// Return Experience ID after storing values in to Exp table
	public ModelAndView savePopupExp(PopupExpCreateFormDTO popupExpCreateFormDTO) {
		ModelAndView modelAndView = new ModelAndView();
		String exp_name = popupExpCreateFormDTO.getName();
		String type = popupExpCreateFormDTO.getType();
		String status = "on";
		int user_id = (int) session.getAttribute("user_id");
		int org_id = (int) session.getAttribute("org_id");

		boolean expExists = expService.expExists(org_id, exp_name);
		if (expExists) {
			session.setAttribute("message", expCreateSetErrorMessage(exp_name));
			modelAndView.addObject("expExists", expExists);
		} else {
			expExists = false;
			int exp_id = saveExperience(exp_name, type, status, user_id);
			String pop_events = popupExpCreateFormDTO.getPage_events();
			String pop_cookie = popupExpCreateFormDTO.getPopup_cookie();
  		  	String pop_delay = popupExpCreateFormDTO.getPopup_delay();
			session.setAttribute("message",expCreateSetSuccessMessage(exp_name));
			modelAndView.addObject("exp_id", exp_id);
			modelAndView.addObject("expExists", expExists);
		}
		return modelAndView;
	}
	
	public String expCreateSetErrorMessage(String exp_name)
	{
		String message = "Error: Experience with name <b>" + exp_name + "</b> is already exist";
		return message;
	}
	
	public String expCreateSetSuccessMessage(String exp_name)
	{
		String message ="Experience <b>"+exp_name+"</b> saved. You can now configure the pages for this experience";
		return message;
	}

	public String getFullName(String firstname, String lastname)
	{
		String fullname = firstname + " " + lastname;
		return fullname;
	}

}
