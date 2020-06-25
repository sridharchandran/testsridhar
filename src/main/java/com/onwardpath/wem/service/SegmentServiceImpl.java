package com.onwardpath.wem.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.onwardpath.wem.projections.SegmentNames;
import com.onwardpath.wem.repository.SegmentRepository;

@Service
public class SegmentServiceImpl implements SegmentService {
	
	private SegmentRepository segmentRepository;
	
	@Autowired
	public SegmentServiceImpl(SegmentRepository segmentRepository)
	{
		this.segmentRepository = segmentRepository;
	}

	@Override
	public List<SegmentNames> getSegmentNamesByOrgId(int orgId) {
		// TODO Auto-generated method stub
		return segmentRepository.findAllByOrgIdIs(orgId);
	}

}
