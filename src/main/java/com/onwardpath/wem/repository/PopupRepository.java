package com.onwardpath.wem.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.onwardpath.wem.entity.Popup;

public interface PopupRepository extends JpaRepository<Popup, Integer> {
	
	Popup findByExperienceId(int exp_id);
	
}
