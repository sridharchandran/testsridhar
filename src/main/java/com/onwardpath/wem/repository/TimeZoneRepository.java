package com.onwardpath.wem.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;


import com.onwardpath.wem.entity.TimeZone;

public interface TimeZoneRepository extends JpaRepository<TimeZone, Long>{

	

}
