package com.onwardpath.wem.service;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.management.relation.Role;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.onwardpath.wem.entity.User;

@Service
public class UserDetailsServiceImpl implements UserDetailsService {
	
	 @Autowired
	 private UserService userService;

	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		User user = userService.findUserByUserName(username);
	    return buildUserForAuthentication(user);
	}
	
	/*
	 * private List<GrantedAuthority> getUserAuthority(Set<Role> userRoles) {
	 * 
	 * Set<GrantedAuthority> roles = new HashSet<GrantedAuthority>(); for (Role
	 * role: userRoles) { roles.add(new SimpleGrantedAuthority(role.getRole())); }
	 * List<GrantedAuthority> grantedAuthorities = new ArrayList<>(roles); return
	 * grantedAuthorities; }
	 */


	private UserDetails buildUserForAuthentication(User user) {
		List<GrantedAuthority> authorities = new ArrayList<GrantedAuthority>();
		authorities.add(new SimpleGrantedAuthority("ADMIN"));
   	 return new org.springframework.security.core.userdetails.User(user.getUserName(), user.getPassword(), authorities);
	}

}
