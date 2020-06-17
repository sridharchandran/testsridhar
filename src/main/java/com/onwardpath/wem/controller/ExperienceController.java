package com.onwardpath.wem.controller;

import java.sql.Date;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.onwardpath.wem.entity.Config;
import com.onwardpath.wem.entity.Content;
import com.onwardpath.wem.entity.Experience;
import com.onwardpath.wem.repository.ExperienceRepository;
import com.onwardpath.wem.service.ExperienceServiceImpl;

import javassist.compiler.ast.NewExpr;

@Controller
public class ExperienceController {
	@Autowired
	ExperienceServiceImpl expseg;
	
	@Autowired
	ExperienceRepository expRepo;
	
	
	/**
	 * Link formation and get segment dropdown Value for Experience Create Content
	 */
	@GetMapping("/content")
	public String createContent(ModelMap mp,HttpSession session) {
		int org_Id =(Integer)session.getAttribute("org_id");
		mp.put("seglist", expseg.findSegmentByOrgId(org_Id));
		return "index.jsp?view=pages/experience-create-content";
	}
	
	 
	/**
	 * Experience Create Content DB Save functionality
	 * @throws JsonProcessingException 
	 * @throws JsonMappingException 
	 */
	@RequestMapping(value = "/experiencesave", method = RequestMethod.POST)
	public String submitContentExperience(ModelMap mp,HttpSession session,HttpServletRequest request) throws JsonMappingException, JsonProcessingException {
		  
		String UserFirstname = (String)session.getAttribute("firstname");
		String lastname = (String) session.getAttribute("lastname");
		
		String username = UserFirstname + " " + lastname;
		String name = request.getParameter("name");
		int org_Id =(Integer)session.getAttribute("org_id");
		
		String type = "content";
		String status = "on";
		
		Date date = new Date(System.currentTimeMillis());
		Experience newcontentexp = new Experience();
		newcontentexp.setCreate_by(username);
		newcontentexp.setName(name);
		newcontentexp.setStatus(status);
		newcontentexp.setType(type);
		newcontentexp.setSchedule_start(date);
		newcontentexp.setOrg_id(org_Id);
		newcontentexp.setMod_by(username);
		newcontentexp.setCreate_time(date);
		expseg.saveExperience(newcontentexp);
		
		int experience_id = newcontentexp.getId();
		
		 String experienceDetails = request.getParameter("experienceDetails");	            		  	            		 
		  ObjectMapper mapper = new ObjectMapper();	            		  
		  Map<String, String> map = mapper.readValue(experienceDetails, Map.class);
		  System.out.println(map);	            		  
		  for (Map.Entry<String, String> entry : map.entrySet()) {	            			  
			  int segment_id = Integer.parseInt(entry.getKey());
			  String contentvalue = entry.getValue();
			  Content content = new Content();
			  content.setExperience_id(experience_id);
			  content.setSegment_id(segment_id);
			  content.setContent(contentvalue);
			  content.setCreate_time(date);
			  expseg.savecontent(content);          			  	            			 
		  }				 		
		  mp.put("zonelist", expseg.gettimezone());
		  
		  //request.setAttribute("exp_id", exp_id);
		  //mp.addAttribute("exp_id", exp_id);
		  //mp.addAttribute("msg", "Experience <b>"+newcontentexp.getName()+"</b> saved. You can now configure the pages for this experience.#"+exp_id+"#"+name);
		  
		  session.setAttribute("message", "Experience <b>"+name+"</b> saved. You can now configure the pages for this experience. #n="+name+"#e="+experience_id+"#o="+newcontentexp.getOrg_id()+"#t="+type); 
		return "index.jsp?view=pages/experience-create-enable";
	}
	
	   
	
	/**
	 * Experience config DB Save functionality
	 * @throws JsonProcessingException 
	 * @throws JsonMappingException 
	 */
	@RequestMapping(value = "/configsave", method = RequestMethod.POST)
	public String submitconfig(ModelMap mp,HttpSession session,HttpServletRequest request) throws JsonMappingException, JsonProcessingException {
		
		
		int experience_id = Integer.parseInt(request.getParameter("experience_id"));
		
		String expname = request.getParameter("experience_name");
		//String org_id = request.getParameter("name");
		String experience_type = request.getParameter("experience_type");
		int user_Id =(Integer)session.getAttribute("userid");
		int org_id = (Integer)session.getAttribute("org_id"); 
		String configDetails = request.getParameter("urlList");	            		
		Date date = new Date(System.currentTimeMillis());
        ObjectMapper mapper = new ObjectMapper();	            		  
        @SuppressWarnings("unchecked")
		Map<String, String> map = mapper.readValue(configDetails, Map.class);
        System.out.println(map);	            		  
        for (Map.Entry<String, String> entry : map.entrySet()) {	            			  
        	int index = Integer.parseInt(entry.getKey());
        	String url = entry.getValue();
        	Config config = new Config();
        	config.setExperience_id(experience_id);
        	config.setUrl(url);
        	config.setUser_id(user_Id);
        	config.setCreate_time(date);
        	expseg.saveconfig(config);           			  	            			 
        }	
        //mp.addAttribute("msg", "Page configuration for <b>"+expname+"</b> saved succesfully");
        
        session.setAttribute("message", "Page configuration for <b>"+expname+"</b> saved succesfully.#n="+expname+"#e="+experience_id+"#o="+org_id+"#t="+experience_type);
		return "index.jsp?view=pages/experience-create-enable";
		
	}
        
}
 