package com.onwardpath.wem.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.transaction.annotation.Transactional;

import com.onwardpath.wem.entity.Image;


public interface ImageRepository  extends JpaRepository<Image, Long>{
	
	
	@Modifying
	@Transactional
	@Query(value="delete from image where experience_id=:id",nativeQuery=true)
	public void deleteimage(@Param("id")long id);

}
