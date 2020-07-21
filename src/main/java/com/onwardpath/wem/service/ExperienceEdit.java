package com.onwardpath.wem.service;

import java.util.List;


import com.onwardpath.wem.entity.Content;
import com.onwardpath.wem.entity.Experience;
import com.onwardpath.wem.model.ExperienceEditContentDTO;
import com.onwardpath.wem.model.SchduleExpDTO;

public interface ExperienceEdit{
	
	 public List<ExperienceEditContentDTO> experienceContent(String id);
	 //public Experience saveeditExperiencename(Experience exps,int id,String expvalue);
	 public List<ExperienceEditContentDTO> experienceImage(String id);
	 public List<SchduleExpDTO> experienceschdule(String id);

}
