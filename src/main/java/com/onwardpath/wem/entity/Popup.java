package com.onwardpath.wem.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="popup")
public class Popup {
	
	@Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
	
	@Column(name = "id")
    private int id;
	
	@Column(name = "experience_id")
	private int experienceId;
	
	@Column(name = "segment_id")
	private int segmentId;
	
	@Column(name = "type")
	private String type;
	
	@Column(name = "html_content")
	private String htmlContent;
	
	@Column(name = "url")
	private String url;
	
	@Column(name = "width")
	private String width;
	
	@Column(name = "height")
	private String height;
	
	@Column(name = "text_color")
	private String textColor;
	
	@Column(name = "bg_color")
	private String bgColor;
	
	@Column(name = "bg_image_url")
	private String bgImageUrl;

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

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getHtmlContent() {
		return htmlContent;
	}

	public void setHtmlContent(String htmlContent) {
		this.htmlContent = htmlContent;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public String getWidth() {
		return width;
	}

	public void setWidth(String width) {
		this.width = width;
	}

	public String getHeight() {
		return height;
	}

	public void setHeight(String height) {
		this.height = height;
	}

	public String getTextColor() {
		return textColor;
	}

	public void setTextColor(String textColor) {
		this.textColor = textColor;
	}

	public String getBgColor() {
		return bgColor;
	}

	public void setBgColor(String bgColor) {
		this.bgColor = bgColor;
	}

	public String getBgImageUrl() {
		return bgImageUrl;
	}

	public void setBgImageUrl(String bgImageUrl) {
		this.bgImageUrl = bgImageUrl;
	}
	
	

}
