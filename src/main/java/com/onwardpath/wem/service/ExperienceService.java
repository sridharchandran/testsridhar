package com.onwardpath.wem.service;



import com.onwardpath.wem.entity.Config;
import com.onwardpath.wem.entity.Content;
import com.onwardpath.wem.entity.Experience;
import com.onwardpath.wem.repository.ExperienceRepository;


public interface  ExperienceService {
	public static final ExperienceRepository expRepos = null;
	public Experience saveExperience(Experience exp);
    public Content  savecontent(Content con);
    public Config  saveconfig(Config config);
    public boolean expExists(int orgId, String exp_name);
}
