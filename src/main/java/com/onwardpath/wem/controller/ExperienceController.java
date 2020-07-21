package com.onwardpath.wem.controller;

import java.io.IOException;
import java.sql.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.Instant;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.onwardpath.wem.entity.Config;
import com.onwardpath.wem.entity.Content;
import com.onwardpath.wem.entity.Experience;
import com.onwardpath.wem.entity.Image;
import com.onwardpath.wem.model.BarExpCreateFormDTO;
import com.onwardpath.wem.model.ExperienceViewPostDTO;
import com.onwardpath.wem.model.LinkExpCreateFormDTO;
import com.onwardpath.wem.exception.DbInsertException;
import com.onwardpath.wem.model.ImageExpCreateFormDTO;
import com.onwardpath.wem.model.PopupExpCreateFormDTO;
import com.onwardpath.wem.model.SignupFormDTO;
import com.onwardpath.wem.model.StyleExpCreateFormDTO;
import com.onwardpath.wem.repository.ConfigRepository;
import com.onwardpath.wem.repository.ContentRepository;
import com.onwardpath.wem.repository.ExperienceRepository;
import com.onwardpath.wem.repository.ImageRepository;
import com.onwardpath.wem.service.ExperienceEdit;
import com.onwardpath.wem.service.ExperienceService;
import com.onwardpath.wem.repository.NativeRepository;
import com.onwardpath.wem.service.ExperienceServiceImpl;
import com.onwardpath.wem.service.NativeService;
import com.onwardpath.wem.projections.SegmentNames;

