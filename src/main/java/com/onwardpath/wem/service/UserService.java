package com.onwardpath.wem.service;

import com.onwardpath.wem.entity.Organization;
import com.onwardpath.wem.entity.User;

public interface UserService {
	public User findByEmail(String email);
	public User findUserByUserName(String userName);
	public User saveUser(User user);
	public Organization findOrgIDByDomain(String domain);
	public Organization saveOrg(Organization org);
}

