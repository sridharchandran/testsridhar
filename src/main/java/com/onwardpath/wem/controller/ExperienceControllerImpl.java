package com.onwardpath.wem.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import com.onwardpath.wem.projections.SegmentNames;
import com.onwardpath.wem.repository.SegmentRepository;
import com.onwardpath.wem.service.SegmentService;

@Service
public class ExperienceControllerImpl {


	private SegmentService segmentService;
	
	@Autowired
	public ExperienceControllerImpl(SegmentService segmentService) {
		this.segmentService = segmentService;
	}
	
	public List<SegmentNames> getSegmentNames(int orgId)
	{
		return segmentService.getSegmentNamesByOrgId(orgId);
	}
	
	public ModelAndView validateAndGetSegmentList(HttpSession session)
	{
		int orgId = Integer.parseInt(session.getAttribute("org_id").toString());
		List<SegmentNames> seglist= getSegmentNames(orgId);
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("seglist", seglist);
		if (seglist.size() == 0) {
			String message = "Error: No Segments are configured. Create a Segment <a class='kt-link kt-font-bold' href='?view=pages/segment-create-geo.jsp'>here</a>";
			session.setAttribute("message", message);
		}
		return modelAndView;
	}
		
}
