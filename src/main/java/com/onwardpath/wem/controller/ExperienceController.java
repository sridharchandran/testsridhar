package com.onwardpath.wem.controller;

import java.io.IOException;
import java.sql.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.Instant;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.onwardpath.wem.entity.Config;
import com.onwardpath.wem.entity.Content;
import com.onwardpath.wem.entity.Experience;
import com.onwardpath.wem.model.ExperienceViewPostDTO;
import com.onwardpath.wem.model.PopupExpCreateFormDTO;
import com.onwardpath.wem.model.SignupFormDTO;
import com.onwardpath.wem.repository.ExperienceRepository;
import com.onwardpath.wem.repository.NativeRepository;
import com.onwardpath.wem.service.ExperienceServiceImpl;
import com.onwardpath.wem.service.NativeService;
import com.onwardpath.wem.projections.SegmentNames;

import javassist.compiler.ast.NewExpr;

@Controller
public class ExperienceController {
	@Autowired
	ExperienceServiceImpl expseg;

	@Autowired
	ExperienceRepository expRepo;
	
	@Autowired
	ExperienceControllerImpl expControllerImpl;
	
	@Autowired
	private NativeRepository nr;
	
	@Autowired
	NativeService nativeService;
	
	/**
	 * Link formation and get segment dropdown Value for Experience Create Content
	 */
	@GetMapping("/content")
	public String createContent(ModelMap mp, HttpSession session) {
		int org_Id = (Integer) session.getAttribute("org_id");
		System.out.println("myordid" + org_Id);
		mp.put("seglist", expseg.findSegmentByOrgId(org_Id));

		return "index.jsp?view=pages/experience-create-content";
	}

	/**
	 * Experience Create Content DB Save functionality
	 * 
	 * @throws JsonProcessingException
	 * @throws JsonMappingException
	 */
	@RequestMapping(value = "/experiencesave", method = RequestMethod.POST)
	public String submitContentExperience(ModelMap mp, HttpSession session, HttpServletRequest request)
			throws JsonMappingException, JsonProcessingException {

		String UserFirstname = (String) session.getAttribute("firstname");
		String lastname = (String) session.getAttribute("lastname");

		String username = UserFirstname + " " + lastname;
		String name = request.getParameter("name");
		int org_Id = (Integer) session.getAttribute("org_id");

		String type = "content";
		String status = "on";

		Date date = new Date(System.currentTimeMillis());
		Experience newcontentexp = new Experience();
		newcontentexp.setCreatedBy(username);
		newcontentexp.setName(name);
		newcontentexp.setStatus(status);
		newcontentexp.setType(type);
		newcontentexp.setScheduleStart(date);
		newcontentexp.setOrgId(org_Id);
		newcontentexp.setModBy(username);
		newcontentexp.setCreateTime(date);

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

		// request.setAttribute("exp_id", exp_id);
		// mp.addAttribute("exp_id", exp_id);
		// mp.addAttribute("msg", "Experience <b>"+newcontentexp.getName()+"</b> saved.
		// You can now configure the pages for this experience.#"+exp_id+"#"+name);

		session.setAttribute("message",
				"Experience <b>" + name + "</b> saved. You can now configure the pages for this experience. #n=" + name
						+ "#e=" + experience_id + "#o=" + newcontentexp.getOrgId() + "#t=" + type);
		return "index.jsp?view=pages/experience-create-enable";
	}

	// Function tot convert String to Date
	public static Instant getDateFromString(String string) {

		// Create an Instant object
		Instant timestamp = null;

		// Parse the String to Date
		timestamp = Instant.parse(string);

		// return the converted timestamp
		return timestamp;
	}

