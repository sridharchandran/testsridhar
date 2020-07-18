package com.onwardpath.wem.service;

import java.util.List;


import com.onwardpath.wem.entity.Content;
import com.onwardpath.wem.model.ExperienceEditContentDTO;

public interface ExperienceEdit{
	
	 public List<ExperienceEditContentDTO> experienceContent(String id);
}
