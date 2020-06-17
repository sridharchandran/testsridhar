package com.onwardpath.wem.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.onwardpath.wem.entity.Config;


@Repository
public interface ConfigRepository extends JpaRepository<Config, Long>{
	
	
	
	
	
	  
}
