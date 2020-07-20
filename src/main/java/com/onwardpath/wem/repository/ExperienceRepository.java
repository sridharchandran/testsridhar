package com.onwardpath.wem.repository;

import java.sql.Date;
import java.time.LocalDateTime;
import java.util.List;

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
    public void updateexperience(@Param("timezone_id") String timezone_id, @Param("schedule_start") LocalDateTime schd_start,@Param("schedule_end") LocalDateTime schd_end,@Param("status") String status,@Param("id") int id);

    Experience findByOrgIdAndName(int orgId,String exp_name);
	Experience findByOrgIdAndNameIgnoreCase(int orgId,String exp_name);
	Experience findById(int exp_id);
	
	@Transactional
    @Query(value="SELECT status,schedule_start,schedule_end,timezone_id where id = :id",nativeQuery=true)
    public List<Experience> findscheduleDate(@Param("id") int id);
	
	
	@Modifying
	@Transactional
	@Query(value="UPDATE experience e SET e.name=:name WHERE e.id=:id",nativeQuery=true)
	public void updateName(@Param("name")String name, @Param("id")long id);
	
	@Modifying
	@Transactional
	@Query(value="UPDATE experience e SET e.status=:status WHERE e.id=:id",nativeQuery=true)
	public void updatestatus(@Param("status")String status, @Param("id")long id);
	
	
	@Modifying
	@Transactional
	@Query(value="UPDATE experience e SET e.schedule_start=:schedule_start WHERE e.id=:id",nativeQuery=true)
	public void updatestartdate(@Param("schedule_start")String schedule_start, @Param("id")long id);
	
	@Modifying
	@Transactional
	@Query(value="UPDATE experience e SET e.schedule_end=:schedule_end WHERE e.id=:id",nativeQuery=true)
	public void updateenddate(@Param("schedule_end")String schedule_end, @Param("id")long id);
	
	
	@Modifying
	@Transactional
	@Query(value="UPDATE experience e SET e.timezone_id=:timezone_id WHERE e.id=:id",nativeQuery=true)
	public void updatetimezoneval(@Param("timezone_id")String timezone_id, @Param("id")long id);
	
	
	@Modifying
	@Transactional
	@Query(value="update experience set status = 'off',schedule_start= NULL,schedule_end= NULL,timezone_id = NULL where id= :id",nativeQuery=true)
	public void resetschdule(@Param("id")long id);
	
	
 
	
}
	 	




