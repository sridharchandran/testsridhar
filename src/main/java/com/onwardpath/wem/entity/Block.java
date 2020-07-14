package com.onwardpath.wem.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="block")
public class Block {
		
	@Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "id")
    private int id;
	
	@Column(name = "experience_id")
	private int experienceId;
	
	@Column(name = "segment_id")
	private int segmentId;
	
	@Column(name = "block_url")
	private String blockUrl;
	
	@Column(name = "allsubpage")
	private String allSubPage;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getExperienceId() {
		return experienceId;
	}
	public void setExperienceId(int experienceId) {
		this.experienceId = experienceId;
	}
	public int getSegmentId() {
		return segmentId;
	}
	public void setSegmentId(int segmentId) {
		this.segmentId = segmentId;
	}
	public String getBlockUrl() {
		return blockUrl;
	}
	public void setBlockUrl(String blockUrl) {
		this.blockUrl = blockUrl;
	}
	public String getAllSubPage() {
		return allSubPage;
	}
	public void setAllSubPage(String allSubPage) {
		this.allSubPage = allSubPage;
	}
	
	
	

}
