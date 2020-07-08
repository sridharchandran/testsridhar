package com.onwardpath.wem.controller;

import java.io.IOException;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.core.JsonGenerationException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.onwardpath.wem.model.SegmentCreateFormDTO;
import com.onwardpath.wem.model.SegmentViewDTO;
import com.onwardpath.wem.repository.NativeRepository;
import com.onwardpath.wem.service.NativeService;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;

@Controller

@Api(value = "Segment Resource", description = "shows Segment Lists")
public class SegmentController {
	
	@Autowired
	private NativeRepository nr;
	
	@Autowired
	SegmentControllerImpl segcontimpl;
	
	@Autowired
	NativeService nativeService;
	
	
	 	@GetMapping("/segment_create")
	    public String segmentCreate()
	    {
	    	
	    	return "index.jsp?view=pages/segment-create";
	    }
	
	// Endpoint to load city/state/country
	 	@ApiOperation(value = "Returns Segments List Dropdown")
		@GetMapping("/AjaxController")
		@ResponseBody
		public String segmentCreateDropdown(@RequestParam("service") String service,@RequestParam("geoloc") String geoloc) throws JsonGenerationException, JsonMappingException, IOException {
			
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
		
		@GetMapping("/segmentview")
	    public String segmentView()
	    {
	    	
	    	return "index.jsp?view=pages/segment-view";
	    }
		 
		// Endpoint for Segment custom Pagination 
		@GetMapping(value = "/segmentlist", produces = MediaType.APPLICATION_JSON_VALUE)
		@ResponseBody
		public String ajaxSegmentGETRequest(SegmentViewDTO segmentViewDTO,HttpSession session) throws IOException {
		
			return nativeService.getResultSetforSegView(segmentViewDTO,session);
		}
		
		// Endpoint for Segment Search Values
		@PostMapping(value = "/segmentlist", produces = MediaType.APPLICATION_JSON_VALUE)
		@ResponseBody
		public String ajaxSegmentPOSTRequest(SegmentViewDTO segmentViewDTO,HttpSession session) throws IOException {
		
			
			return nativeService.getResultSetforSegView(segmentViewDTO,session);
		}

}
