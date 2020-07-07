package com.onwardpath.wem.repository;

import java.sql.Date;
import java.time.LocalDateTime;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.onwardpath.wem.entity.Experience;




@Repository
public interface  ExperienceRepository  extends JpaRepository<Experience, Long>  {
	
	@Query(value="select count(*) from experience where name = :name  and org_id = :org_id", nativeQuery=true)
	boolean existsByName(@Param("name") String name, @Param("org_id") int org_id);
	    
	@Modifying
	@Transactional
    @Query(value="update experience e set e.timezone_id =:timezone_id,e.schedule_start=:schedule_start,e.schedule_end =:schedule_end,e.status =:status where e.id= :id",nativeQuery=true)
    public void updateexperience(@Param("timezone_id") String timezone_id, @Param("schedule_start") LocalDateTime localDateTime,@Param("schedule_end") Date schedule_end,@Param("status") String status,@Param("id") int id);
	
	Experience findByOrgIdAndName(int orgId,String exp_name);
	Experience findByOrgIdAndNameIgnoreCase(int orgId,String exp_name);
	Experience findById(int exp_id);
	
}
	 	


