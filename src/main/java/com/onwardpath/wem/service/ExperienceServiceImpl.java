package com.onwardpath.wem.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.onwardpath.wem.entity.Config;
import com.onwardpath.wem.entity.Content;
import com.onwardpath.wem.entity.Experience;
import com.onwardpath.wem.entity.Image;
import com.onwardpath.wem.entity.Segment;
import com.onwardpath.wem.entity.Style;
import com.onwardpath.wem.entity.TimeZone;
import com.onwardpath.wem.repository.ConfigRepository;
import com.onwardpath.wem.repository.ContentRepository;
import com.onwardpath.wem.repository.ExperienceRepository;
import com.onwardpath.wem.repository.ImageRepository;
import com.onwardpath.wem.repository.SegmentRepository;
import com.onwardpath.wem.repository.StyleRepository;
import com.onwardpath.wem.repository.TimeZoneRepository;

@Service
public class ExperienceServiceImpl implements  ExperienceService {

	@Autowired
	SegmentRepository sepRepos;
	
	
	@Autowired
	ExperienceRepository expRepos;
	
	
	@Autowired
	ContentRepository conRepos;
	
	 
	@Autowired
	ConfigRepository configRepos;
	
	 
	@Autowired
	TimeZoneRepository timezoneRepos;
	
	@Autowired
	ImageRepository imageRepos;
	
	
	@Autowired
	StyleRepository styleRepos;
	
	
	public List<Segment> findSegmentByOrgId(int orgId) {
		return sepRepos.getSegmentByCustomQuery(orgId);
		
	}
	
	
	public List<TimeZone> gettimezone() {
		return timezoneRepos.findAll();
		
	}

	@Override
	public Experience saveExperience(Experience exp) {
		return expRepos.save(exp);
			
	}


	@Override
	public Content savecontent(Content con) {
		// TODO Auto-generated method stub
		return conRepos.save(con);
	}


	@Override
	public Config saveconfig(Config config) {
		// TODO Auto-generated method stub
		return configRepos.save(config);
	}


	@Override
	public boolean expExists(int orgId, String exp_name) {
		return expRepos.findByOrgIdAndName(orgId, exp_name) != null;
	}
	
	 
	@Override
	public Image saveimage(Image con) {
		// TODO Auto-generated method stub
		return imageRepos.save(con);
	}


	@Override
	public Style savestyle(Style style) {
		// TODO Auto-generated method stub
		return styleRepos.save(style);
	}
	
}