	/**
	 * Experience config DB Save functionality
	 * 
	 * @throws JsonProcessingException
	 * @throws JsonMappingException
	 * @throws ParseException
	 */
	@RequestMapping(value = "/configsave", method = RequestMethod.POST)
	public String submitconfig(ModelMap mp, HttpSession session, HttpServletRequest request)
			throws JsonMappingException, JsonProcessingException, ParseException {

		int experience_id = Integer.parseInt(request.getParameter("experience_id"));

		String expname = request.getParameter("experience_name");
		// String org_id = request.getParameter("name");
		String experience_type = request.getParameter("experience_type");
		int user_Id = (Integer) session.getAttribute("user_id");
		int org_id = (Integer) session.getAttribute("org_id");
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

		if (request.getParameter("status") != null && request.getParameter("status") != "") {
			System.out.println("Statu:" + request.getParameter("status"));
			System.out.println("sdate:" + request.getParameter("startdate"));
			System.out.println("edate:" + request.getParameter("enddate"));
			Experience newexp = new Experience();
			String startdate = request.getParameter("startdate");

			SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy-mm-dd hh:mm:ss");
			java.util.Date dates = sdf1.parse(startdate);
			java.sql.Date sqlStartDate = new java.sql.Date(dates.getTime());

			String enddate = request.getParameter("enddate");

			SimpleDateFormat sdf2 = new SimpleDateFormat("yyyy-mm-dd hh:mm:ss");
			java.util.Date datess = sdf1.parse(enddate);
			java.sql.Date sqlendDate = new java.sql.Date(datess.getTime());

			newexp.setScheduleStart(sqlStartDate);
			newexp.setScheduleEnd(sqlendDate);
			newexp.setStatus(request.getParameter("status"));
			newexp.setTimezoneId(request.getParameter("timezoneval"));
			expRepo.updateexperience(newexp.getTimezoneId(), newexp.getScheduleStart(), newexp.getScheduleEnd(),
					newexp.getStatus(), experience_id);

		}

		// mp.addAttribute("msg", "Page configuration for <b>"+expname+"</b> saved
		// succesfully");

		session.setAttribute("message", "Page configuration for <b>" + expname + "</b> saved succesfully.#n=" + expname
				+ "#e=" + experience_id + "#o=" + org_id + "#t=" + experience_type);
		return "index.jsp?view=pages/experience-create-enable";

	}
	 @GetMapping("/experienceviewpage")
	    public String userprofilesetting()
	    {
 	
	    	return "/index.jsp?view=pages/experience-view";
	    }
	
	
		// Endpoint for Experience View Page
		@GetMapping(value = "/AjaxExpController", produces = MediaType.APPLICATION_JSON_VALUE)
		@ResponseBody
		public String ajaxExperience(@RequestParam("offset") int offset,@RequestParam("limit") int limit) throws IOException {
		
			String search = null;

			return nativeService.getResultSetforExpView(1, offset, limit, search);
		}
		
		// Endpoint for Search/Status/Modal_popup
		@PostMapping(value = "/AjaxExpController", produces = MediaType.APPLICATION_JSON_VALUE)
		@ResponseBody
		public String ajaxPostExperience(ExperienceViewPostDTO experienceViewPostDTO) throws IOException {
		
			return nativeService.getResultSetforExpViewPost(experienceViewPostDTO);
		}
	
	
	/**
	 * Popup Experience --> Create
	 */
	@RequestMapping(value = "/create-popup", method = RequestMethod.GET)
	public ModelAndView createPopupView() throws IOException {
		ModelAndView modelAndView = expControllerImpl.validateAndGetSegmentList();
		modelAndView.setViewName("index.jsp?view=pages/experience-create-popup");
		return modelAndView;
	}
	
	/**
	 * Popup Experience --> Save
	 */
	@RequestMapping(value = "/create-popup", method = RequestMethod.POST)
	public ModelAndView savePopupExperience(PopupExpCreateFormDTO popupExCreateFormDTO) throws IOException {
		ModelAndView modelAndView = expControllerImpl.savePopupExp(popupExCreateFormDTO);
		modelAndView.setViewName("index.jsp?view=pages/experience-create-enable");
		return modelAndView;
	}

}
