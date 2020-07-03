package com.onwardpath.wem.entity;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonFormat;

@Entity
@Table(name = "content")

public class Content {

	@Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	
	@Column(name = "experience_id")
	private int experience_id;
	
	@Column(name = "segment_id")
	private int segment_id;
	
	private String content;
	
	@JsonFormat(pattern="yyyy-MM-dd HH:mm:ss")
	@Column(name = "create_time")
	private String create_time;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getExperience_id() {
		return experience_id;
	}

	public void setExperience_id(int experience_id) {
		this.experience_id = experience_id;
	}

	public int getSegment_id() {
		return segment_id;
	}

	public void setSegment_id(int segment_id) {
		this.segment_id = segment_id;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getCreate_time() {
		return create_time;
	}

	public void setCreate_time(String create_time) {
		this.create_time = create_time;
	}

	
	
	
}
