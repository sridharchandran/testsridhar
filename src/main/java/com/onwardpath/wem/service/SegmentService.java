package com.onwardpath.wem.service;

import java.util.List;


import com.onwardpath.wem.entity.Segment;
import com.onwardpath.wem.projections.SegmentNames;

public interface SegmentService {
	public List<SegmentNames> getSegmentNamesByOrgId(int orgId);
	
	public boolean segExists(int orgId, String exp_name);
	
	public Segment saveSegment(Segment seg);
}
