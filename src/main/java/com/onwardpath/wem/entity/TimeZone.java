package com.onwardpath.wem.entity;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="timezone")
public class TimeZone {

	@Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;
	private String zone_id;
	private String displayname;	
	private String utcoffset;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getZone_id() {
		return zone_id;
	}
	public void setZone_id(String zone_id) {
		this.zone_id = zone_id;
	}
	public String getDisplayname() {
		return displayname;
	}
	public void setDisplayname(String displayname) {
		this.displayname = displayname;
	}
	public String getUtcoffset() {
		return utcoffset;
	}
	public void setUtcoffset(String utcoffset) {
		this.utcoffset = utcoffset;
	}
	
}
