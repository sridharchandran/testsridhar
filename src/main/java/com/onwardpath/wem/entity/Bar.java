package com.onwardpath.wem.entity;

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
    private int id;
	private int experience_id;
	private int segment_id;
	private String bar_align;
	private String bar_bg_color;
	private String bar_text_color;
	private String bar_text;
	private String button;
	private String button_bg_color;
	private String button_text_color;
	private String button_text;
	private String link_url;
	private String target_link;
	
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
	public String getBar_align() {
		return bar_align;
	}
	public void setBar_align(String bar_align) {
		this.bar_align = bar_align;
	}
	public String getBar_bg_color() {
		return bar_bg_color;
	}
	public void setBar_bg_color(String bar_bg_color) {
		this.bar_bg_color = bar_bg_color;
	}
	public String getBar_text_color() {
		return bar_text_color;
	}
	public void setBar_text_color(String bar_text_color) {
		this.bar_text_color = bar_text_color;
	}
	public String getBar_text() {
		return bar_text;
	}
	public void setBar_text(String bar_text) {
		this.bar_text = bar_text;
	}
	public String getButton() {
		return button;
	}
	public void setButton(String button) {
		this.button = button;
	}
	public String getButton_bg_color() {
		return button_bg_color;
	}
	public void setButton_bg_color(String button_bg_color) {
		this.button_bg_color = button_bg_color;
	}
	public String getButton_text_color() {
		return button_text_color;
	}
	public void setButton_text_color(String button_text_color) {
		this.button_text_color = button_text_color;
	}
	public String getButton_text() {
		return button_text;
	}
	public void setButton_text(String button_text) {
		this.button_text = button_text;
	}
	public String getLink_url() {
		return link_url;
	}
	public void setLink_url(String link_url) {
		this.link_url = link_url;
	}
	public String getTarget_link() {
		return target_link;
	}
	public void setTarget_link(String target_link) {
		this.target_link = target_link;
	}
	

}
