package com.onwardpath.wem.service;

import com.onwardpath.wem.entity.User;

public interface UserService {
	
	public User findByEmail(String email);
	
}

