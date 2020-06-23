package com.onwardpath.wem.repository;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.onwardpath.wem.entity.Segment;

@Repository
public interface  SegmentRepository  extends JpaRepository<Segment, Long>  {
	
	@Query(value="select * from segment where org_id  = :orgId order by name", nativeQuery=true)
	public List<Segment> getSegmentByCustomQuery(int orgId);

	
}
 