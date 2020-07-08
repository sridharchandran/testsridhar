package com.onwardpath.wem.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.onwardpath.wem.entity.Config;
import com.onwardpath.wem.entity.Content;
import com.onwardpath.wem.entity.Experience;
import com.onwardpath.wem.entity.Image;
import com.onwardpath.wem.entity.Popup;
import com.onwardpath.wem.entity.PopupAttributes;
import com.onwardpath.wem.entity.Segment;
import com.onwardpath.wem.entity.Style;
import com.onwardpath.wem.entity.TimeZone;
import com.onwardpath.wem.repository.ConfigRepository;
import com.onwardpath.wem.repository.ContentRepository;
import com.onwardpath.wem.repository.ExperienceRepository;
import com.onwardpath.wem.repository.ImageRepository;
import com.onwardpath.wem.repository.PopupAttrRepository;
import com.onwardpath.wem.repository.PopupRepository;
import com.onwardpath.wem.repository.SegmentRepository;
import com.onwardpath.wem.repository.StyleRepository;
import com.onwardpath.wem.repository.TimeZoneRepository;

@Service
public class ExperienceServiceImpl implements  ExperienceService {
	
	private SegmentRepository sepRepos;
	private ExperienceRepository expRepos;
	private ContentRepository conRepos;
	private ConfigRepository configRepos;
	private TimeZoneRepository timezoneRepos;
	private PopupRepository popupRepos;
	private PopupAttrRepository popupAttrRepos;
	private ImageRepository imageRepos;
	private StyleRepository styleRepos;

	
	@Autowired
	public ExperienceServiceImpl(SegmentRepository sepRepos,ExperienceRepository expRepos,ContentRepository conRepos,TimeZoneRepository timezoneRepos,PopupRepository popupRepos,ConfigRepository configRepos,PopupAttrRepository popupAttrRepos,ImageRepository imageRepos,StyleRepository styleRepos)
	{
		this.sepRepos = sepRepos;
		this.expRepos  = expRepos;
		this.conRepos = conRepos;
		this.configRepos = configRepos;
		this.timezoneRepos = timezoneRepos;
		this.popupRepos = popupRepos;
		this.popupAttrRepos = popupAttrRepos;
		this.imageRepos = imageRepos;
		this.styleRepos = styleRepos;

	}
	
	
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
		return expRepos.findByOrgIdAndNameIgnoreCase(orgId, exp_name) != null;
	}


	@Override
	public Popup savePopupContents(Popup popup) {
		// TODO Auto-generated method stub
		return popupRepos.save(popup);
	}


	@Override
	public PopupAttributes savePopupAttributes(PopupAttributes popupAttributes) {
		// TODO Auto-generated method stub
		return popupAttrRepos.save(popupAttributes);
	}


	@Override
	public List<Popup> saveAllPopupEntites(List<Popup> entities) {
		// TODO Auto-generated method stub
		return popupRepos.saveAll(entities);
	}


	@Override
	public List<Content> saveAllContentEntites(List<Content> entities) {
		// TODO Auto-generated method stub
		return conRepos.saveAll(entities);
	}


	@Override
	public Experience getExperienceById(int exp_id) {
		// TODO Auto-generated method stub
		return expRepos.findById(exp_id);
	}


	@Override
	public Image saveimage(Image image) {
		// TODO Auto-generated method stub
		return imageRepos.save(image);
	}


	@Override
	public Style savestyle(Style style) {
		// TODO Auto-generated method stub
		return styleRepos.save(style);
	}
	
}
