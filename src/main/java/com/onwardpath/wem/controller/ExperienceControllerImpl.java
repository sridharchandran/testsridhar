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

import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.onwardpath.wem.entity.Content;
import com.onwardpath.wem.entity.Experience;
import com.onwardpath.wem.entity.Popup;
import com.onwardpath.wem.entity.PopupAttributes;
import com.onwardpath.wem.entity.User;
import com.onwardpath.wem.exception.DbInsertException;
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
			String message = "Error: No Segments are configured. Create a Segment <a class='kt-link kt-font-bold' href='?view=pages/segment-create-geo.jsp'>here</a>";
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

}
