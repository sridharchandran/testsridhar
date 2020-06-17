package com.onwardpath.wem.service;

import java.net.MalformedURLException;

import com.onwardpath.wem.entity.Analytics;

public interface AnalyticsService {
	Analytics findById(int id);
	public int registerWebsite(String orgName, String domainURL);
	public String getRootDomain(String domainURL) throws MalformedURLException;
	public int getRowIdbyRootDomain(String root_domain);
}
