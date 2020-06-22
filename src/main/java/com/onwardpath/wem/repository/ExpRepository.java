package com.onwardpath.wem.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.onwardpath.wem.entity.Experience;
import com.onwardpath.wem.entity.Expinterface;
import com.onwardpath.wem.model.ExperienceViewDTO;

@Repository
public interface ExpRepository extends JpaRepository<Experience, Integer> {
	
	@Query(value ="(select experience.id as expId, experience.name as expName,  experience.type as expType,   experience.status as expStatus,  GROUP_CONCAT(   distinctrow concat(segment.id ,':',segment.name) separator ',' ) as segmentName,  experience.create_time as createTime,  CONCAT(  user.firstname, ' ', user.lastname ) as Name from User user, Experience experience, Segment segment, Content content where   experience.id = content.experience_id   and content.segment_id = segment.id   and user.org_id = :org_id and experience.org_id = :org_id  GROUP BY   experience.id) ", nativeQuery = true)
	List<ExperienceViewDTO> findbyorgID(@Param("org_id")int org_id);

}
