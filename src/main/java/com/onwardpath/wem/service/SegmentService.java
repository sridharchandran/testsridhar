package com.onwardpath.wem.service;

import java.util.List;
import com.onwardpath.wem.projections.SegmentNames;

public interface SegmentService {
	public List<SegmentNames> getSegmentNamesByOrgId(int orgId);
}
