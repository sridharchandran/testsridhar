package com.onwardpath.wem.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.onwardpath.wem.entity.User;
import com.onwardpath.wem.repository.UserRepository;

@Service
public class UserServiceImpl implements UserService {
	
	@Autowired
	UserRepository userRepository;

	@Override
	public User findByEmail(String email) {
		// TODO Auto-generated method stub
		return userRepository.findByEmail(email);
	}

}
