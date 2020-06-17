package com.onwardpath.wem.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.onwardpath.wem.entity.Experience;



@Repository
public interface  ExperienceRepository  extends JpaRepository<Experience, Long>  {
	
	@Query(value="select count(*) from experience where name = :name  and org_id = :org_id", nativeQuery=true)
	boolean existsByName(@Param("name") String name, @Param("org_id") int org_id);


	 	
}