import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ResponseStatus;

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
	ExperienceService expService;
	
	@Autowired
	private NativeRepository nr;
	
	@Autowired
	NativeService nativeService;
	
	@Autowired
	ExperienceEdit editservice;
	
	@Autowired
    ContentRepository conRepo;
	
	@Autowired
	ConfigRepository configRepo;
	
	@Autowired
	ImageRepository imgRepo;
	
 
	
	
	
	
	
	
	
	
	/**
	 * Link formation and get segment dropdown Value for Experience Create Content
	 */
	
	@RequestMapping(value = "/content", method = RequestMethod.GET)
	public ModelAndView createContent() throws IOException {
		ModelAndView modelAndView = expControllerImpl.validateAndGetSegmentList();
		modelAndView.setViewName("index.jsp?view=pages/experience-create-content");
		return modelAndView;
	}
	
	
	@RequestMapping(value = "/editcontent", method = RequestMethod.GET)
	public ModelAndView editContent(ModelMap mp,HttpServletRequest request) throws IOException {
		
		ModelAndView modelAndView = expControllerImpl.validateAndGetSegmentList();
		String id = request.getParameter("id");
		System.out.println("idhere:"+id);
		
		modelAndView.addObject("contentvalue", editservice.experienceContent(id));
		modelAndView.addObject("scheduleValue", editservice.experienceschdule(id));
		modelAndView.addObject("zonelist", expseg.gettimezone());
		modelAndView.setViewName("index.jsp?view=pages/experience-edit-content");
		return modelAndView;  
	} 
	 
	@RequestMapping(value = "/editcontentsave", method = RequestMethod.POST)
	public ModelAndView editContentsavevalue(ModelMap mp,HttpServletRequest request,ImageExpCreateFormDTO imgExpCreateFormDTO,HttpSession session) throws IOException {
		ModelAndView modelAndView =  new ModelAndView();
		long id =   Integer.parseInt(request.getParameter("expid"));
		System.out.println("idhere:"+id);
		String expname = request.getParameter("expName");
		System.out.println("name:"+expname);
		expRepo.updateName(expname, id);
		//editservice.saveeditExperiencename(exp, id, expname);
		conRepo.deletecontent((int) id); 
		String experienceDetails = imgExpCreateFormDTO.getExperienceDetails();
		ObjectMapper mapper = new ObjectMapper();
		Map<String, String> map = mapper.readValue(experienceDetails, Map.class);
		System.out.println(map);
		for (Map.Entry<String, String> entry : map.entrySet()) {
			int segment_id = Integer.parseInt(entry.getKey());
			String urlvalue = entry.getValue();
			Content content = new Content();
			content.setExperience_id((int) id);
			content.setSegment_id(segment_id);
			content.setContent(urlvalue);
			content.setCreate_time(LocalDateTime.now());
			expService.savecontent(content);
		}
		
		saveeditconfig(id, request, session);
		saveeditschedule(id, request);	
			
		modelAndView.setViewName("index.jsp?view=pages/experience-view");
		return modelAndView;  
	}
	
	@RequestMapping(value = "/editimage", method = RequestMethod.GET)
	public ModelAndView editimage(ModelMap mp,HttpServletRequest request) throws IOException {
		
		ModelAndView modelAndView = expControllerImpl.validateAndGetSegmentList();
		String id = request.getParameter("id");
		System.out.println("idhere:"+id);
		
		modelAndView.addObject("contentvalue", editservice.experienceImage(id));
		modelAndView.addObject("scheduleValue", editservice.experienceschdule(id));
		modelAndView.addObject("zonelist", expseg.gettimezone());
		modelAndView.setViewName("index.jsp?view=pages/experience-edit-image");
		return modelAndView;  
	} 
	
	@RequestMapping(value = "/editimagesave", method = RequestMethod.POST)
	public ModelAndView editimagesavevalue(ModelMap mp,HttpServletRequest request,ImageExpCreateFormDTO imgExpCreateFormDTO,HttpSession session) throws IOException {
		ModelAndView modelAndView =  new ModelAndView();
		long id =   Integer.parseInt(request.getParameter("expid"));
		System.out.println("idhere:"+id);
		String expname = request.getParameter("expName");
		System.out.println("name:"+expname);
		expRepo.updateName(expname, id);
		//editservice.saveeditExperiencename(exp, id, expname);
		imgRepo.deleteimage((int) id); 
		String experienceDetails = imgExpCreateFormDTO.getExperienceDetails();
		ObjectMapper mapper = new ObjectMapper();
		Map<String, String> map = mapper.readValue(experienceDetails, Map.class);
		System.out.println(map);
		for (Map.Entry<String, String> entry : map.entrySet()) {
			int segment_id = Integer.parseInt(entry.getKey());
			String urlvalue = entry.getValue();
			Image img = new Image();
			img.setExperience_id((int) id);
			img.setSegment_id(segment_id);
			img.setUrl(urlvalue);
			img.setCreate_time(LocalDateTime.now());
			expService.saveimage(img);
		}
		
		saveeditconfig(id, request, session);
		saveeditschedule(id, request);	
		modelAndView.setViewName("index.jsp?view=pages/experience-view");
		return modelAndView;  
	}
 
	public void saveeditconfig(long id,HttpServletRequest request,HttpSession session) throws JsonMappingException, JsonProcessingException {
		
		int user_Id = (Integer) session.getAttribute("user_id");
		//int org_id = (Integer) session.getAttribute("org_id");
		String configDetails = request.getParameter("urlList");
		System.out.println("urliste:"+configDetails);
		LocalDateTime now = LocalDateTime.now();
		ObjectMapper mappers = new ObjectMapper();
		@SuppressWarnings("unchecked")
		Map<String, String> maps = mappers.readValue(configDetails, Map.class);
		System.out.println("hey:"+maps);
		configRepo.deleteconfig(id);
		for (Map.Entry<String, String> entry : maps.entrySet()) {
			int index = Integer.parseInt(entry.getKey());
			String url = entry.getValue();
			Config config = new Config();
			config.setExperience_id((int)id);
			config.setUrl(url);
			config.setUser_id(user_Id);
			config.setCreate_time(now);
			expseg.saveconfig(config);
		
			//configRepo.updateconfig(config.getUrl(),config.getUser_id(),config.getExperience_id());
			 
				}
		
	}
	
	public void saveeditschedule(long id,HttpServletRequest request) {
		
		String schListDetails = request.getParameter("schList");
 		 
	    if(!"{}".equals(schListDetails)) {
	    	System.out.println("inside  if"+schListDetails);
	    	expRepo.updatestatus("scheduled", id);
	    	
	    	if(request.getParameter("startdate") != null && request.getParameter("startdate") !="") {
	    		expRepo.updatestartdate(request.getParameter("startdate"), id);
	    			
    	}
    	if(request.getParameter("enddate") != null && request.getParameter("enddate") !="") {
    		expRepo.updateenddate(request.getParameter("enddate"), id);
    			
    	}
    	if(request.getParameter("timezoneval") != null && request.getParameter("timezoneval") !="") {
    		
            expRepo.updatetimezoneval(request.getParameter("timezoneval"), id);
    		    	}    
	        }else {
	    	
	    	expRepo.resetschdule(id);
	    	
	    	      
	    	System.out.println("coming Inside else");
	    }    
 
		
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

		System.out.print("getmodelmap"+mp.get("exp_id"));
//		int experience_id = Integer.parseInt(request.getParameter("experience_id"));
//
//		String expname = request.getParameter("experience_name");
//		// String org_id = request.getParameter("name");
//		String experience_type = request.getParameter("experience_type");
		
		int exp_id = Integer.parseInt(request.getParameter("exp_id"));	
		Experience e = expService.getExperienceById(exp_id);
		String exp_name = e.getName();
		String exp_type = e.getType();
		
		int user_Id = (Integer) session.getAttribute("user_id");
		int org_id = (Integer) session.getAttribute("org_id");
		String configDetails = request.getParameter("urlList");
		LocalDateTime now = LocalDateTime.now();
		ObjectMapper mapper = new ObjectMapper();
		@SuppressWarnings("unchecked")
		Map<String, String> map = mapper.readValue(configDetails, Map.class);
		System.out.println(map);
		for (Map.Entry<String, String> entry : map.entrySet()) {
			int index = Integer.parseInt(entry.getKey());
			String url = entry.getValue();
			Config config = new Config();
			config.setExperience_id(exp_id);
			config.setUrl(url);
			config.setUser_id(user_Id);
			config.setCreate_time(now);
			expseg.saveconfig(config);
		}

		if (request.getParameter("status") != null && request.getParameter("status") != "") {
			System.out.println("Statu:" + request.getParameter("status"));
			System.out.println("sdate:" + request.getParameter("startdate"));
			System.out.println("edate:" + request.getParameter("enddate"));
			Experience newexp = new Experience();
			
			//DateTimeFormatter format = DateTimeFormatter.ofPattern("yyyy-mm-dd hh:mm:ss");
			
			DateTimeFormatter format = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
	        
	        
			String startdate = request.getParameter("startdate");	
			LocalDateTime sqlStartDate = LocalDateTime.parse(startdate,format);
			

			
			String enddate = request.getParameter("enddate");
			LocalDateTime sqlendDate = LocalDateTime.parse(enddate,format);

	
			newexp.setScheduleStart(sqlStartDate);
			newexp.setScheduleEnd(sqlendDate);
			newexp.setStatus(request.getParameter("status"));
			newexp.setTimezoneId(request.getParameter("timezoneval"));
			expRepo.updateexperience(newexp.getTimezoneId(), newexp.getScheduleStart(), newexp.getScheduleEnd(),
					newexp.getStatus(), exp_id);

		}

		// mp.addAttribute("msg", "Page configuration for <b>"+expname+"</b> saved
		// succesfully");

		session.setAttribute("message", "Page configuration for <b>" + exp_name + "</b> saved succesfully.#n=" + exp_name
				+ "#e=" + exp_id + "#o=" + org_id + "#t=" + exp_type);
		return "index.jsp?view=pages/experience-create-enable";

	}
	  // Endpoint for Experience View Page
	  @GetMapping("/experienceview")
	  public String experienceView()
	  {
 	
	    return "/index.jsp?view=pages/experience-view";
	  }
	
	
	  // Endpoint for Experience custom Pagination
	  
	  @GetMapping(value = "/AjaxExpController", produces =
	  MediaType.APPLICATION_JSON_VALUE)
	  
	  @ResponseBody 
	  public String ajaxExperience(@RequestParam("offset") int
	  offset,@RequestParam("limit") int limit,HttpSession session) throws IOException {
	  
	  String search = null;
	  int org_Id = (Integer) session.getAttribute("org_id");
	  
	  
	  return nativeService.getResultSetforExpView( org_Id, offset, limit, search); }
	 
	
	 	
	// Endpoint for Search/Status/Modal_popup
	@PostMapping(value = "/AjaxExpController", produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public String ajaxPostExperience(ExperienceViewPostDTO experienceViewPostDTO) throws IOException {
	
		return nativeService.getResultSetforExpViewPost(experienceViewPostDTO);
	}
	
	/**
	 * Bar Experience --> Create
	 */
	@RequestMapping(value = "/create-bar", method = RequestMethod.GET)
	public ModelAndView createBarView() throws IOException {
		ModelAndView modelAndView = expControllerImpl.validateAndGetSegmentList();
		modelAndView.setViewName("index.jsp?view=pages/experience-create-bar");
		return modelAndView;
	}
	
	
	/**
	 * Bar Experience --> Save
	 * @throws DbInsertException 
	 */
	@RequestMapping(value = "/create-bar", method = RequestMethod.POST)
	public ModelAndView saveBarExperience(BarExpCreateFormDTO barExpCreateFormDTO,RedirectAttributes rdAttr) throws IOException, DbInsertException {
		ModelAndView modelAndView = expControllerImpl.saveBarExp(barExpCreateFormDTO);
		Map<String, Object> model = modelAndView.getModel();
		System.out.println("expexits="+(boolean) model.get("expExists"));
		boolean expNameExists = (boolean) model.get("expExists");
		
		modelAndView.clear();
		
		if(expNameExists)
		{
		modelAndView.setViewName("redirect:/create-bar");
		}
		else
		{
		String exp_id = model.get("exp_id").toString();
		modelAndView.setViewName("redirect:/experience-config");
		rdAttr.addAttribute("exp_id",exp_id);
		}
		
		return modelAndView;
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
	 * @throws DbInsertException 
	 */
	@RequestMapping(value = "/create-popup", method = RequestMethod.POST)
	public ModelAndView savePopupExperience(PopupExpCreateFormDTO popupExCreateFormDTO,RedirectAttributes rdAttr) throws IOException, DbInsertException {
		ModelAndView modelAndView = expControllerImpl.savePopupExp(popupExCreateFormDTO);
		Map<String, Object> model = modelAndView.getModel();
		boolean expNameExists = (boolean) model.get("expExists");
		
		modelAndView.clear();
		
		if(expNameExists)
		{
		modelAndView.setViewName("index.jsp?view=pages/experience-create-popup");
		}
		else
		{
		String exp_id = model.get("exp_id").toString();
		modelAndView.setViewName("redirect:/experience-config");
		rdAttr.addAttribute("exp_id",exp_id);
		}
		
		return modelAndView;
	}
	
	
	/**
	 * Experience --> Config Page
	 */
	@RequestMapping(value = "/experience-config", method = RequestMethod.GET)
	public ModelAndView saveExperienceConfig(@ModelAttribute("exp_id") String exp_id) throws IOException, DbInsertException {
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("zonelist", expseg.gettimezone());
		modelAndView.addObject("exp_id", exp_id);
		modelAndView.setViewName("index.jsp?view=pages/experience-create-enable");			
		return modelAndView;
	}
	

	 @ExceptionHandler(DbInsertException.class)
	  public ModelAndView handleError(HttpServletRequest req, Exception ex,HttpSession session) {
	    ModelAndView mav = new ModelAndView();
		session.setAttribute("message","Unresolved Error: Please contact administrator");
		System.out.println("type="+session.getAttribute("exp_type"));
		String type = (String) session.getAttribute("exp_type");
	    mav.addObject("exception", ex);
	   
	    mav.setViewName("redirect:/create-popup");	
	    
	    return mav;
	  }
	 
	 /**
		 * Link formation and get segment dropdown Value for Experience Create Image
		 */
		@RequestMapping(value = "/image", method = RequestMethod.GET)
		public ModelAndView createImage() throws IOException {
			ModelAndView modelAndView = expControllerImpl.validateAndGetSegmentList();
			modelAndView.setViewName("index.jsp?view=pages/experience-create-image");
			return modelAndView;
		}
		
		
		/**
		 * Image Experience DB Save
		 */
		
		@RequestMapping(value = "/image", method = RequestMethod.POST)
		public ModelAndView saveimageexp(ImageExpCreateFormDTO imageExCreateFormDTO,RedirectAttributes rdAttr) throws IOException, DbInsertException {
			ModelAndView modelAndView = expControllerImpl.saveimageEXP(imageExCreateFormDTO);
			Map<String, Object> model = modelAndView.getModel();
			boolean expNameExists = (boolean) model.get("expExists");
			
			modelAndView.clear();
			
			if(expNameExists)
			{
			modelAndView.setViewName("index.jsp?view=pages/experience-create-image");
			}
			else
			{
			String exp_id = model.get("exp_id").toString();
			modelAndView.setViewName("redirect:/experience-config");
			rdAttr.addAttribute("exp_id",exp_id);
			}
			
			return modelAndView;
		}

	
		/**
		 * Link formation and get segment dropdown Value for Experience Create style
		 */
		@RequestMapping(value = "/style", method = RequestMethod.GET)
		public ModelAndView createstyle() throws IOException {
			ModelAndView modelAndView = expControllerImpl.validateAndGetSegmentList();
			modelAndView.setViewName("index.jsp?view=pages/experience-create-style");
			return modelAndView;
		}
		
		
		/**
		 * Style Experience DB Save
		 */
		@RequestMapping(value = "/style", method = RequestMethod.POST)
		public ModelAndView savestyleexp(StyleExpCreateFormDTO styleExCreateFormDTO,RedirectAttributes rdAttr) throws IOException, DbInsertException {
			ModelAndView modelAndView = expControllerImpl.saveStyleExp(styleExCreateFormDTO);
			Map<String, Object> model = modelAndView.getModel();
			boolean expNameExists = (boolean) model.get("expExists");
			
			modelAndView.clear();
			
			if(expNameExists)
			{
			modelAndView.setViewName("index.jsp?view=pages/experience-create-style");
			}
			else
			{
			String exp_id = model.get("exp_id").toString();
			modelAndView.setViewName("redirect:/experience-config");
			rdAttr.addAttribute("exp_id",exp_id);
			}
			
			return modelAndView;
		}
		
		
		
		/**
		 * Content Experience DB Save
		 */
		@RequestMapping(value = "/content", method = RequestMethod.POST)
		public ModelAndView savecontenteexp(ImageExpCreateFormDTO imageExCreateFormDTO,RedirectAttributes rdAttr) throws IOException, DbInsertException {
			ModelAndView modelAndView = expControllerImpl.savecontentEXP(imageExCreateFormDTO);
			Map<String, Object> model = modelAndView.getModel();
			boolean expNameExists = (boolean) model.get("expExists");
			
			modelAndView.clear();
			
			if(expNameExists)
			{
			modelAndView.setViewName("index.jsp?view=pages/experience-create-content");
			}
			else
			{
			String exp_id = model.get("exp_id").toString();
			modelAndView.setViewName("redirect:/experience-config");
			rdAttr.addAttribute("exp_id",exp_id);
			}
			
			return modelAndView;
		}
		
		/**
		 * Link Experience --> Create	
		 */
		@RequestMapping(value = "/create-link", method = RequestMethod.GET)
		public ModelAndView createLinkExpereinceView() throws IOException {
			ModelAndView modelAndView = expControllerImpl.validateAndGetSegmentList();
			modelAndView.setViewName("index.jsp?view=pages/experience-create-link");
			return modelAndView;
		}
	
		/**
		 * Link Experience --> Save
		 * @throws DbInsertException 
		 */
		@RequestMapping(value = "/create-link", method = RequestMethod.POST)
		public ModelAndView saveLinkExperience(LinkExpCreateFormDTO linkExCreateFormDTO,RedirectAttributes rdAttr) throws IOException, DbInsertException {
			ModelAndView modelAndView = expControllerImpl.saveLinkExp(linkExCreateFormDTO);
			Map<String, Object> model = modelAndView.getModel();
			boolean expNameExists = (boolean) model.get("expExists");
			
			modelAndView.clear();
			
			if(expNameExists)
			{
			modelAndView.setViewName("index.jsp?view=pages/experience-create-popup");
			}
			else
			{
			String exp_id = model.get("exp_id").toString();
			modelAndView.setViewName("redirect:/experience-config");
			rdAttr.addAttribute("exp_id",exp_id);
			}
			
			return modelAndView;
		}
		
		
		
		/**
		 * Redirect Experience --> Create	
		 */
		@RequestMapping(value = "/redirect", method = RequestMethod.GET)
		public ModelAndView createRedirect() throws IOException {
			ModelAndView modelAndView = expControllerImpl.validateAndGetSegmentList();
			modelAndView.setViewName("index.jsp?view=pages/experience-create-redirect");
			return modelAndView;
		}
	
		/**
		 * Redirect Experience --> Save
		 * @throws DbInsertException 
		 */
		@RequestMapping(value = "/redirect", method = RequestMethod.POST)
		public ModelAndView saveRedirectExperience(StyleExpCreateFormDTO styelExpCreateFormDTO ,RedirectAttributes rdAttr) throws IOException, DbInsertException {
			ModelAndView modelAndView = expControllerImpl.saveRedirectExp(styelExpCreateFormDTO);
			Map<String, Object> model = modelAndView.getModel();
			boolean expNameExists = (boolean) model.get("expExists");
			
			modelAndView.clear();
			
			if(expNameExists)
			{
			modelAndView.setViewName("index.jsp?view=pages/experience-create-popup");
			}
			else
			{
			String exp_id = model.get("exp_id").toString();
			modelAndView.setViewName("redirect:/experience-config");
			rdAttr.addAttribute("exp_id",exp_id);
			}
			
			return modelAndView;
		}

		
		

}
