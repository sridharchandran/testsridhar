package com.onwardpath.wem.controller;

import java.io.IOException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.core.JsonGenerationException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.onwardpath.wem.model.SegmentCreateFormDTO;
import com.onwardpath.wem.repository.NativeRepository;
import com.onwardpath.wem.service.NativeService;

@Controller
public class SegmentController {
	
	@Autowired
	private NativeRepository nr;
	
	@Autowired
	SegmentControllerImpl segcontimpl;
	
	@Autowired
	NativeService nativeService;
	
	
	 @GetMapping("/segment_create")
	    public String profile_setting()
	    {
	    	
	    	return "/index.jsp?view=pages/segment-create";
	    }
	
	// Endpoint to load city/state/country
		@GetMapping("/AjaxController")
		@ResponseBody
		public String segmentCreate(@RequestParam("service") String service,@RequestParam("geoloc") String geoloc) throws JsonGenerationException, JsonMappingException, IOException {
			
			System.out.println("service="+service+""+"geoloca="+geoloc);
			String jsonString = "";
			if (!service.isEmpty() && service != null) {

				if (service.contains("_suggestions")) {
					
					String selectionValues = service.equals("city_suggestions") ? "city"
							: service.equals("state_suggestions") ? "state" : "country";
					String geolocs = geoloc;
					jsonString = nativeService.SuggestionListValues(geolocs, selectionValues);
					
				}
			}
			return jsonString;
		}

		@PostMapping("/Segment_Save")
		@ResponseBody
		public ModelAndView segmentSave(SegmentCreateFormDTO segmentCreateFormDTO)throws IOException {
		
			
			ModelAndView modelAndView = segcontimpl.saveSegment(segmentCreateFormDTO);
			modelAndView.setViewName("index.jsp?view=pages/segment-create");
			return modelAndView;
			
		}

}
