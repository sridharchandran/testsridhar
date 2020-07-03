package com.onwardpath.wem.entity;



import java.sql.Date;
import java.time.LocalDateTime;
import java.time.LocalTime;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonFormat;

@Entity
@Table(name = "experience")

public class Experience {
	
	@Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	
	private String name;
	
	private String type;
	
	private String status;
	
	@Column(name = "schedule_start")
	private LocalDateTime scheduleStart; 
	
	@Column(name = "schedule_end")
	private Date scheduleEnd;
	
	@Column(name = "org_id")
	private int orgId;	
	
	@Column(name = "created_by")
	private String createdBy;
	
	@JsonFormat(pattern="yyyy-MM-dd HH:mm:ss")
	@Column(name = "created_time")
	private LocalDateTime createdTime;
	
	@Column(name = "timezone_id")
	private String timezoneId;
	
	@Column(name = "mod_by")
	private String modBy;
    
    @JsonFormat(pattern="yyyy-MM-dd HH:mm:ss")
    @Column(name = "mod_time")
    private Date modTime;
    
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

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public LocalDateTime getScheduleStart() {
		return scheduleStart;
	}

	public void setScheduleStart(LocalDateTime now) {
		this.scheduleStart = now;
	}

	public Date getScheduleEnd() {
		return scheduleEnd;
	}

	public void setScheduleEnd(Date scheduleEnd) {
		this.scheduleEnd = scheduleEnd;
	}

	public int getOrgId() {
		return orgId;
	}

	public void setOrgId(int orgId) {
		this.orgId = orgId;
	}

	public String getCreatedBy() {
		return createdBy;
	}

	public void setCreatedBy(String createdBy) {
		this.createdBy = createdBy;
	}

	public LocalDateTime getCreatedTime() {
		return createdTime;
	}

	public void setCreatedTime(LocalDateTime localDateTime) {
		this.createdTime = localDateTime;
	}

	public String getTimezoneId() {
		return timezoneId;
	}

	public void setTimezoneId(String timezoneId) {
		this.timezoneId = timezoneId;
	}

	public String getModBy() {
		return modBy;
	}

	public void setModBy(String modBy) {
		this.modBy = modBy;
	}

	public Date getModTime() {
		return modTime;
	}

	public void setModTime(Date modTime) {
		this.modTime = modTime;
	}

	public int getUserid() {
		return userid;
	}

	public void setUserid(int userid) {
		this.userid = userid;
	}

	
    
}
