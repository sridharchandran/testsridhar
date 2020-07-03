package com.onwardpath.wem.entity;



import java.sql.Date;
import java.time.LocalDateTime;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonFormat;

@Entity
@Table(name = "segment")

public class Segment {

	@Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;
  
	private String name;
	
    private String rule;
    
    @Column(name = "created_by")
    private String createdBy;
    
    @Column(name = "org_id")
    private int orgId;
    
    @JsonFormat(pattern="yyyy-MM-dd HH:mm:ss")
    @Column(name = "created_time")
    private LocalDateTime createdTime;
    
    @Column(name = "mod_by")
    private String modBy;
    
    @JsonFormat(pattern="yyyy-MM-dd HH:mm:ss")
    @Column(name = "mod_time")
    private LocalDateTime modTime;
       
    private String assignedmachine;
    
    @Column(name = "user_id")
    private int userid;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getRule() {
		return rule;
	}

	public void setRule(String rule) {
		this.rule = rule;
	}

	public String getCreatedBy() {
		return createdBy;
	}

	public void setCreatedBy(String createdBy) {
		this.createdBy = createdBy;
	}

	public int getOrgId() {
		return orgId;
	}

	public void setOrgId(int orgId) {
		this.orgId = orgId;
	}

	
	public LocalDateTime getCreatedTime() {
		return createdTime;
	}

	public void setCreatedTime(LocalDateTime createdTime) {
		this.createdTime = createdTime;
	}

	public String getModBy() {
		return modBy;
	}

	public void setModBy(String modBy) {
		this.modBy = modBy;
	}

	
	public LocalDateTime getModTime() {
		return modTime;
	} 

	public void setModTime(LocalDateTime modTime) {
		this.modTime = modTime;
	}

	public String getAssignedmachine() {
		return assignedmachine;
	}

	public void setAssignedmachine(String assignedmachine) {
		this.assignedmachine = assignedmachine;
	}

	public int getUserid() {
		return userid;
	}

	public void setUserid(int userid) {
		this.userid = userid;
	}
    
    
    
}
