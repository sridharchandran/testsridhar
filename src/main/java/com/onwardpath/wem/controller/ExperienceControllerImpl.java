package com.onwardpath.wem.controller;

import java.sql.Date;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import javax.servlet.http.HttpSession;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.ModelMap;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.onwardpath.wem.entity.Bar;
import com.onwardpath.wem.entity.Content;
import com.onwardpath.wem.entity.Experience;
import com.onwardpath.wem.entity.Image;
import com.onwardpath.wem.entity.Link;
import com.onwardpath.wem.entity.Popup;
import com.onwardpath.wem.entity.PopupAttributes;
import com.onwardpath.wem.entity.Style;
import com.onwardpath.wem.entity.User;
import com.onwardpath.wem.exception.DbInsertException;
import com.onwardpath.wem.model.BarExpCreateFormDTO;
import com.onwardpath.wem.model.ImageExpCreateFormDTO;
import com.onwardpath.wem.model.LinkExpCreateFormDTO;
import com.onwardpath.wem.model.PopupExpCreateFormDTO;
import com.onwardpath.wem.model.StyleExpCreateFormDTO;
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
	public ExperienceControllerImpl(SegmentService segService, ExperienceService expService, UserService userService,
			HttpSession session) {
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
		System.out.print("null" + user_id);
		User user = userService.findById(user_id);
		String fullname = getFullName(user.getFirstname(), user.getLastname());
		String name = exp_name;
		int org_Id = user.getOrgid();
		String type = exp_type;
		// Date date = new Date(System.currentTimeMillis());
		LocalDateTime now = LocalDateTime.now();

		Experience newExp = new Experience();
		newExp.setCreatedBy(fullname);
		newExp.setName(name);
		newExp.setStatus(status);
		newExp.setType(type);
		newExp.setScheduleStart(now);
		newExp.setOrgId(org_Id);
		newExp.setModBy(fullname);
		newExp.setCreatedTime(now);
		newExp.setUserid(user_id);
		newExp = expService.saveExperience(newExp);

		exp_id = newExp.getId();
		return exp_id;
	}

	public int savePopup() {
		return 0;
	}

	// Return Experience ID after storing values in to Exp table
	@Transactional(rollbackFor = DbInsertException.class)
	public ModelAndView savePopupExp(PopupExpCreateFormDTO popupExpCreateFormDTO)
			throws JsonMappingException, JsonProcessingException, DbInsertException {
		ModelAndView modelAndView = new ModelAndView();
		String exp_name = popupExpCreateFormDTO.getName();
		String type = popupExpCreateFormDTO.getType();
		String status = "on";
		int user_id = (int) session.getAttribute("user_id");
		int org_id = (int) session.getAttribute("org_id");
		boolean expExists;
		try {
			expExists = expService.expExists(org_id, exp_name);
			if (expExists) {
				session.setAttribute("message", expCreateSetErrorMessage(exp_name));
				modelAndView.addObject("expExists", expExists);
			} else {
				expExists = false;
				int exp_id = saveExperience(exp_name, type, status, user_id);
				savePopupContentsAndAttributes(popupExpCreateFormDTO, exp_id);
				session.setAttribute("message", expCreateSetSuccessMessage(exp_name));
				modelAndView.addObject("exp_id", exp_id);
				modelAndView.addObject("expExists", expExists);
			}
		} catch (Exception e) {
			/*
			 * expExists = true; modelAndView.addObject("error", "true");
			 * session.setAttribute(
			 * "message","Unresolved Error: Please contact administrator");
			 */
			throw new DbInsertException("Exception is thrown");
		}
		return modelAndView;
	}

	/*
	 * Saving Popup values into content & Popup tables
	 * @param PopupExpCreateFormDTO
	 * @param exp_id
	 */

	public void savePopupContentsAndAttributes(PopupExpCreateFormDTO popupExpCreateFormDTO, int exp_id)
			throws JsonMappingException, JsonProcessingException, DbInsertException {
		List<Popup> popup_entities = new ArrayList<Popup>();
		List<Content> content_entities = new ArrayList<Content>();
		PopupAttributes newPopAttr = new PopupAttributes();
			
		String experienceDetails = popupExpCreateFormDTO.getExperienceDetails();
		String events = popupExpCreateFormDTO.getPage_events();
		String cookie = popupExpCreateFormDTO.getPopup_cookie();
		String delay = popupExpCreateFormDTO.getPopup_delay();
		
		newPopAttr.setExperience_id(exp_id);
		newPopAttr.setEvents(events);
		newPopAttr.setCookie(cookie);
		newPopAttr.setDelay(delay);
		expService.savePopupAttributes(newPopAttr);
		
		ObjectMapper mapper = new ObjectMapper();
		Map<String, LinkedHashMap> map = mapper.readValue(experienceDetails, Map.class);
		for (Entry<String, LinkedHashMap> entry : map.entrySet()) {
			int segment_id = Integer.parseInt(entry.getKey());
			//int segment_id = 1;
			LinkedHashMap<?, ?> seg_data = entry.getValue();
			Popup newPopupModel = new Popup();
			Content newContentModel = new Content();

			newPopupModel.setExperienceId(exp_id);
			newPopupModel.setSegmentId(segment_id);
			newPopupModel.setType(seg_data.get("popup_type").toString());
			newPopupModel.setHtmlContent(seg_data.get("popup_html").toString());
			newPopupModel.setUrl(seg_data.get("popup_url").toString());
			newPopupModel.setWidth(seg_data.get("width").toString());
			newPopupModel.setHeight(seg_data.get("height").toString());
			newPopupModel.setTextColor(seg_data.get("bg_color_txt").toString());
			newPopupModel.setBgColor(seg_data.get("bg_color").toString());
			newPopupModel.setBgImageUrl(seg_data.get("bg_img_url").toString());
			popup_entities.add(newPopupModel);

			newContentModel.setExperience_id(exp_id);
			newContentModel.setSegment_id(segment_id);
			newContentModel.setContent(seg_data.get("popup_body").toString());
			newContentModel.setCreate_time(LocalDateTime.now());
			content_entities.add(newContentModel);
		}
		// batch insert
		expService.saveAllPopupEntites(popup_entities);
		expService.saveAllContentEntites(content_entities);
	}

	public String expCreateSetErrorMessage(String exp_name) {
		String message = "Error: Experience with name <b>" + exp_name + "</b> is already exist";
		return message;
	}

	public String expCreateSetSuccessMessage(String exp_name) {
		String message = "Experience <b>" + exp_name
				+ "</b> saved. You can now configure the pages for this experience";
		return message;
	}

	public String getFullName(String firstname, String lastname) {
		String fullname = firstname + " " + lastname;
		return fullname;
	}
	
	
	@Transactional(rollbackFor = DbInsertException.class)
	public ModelAndView saveBarExp(BarExpCreateFormDTO barExpCreateFormDTO) throws JsonMappingException, JsonProcessingException , DbInsertException{
		
		ModelAndView modelAndView = new ModelAndView();
		String exp_name = barExpCreateFormDTO.getName();
		String type = barExpCreateFormDTO.getType();
		String status = "on";
		int user_id = (int) session.getAttribute("user_id");
		int org_id = (int) session.getAttribute("org_id");
		boolean expExists;
		try {
			expExists = expService.expExists(org_id, exp_name);
			if (expExists) {
				session.setAttribute("message", expCreateSetErrorMessage(exp_name));
				modelAndView.addObject("expExists", expExists);
			} else {
				expExists = false;
				int exp_id = saveExperience(exp_name, type, status, user_id);
				saveBarsAndContents(barExpCreateFormDTO, exp_id);
				session.setAttribute("message", expCreateSetSuccessMessage(exp_name));
				modelAndView.addObject("exp_id", exp_id);
				modelAndView.addObject("expExists", expExists);
				
			}
		} catch (Exception e) {
			session.setAttribute("exp_type",type);
			throw new DbInsertException("Exception is thrown");
		}
		return modelAndView;
	}
	
	public void saveBarsAndContents(BarExpCreateFormDTO barExpCreateFormDTO, int exp_id)
			throws JsonMappingException, JsonProcessingException, DbInsertException {
		
		List<Bar> bar_entities = new ArrayList<Bar>();
		List<Content> content_entities = new ArrayList<Content>();
		System.out.println("coming");
		String experienceDetails = barExpCreateFormDTO.getExperienceDetails();
		ObjectMapper mapper = new ObjectMapper();
		Map<String, LinkedHashMap> map = mapper.readValue(experienceDetails, Map.class);
		for (Entry<String, LinkedHashMap> entry : map.entrySet()) {
			int segment_id = Integer.parseInt(entry.getKey());
			//int segment_id = 1;
			LinkedHashMap<?, ?> seg_data = entry.getValue();
			Bar newBarModel = new Bar();
			Content newContentModel = new Content();

			
			  newBarModel.setExperienceId(exp_id);
			  newBarModel.setSegmentId(segment_id);
			  newBarModel.setBarAlign(seg_data.get("screen").toString());
			  newBarModel.setBarBgColor(seg_data.get("bar_bgcolor").toString());
			  newBarModel.setBarText(seg_data.get("bar_txt").toString());
			  newBarModel.setBarTextColor(seg_data.get("bar_text_col").toString());
			  newBarModel.setButton(seg_data.get("Not_button").toString());
			  newBarModel.setButtonBgColor(seg_data.get("button_back_col").toString());
			  newBarModel.setButtonText(seg_data.get("button_txt").toString());
			  newBarModel.setButtonTextColor(seg_data.get("button_text_col").toString());
			  newBarModel.setLinkUrl(seg_data.get("link_val").toString());
			  newBarModel.setTargetLink(seg_data.get("anchorTarget").toString());;
			  bar_entities.add(newBarModel);

			  newContentModel.setExperience_id(exp_id);
			  newContentModel.setSegment_id(segment_id);
			  newContentModel.setContent(seg_data.get("bar_body").toString());
			  newContentModel.setCreate_time(LocalDateTime.now());
			  content_entities.add(newContentModel);

		}
		// batch insert
		 expService.saveAllBarEntites(bar_entities); 
		 expService.saveAllContentEntites(content_entities);
	}
	
	@Transactional(rollbackFor = DbInsertException.class)
	public ModelAndView saveimageEXP(ImageExpCreateFormDTO imgExpCreateFormDTO) throws JsonMappingException, JsonProcessingException,DbInsertException {
		ModelAndView modelAndView = new ModelAndView();
		String exp_name = imgExpCreateFormDTO.getName();
		String type = imgExpCreateFormDTO.getType();
		String status = "on";
		int user_id = (int) session.getAttribute("user_id");
		int org_id = (int) session.getAttribute("org_id");
		Date date = new Date(System.currentTimeMillis());
		boolean expExists = expService.expExists(org_id, exp_name);
		
		try {
			expExists = expService.expExists(org_id, exp_name);
			if (expExists) {
				session.setAttribute("message", expCreateSetErrorMessage(exp_name));
				modelAndView.addObject("expExists", expExists);
				//modelAndView.setViewName("index.jsp?view=pages/experience-create-image");
			} else {
				expExists = false;
				int exp_id = saveExperience(exp_name, type, status, user_id);
				String experienceDetails = imgExpCreateFormDTO.getExperienceDetails();
				ObjectMapper mapper = new ObjectMapper();
				Map<String, String> map = mapper.readValue(experienceDetails, Map.class);
				System.out.println(map);
				for (Map.Entry<String, String> entry : map.entrySet()) {
					int segment_id = Integer.parseInt(entry.getKey());
					String urlvalue = entry.getValue();
					Image image = new Image();
					image.setExperience_id(exp_id);
					image.setSegment_id(segment_id);
					image.setCreate_time(date);
					image.setUrl(urlvalue);
					expService.saveimage(image);
				}
				session.setAttribute("message", expCreateSetSuccessMessage(exp_name));
				modelAndView.addObject("exp_id", exp_id);
				modelAndView.addObject("expExists", expExists);
			}
		} catch (Exception e) {
			/*
			 * expExists = true; modelAndView.addObject("error", "true");
			 * session.setAttribute(
			 * "message","Unresolved Error: Please contact administrator");
			 */
			throw new DbInsertException("Exception is thrown");
		}
		
				return modelAndView;
	}
	
	
	
	@Transactional(rollbackFor = DbInsertException.class)
	public ModelAndView saveStyleExp(StyleExpCreateFormDTO styelExpCreateFormDTO) throws JsonMappingException, JsonProcessingException,DbInsertException {
		ModelAndView modelAndView = new ModelAndView();
		String exp_name = styelExpCreateFormDTO.getName();
		String type = styelExpCreateFormDTO.getType();
		String status = "on";
		int user_id = (int) session.getAttribute("user_id");
		int org_id = (int) session.getAttribute("org_id");
		Date date = new Date(System.currentTimeMillis());
		try {
		boolean expExists = expService.expExists(org_id, exp_name);
		if (expExists) {
			session.setAttribute("message", expCreateSetErrorMessage(exp_name));
			modelAndView.addObject("expExists", expExists);
			modelAndView.setViewName("index.jsp?view=pages/experience-create-style");
		} else {
			expExists = false;
			int exp_id = saveExperience(exp_name, type, status, user_id);
			String experienceDetails = styelExpCreateFormDTO.getExperienceDetails();
			ObjectMapper mapper = new ObjectMapper();
			Map<String, String> map = mapper.readValue(experienceDetails, Map.class);
			System.out.println(map);
			for (Map.Entry<String, String> entry : map.entrySet()) {
				int segment_id = Integer.parseInt(entry.getKey());
				String contentvalue = entry.getValue();
				Style style = new Style();
				style.setExperience_id(exp_id);
				style.setSegment_id(segment_id);
				style.setCsslink(contentvalue.split("#")[0]);
				style.setAllsubpage(contentvalue.split("#")[1]);
				expService.savestyle(style);
			}
			session.setAttribute("message", expCreateSetSuccessMessage(exp_name));
			modelAndView.addObject("exp_id", exp_id);
			modelAndView.addObject("expExists", expExists);
		}
		}
		catch (Exception e) {
			/*
			 * expExists = true; modelAndView.addObject("error", "true");
			 * session.setAttribute(
			 * "message","Unresolved Error: Please contact administrator");
			 */
			throw new DbInsertException("Exception is thrown");
		}
						//modelAndView.setViewName("index.jsp?view=pages/experience-create-enable");
		 
			//session.setAttribute("message", "Experience <b>"+exp_name+"</b> saved. You can now configure the pages for this experience");
			//modelAndView.addObject("exp_id", exp_id);
		
		return modelAndView;
	}


