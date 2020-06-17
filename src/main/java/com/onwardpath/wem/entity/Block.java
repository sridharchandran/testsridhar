package com.onwardpath.wem.entity;

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
    private int id;
	private int experience_id;
	private int segment_id;
	private String block_url;
	private String allsubpage;
	
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
	public String getBlock_url() {
		return block_url;
	}
	public void setBlock_url(String block_url) {
		this.block_url = block_url;
	}
	public String getAllsubpage() {
		return allsubpage;
	}
	public void setAllsubpage(String allsubpage) {
		this.allsubpage = allsubpage;
	}
	

}
