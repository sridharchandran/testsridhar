package com.onwardpath.wem.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="bar")
public class Bar {
	 
	@Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "id")
    private int id;
	
	@Column(name = "experience_id")
	private int experienceId;
	
	@Column(name = "segment_id")
	private int segmentId;
	
	@Column(name = "bar_align")
	private String barAlign;

	@Column(name = "bar_bg_color")
	private String barBgColor;
	
	@Column(name = "bar_text_color")
	private String barTextColor;
	
	@Column(name = "bar_text")
	private String barText;
	
	@Column(name = "button")
	private String button;
	
	@Column(name = "button_bg_color")
	private String buttonBgColor;
	
	@Column(name = "button_text_color")
	private String buttonTextColor;
	
	@Column(name = "button_text")
	private String buttonText;
	
	@Column(name = "link_url")
	private String linkUrl;
	
	@Column(name = "target_link")
	private String targetLink;
	
	
	
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
	public String getBarAlign() {
		return barAlign;
	}
	public void setBarAlign(String barAlign) {
		this.barAlign = barAlign;
	}
	public String getBarBgColor() {
		return barBgColor;
	}
	public void setBarBgColor(String barBgColor) {
		this.barBgColor = barBgColor;
	}
	public String getBarTextColor() {
		return barTextColor;
	}
	public void setBarTextColor(String barTextColor) {
		this.barTextColor = barTextColor;
	}
	public String getBarText() {
		return barText;
	}
	public void setBarText(String barText) {
		this.barText = barText;
	}
	public String getButton() {
		return button;
	}
	public void setButton(String button) {
		this.button = button;
	}
	public String getButtonBgColor() {
		return buttonBgColor;
	}
	public void setButtonBgColor(String buttonBgColor) {
		this.buttonBgColor = buttonBgColor;
	}
	public String getButtonTextColor() {
		return buttonTextColor;
	}
	public void setButtonTextColor(String buttonTextColor) {
		this.buttonTextColor = buttonTextColor;
	}
	public String getButtonText() {
		return buttonText;
	}
	public void setButtonText(String buttonText) {
		this.buttonText = buttonText;
	}
	public String getLinkUrl() {
		return linkUrl;
	}
	public void setLinkUrl(String linkUrl) {
		this.linkUrl = linkUrl;
	}
	public String getTargetLink() {
		return targetLink;
	}
	public void setTargetLink(String targetLink) {
		this.targetLink = targetLink;
	}
	
	
	

}
