package com.onwardpath.wem.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.onwardpath.wem.entity.Organization;
import com.onwardpath.wem.entity.User;
import com.onwardpath.wem.repository.OrgRepository;
import com.onwardpath.wem.repository.UserRepository;

@Service
public class UserServiceImpl implements UserService {
	
	@Autowired
    private UserRepository userRepository;
	
	@Autowired
    private OrgRepository orgRepository;
    //private BCryptPasswordEncoder bCryptPasswordEncoder;
	
	public UserServiceImpl(UserRepository userRepository) {
		
		this.userRepository = userRepository;
		//this.bCryptPasswordEncoder = bCryptPasswordEncoder;
		
	}
	
	@Override
	public User findByEmail(String email) {
		// TODO Auto-generated method stub
		return userRepository.findByEmail(email);
	}

	@Override
	public User findUserByUserName(String userName) {
		// TODO Auto-generated method stub
		return userRepository.findByUserName(userName);
	}

	@Override
	public User saveUser(User user) {
		
	//	user.setPassword(bCryptPasswordEncoder.encode(user.getPassword()));
		return userRepository.save(user);
	}

	@Override
	public Organization findOrgIDByDomain(String domain) {
		return orgRepository.findByDomain(domain);
	}

	@Override
	public Organization saveOrg(Organization org) {
		// TODO Auto-generated method stub
		return orgRepository.save(org);
	}

}
