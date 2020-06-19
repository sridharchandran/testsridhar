package com.onwardpath.wem.model;

import java.util.Date;

public class ExperienceViewDTO {
	
	private int expId;
	
	private String expName;
	
	private String expType;
	
	private String expStatus;
	
	private Date createTime;
	
	private String Name;
	
		
	private String segmentName;

	public int getExpId() {
		return expId;
	}

	public void setExpId(int expId) {
		this.expId = expId;
	}

	public String getExpName() {
		return expName;
	}

	public void setExpName(String expName) {
		this.expName = expName;
	}

	public String getExpType() {
		return expType;
	}

	public void setExpType(String expType) {
		this.expType = expType;
	}

	public String getExpStatus() {
		return expStatus;
	}

	public void setExpStatus(String expStatus) {
		this.expStatus = expStatus;
	}

	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	public String getName() {
		return Name;
	}

	public void setName(String Name) {
		this.Name = Name;
	}

	

	public String getSegmentName() {
		return segmentName;
	}

	public void setSegmentName(String segmentName) {
		this.segmentName = segmentName;
	}
	
	
	
	

}
