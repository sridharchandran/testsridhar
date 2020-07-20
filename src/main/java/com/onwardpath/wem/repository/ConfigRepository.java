package com.onwardpath.wem.repository;

import java.time.LocalDateTime;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.onwardpath.wem.entity.Config;


@Repository
public interface ConfigRepository extends JpaRepository<Config, Long>{
	
	
	@Modifying
	@Transactional
    @Query(value="update config e set e.url =:url,e.user_id=:user_id where e.experience_id= :id",nativeQuery=true)
    public void updateconfig(@Param("url") String url, @Param("user_id") int user_id,@Param("id") int id);

	
	@Modifying
	@Transactional
	@Query(value="delete from config where experience_id=:id",nativeQuery=true)
	public void deleteconfig(@Param("id")long id);
	  
}
