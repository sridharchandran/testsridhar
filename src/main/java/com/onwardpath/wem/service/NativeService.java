package com.onwardpath.wem.service;

import java.io.IOException;

import com.fasterxml.jackson.core.JsonGenerationException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.onwardpath.wem.model.ExperienceViewPostDTO;

public interface NativeService {

	
	public String getResultSetforExpView(int id, int offset, int limit, String search);
	public String getResultSetforExpViewPost(ExperienceViewPostDTO experienceViewPostDTO);
	public String SuggestionListValues(String startsWith, String filterBy) throws JsonGenerationException, JsonMappingException, IOException;
}
