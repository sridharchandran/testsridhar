package com.onwardpath.wem.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.onwardpath.wem.entity.Segment;
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
		return segmentRepository.findAllByOrgIdIsOrderByName(orgId);
	}
	
	@Override
	public boolean segExists(int orgId, String exp_name) {
		return segmentRepository.findByOrgIdAndName(orgId, exp_name) != null;
	}

	@Override
	public Segment saveSegment(Segment seg) {
		return segmentRepository.save(seg);
			
	}

}
