package com.onwardpath.wem.model;

import java.util.Arrays;

import javax.servlet.http.Part;

import org.springframework.web.multipart.MultipartFile;

import io.swagger.annotations.ApiModel;

@ApiModel(description = "Modal to signup a new User")
public class SignupFormDTO {

	private String orgName;
	
	private String domain;
	
	private String firstName;
	
	private String lastName;
	
	private String phone;
	
	private String email;
	
	private MultipartFile photo;
	
	private String password;
	
	private String newpassword;

	public String getOrgName() {
		return orgName;
	}

	public void setOrgName(String orgName) {
		this.orgName = orgName;
	}

	public String getDomain() {
		return domain;
	}

	public void setDomain(String domain) {
		this.domain = domain;
	}

	public String getFirstName() {
		return firstName;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	public String getLastName() {
		return lastName;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public MultipartFile getPhoto() {
		return photo;
	}

	public void setPhoto(MultipartFile photo) {
		this.photo = photo;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	
	public String getNewpassword() {
		return newpassword;
	}

	public void setNewpassword(String newpassword) {
		this.newpassword = newpassword;
	}

	@Override
	public String toString() {
		return "SignupFormDTO [orgName=" + orgName + ", domain=" + domain + ", firstName=" + firstName + ", lastName="
				+ lastName + ", phone=" + phone + ", email=" + email + ", photo=" + photo + ", password=" + password
				+ ", newpassword=" + newpassword + "]";
	}

		
}
