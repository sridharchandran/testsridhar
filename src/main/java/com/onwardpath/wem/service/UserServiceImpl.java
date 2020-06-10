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
	
    private UserRepository userRepository;
    private OrgRepository orgRepository;
    private BCryptPasswordEncoder bCryptPasswordEncoder;
    
    @Autowired
    public UserServiceImpl(UserRepository userRepository,
    				   OrgRepository orgRepository,
                       BCryptPasswordEncoder bCryptPasswordEncoder) {
        this.userRepository = userRepository;
        this.orgRepository = orgRepository;
        this.bCryptPasswordEncoder = bCryptPasswordEncoder;
    }
	

	@Override
	public User findByEmail(String email) {
		// TODO Auto-generated method stub
		return userRepository.findByEmail(email);
	}

	@Override
	public User findUserByUserName(String userName) {
		return userRepository.findByUserName(userName);
	}

	@Override
	public User saveUser(User user) {
	    user.setPassword(bCryptPasswordEncoder.encode(user.getPassword()));
		return userRepository.save(user);
	}

	@Override
	public Organization findOrgIDByDomain(String domain) {
		return orgRepository.findByDomain(domain);
	}

	@Override
	public Organization saveOrg(Organization org) {
		return orgRepository.save(org);
	}

}