@Transactional(rollbackFor = DbInsertException.class)
public ModelAndView savecontentEXP(ImageExpCreateFormDTO imgExpCreateFormDTO) throws JsonMappingException, JsonProcessingException,DbInsertException {
	ModelAndView modelAndView = new ModelAndView();
	String exp_name = imgExpCreateFormDTO.getName();
	String type = imgExpCreateFormDTO.getType();
	String status = "on";
	int user_id = (int) session.getAttribute("user_id");
	int org_id = (int) session.getAttribute("org_id");
	Date date = new Date(System.currentTimeMillis());
	boolean expExists = expService.expExists(org_id, exp_name);
	
	try {
		expExists = expService.expExists(org_id, exp_name);
		if (expExists) {
			session.setAttribute("message", expCreateSetErrorMessage(exp_name));
			modelAndView.addObject("expExists", expExists);
			//modelAndView.setViewName("index.jsp?view=pages/experience-create-image");
		} else {
			expExists = false;
			int exp_id = saveExperience(exp_name, type, status, user_id);
			String experienceDetails = imgExpCreateFormDTO.getExperienceDetails();
			ObjectMapper mapper = new ObjectMapper();
			Map<String, String> map = mapper.readValue(experienceDetails, Map.class);
			System.out.println(map);
			for (Map.Entry<String, String> entry : map.entrySet()) {
				int segment_id = Integer.parseInt(entry.getKey());
				String urlvalue = entry.getValue();
				Content content = new Content();
				content.setExperience_id(exp_id);
				content.setSegment_id(segment_id);
				content.setContent(urlvalue);
				content.setCreate_time(LocalDateTime.now());
				expService.savecontent(content);
			}
			session.setAttribute("message", expCreateSetSuccessMessage(exp_name));
			modelAndView.addObject("exp_id", exp_id);
			modelAndView.addObject("expExists", expExists);
		}
	} catch (Exception e) {
		/*
		 * expExists = true; modelAndView.addObject("error", "true");
		 * session.setAttribute(
		 * "message","Unresolved Error: Please contact administrator");
		 */
		throw new DbInsertException("Exception is thrown");
	}
	
			return modelAndView;
}
	
	/*
	 * Saving Link values into content & Link tables
	 * @param LinkExpCreateFormDTO
	 * @param exp_id
	 */


	@Transactional(rollbackFor = DbInsertException.class)
	public ModelAndView saveLinkExp(LinkExpCreateFormDTO linkExCreateFormDTO) throws DbInsertException {
		ModelAndView modelAndView = new ModelAndView();
		String exp_name = linkExCreateFormDTO.getName();
		String type = linkExCreateFormDTO.getType();
		String status = "on";
		int user_id = (int) session.getAttribute("user_id");
		int org_id = (int) session.getAttribute("org_id");
		boolean expExists;
		try {
			expExists = expService.expExists(org_id, exp_name);
			if (expExists) {
				session.setAttribute("message", expCreateSetErrorMessage(exp_name));
				modelAndView.addObject("expExists", expExists);
			} else {
				expExists = false;
				int exp_id = saveExperience(exp_name, type, status, user_id);
				saveLinkContents(linkExCreateFormDTO, exp_id);
				session.setAttribute("message", expCreateSetSuccessMessage(exp_name));
				modelAndView.addObject("exp_id", exp_id);
				modelAndView.addObject("expExists", expExists);
			}
		} catch (Exception e) {
			/*
			 * expExists = true; modelAndView.addObject("error", "true");
			 * session.setAttribute(
			 * "message","Unresolved Error: Please contact administrator");
			 */
			e.printStackTrace();
			throw new DbInsertException("Exception is thrown");
		}
		return modelAndView;
	}
	
	/*
	 * Saving Popup values into content & Popup tables
	 * @param PopupExpCreateFormDTO
	 * @param exp_id
	 */

	public void saveLinkContents(LinkExpCreateFormDTO linkExpCreateFormDTO, int exp_id)
			throws JsonMappingException, JsonProcessingException, DbInsertException {
		List<Link> link_entities = new ArrayList<Link>();	
		List<Content> content_entities = new ArrayList<Content>();
		String experienceDetails = linkExpCreateFormDTO.getExperienceDetails();
		
		ObjectMapper mapper = new ObjectMapper();
		Map<String, LinkedHashMap> map = mapper.readValue(experienceDetails, Map.class);
		for (Entry<String, LinkedHashMap> entry : map.entrySet()) {
			int segment_id = Integer.parseInt(entry.getKey());
			//int segment_id = 1;
			LinkedHashMap<?, ?> seg_data = entry.getValue();
			Link newLinkModel = new Link();
			Content newContentModel = new Content();
			
			newLinkModel.setExperienceId(exp_id);
			newLinkModel.setSegmentId(segment_id);

			newLinkModel.setType(seg_data.get("typeVal").toString());
			newLinkModel.setText(seg_data.get("linkText").toString());
			newLinkModel.setTargeturl(seg_data.get("targetUrl").toString());
			newLinkModel.setImageurl(seg_data.get("imageUrl").toString());
			newLinkModel.setClassname(seg_data.get("anchorClassName").toString());
			newLinkModel.setPagetarget(seg_data.get("anchorTarget").toString());
			newLinkModel.setWidth(seg_data.get("imgWidth").toString());
			newLinkModel.setHeight(seg_data.get("imgHeight").toString());
			newLinkModel.setAlttext(seg_data.get("imagelinktext").toString());
			link_entities.add(newLinkModel);
			
			newContentModel.setExperience_id(exp_id);
			newContentModel.setSegment_id(segment_id);
			newContentModel.setContent(seg_data.get("link_html_body").toString());
			newContentModel.setCreate_time(LocalDateTime.now());
			content_entities.add(newContentModel);
		}
		// batch insert
		expService.saveAllLinkEntites(link_entities);
		expService.saveAllContentEntites(content_entities);
	}
}
