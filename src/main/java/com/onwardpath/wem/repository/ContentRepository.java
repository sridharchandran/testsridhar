package com.onwardpath.wem.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.transaction.annotation.Transactional;

import com.onwardpath.wem.entity.Content;


public interface ContentRepository  extends JpaRepository<Content, Long>{
	
	//List<Content> removeByexpid(int experience_id);
	
	@Modifying
	@Transactional
	@Query(value="delete from content where experience_id=:id",nativeQuery=true)
	public void deletecontent(@Param("id")long id);


}
 