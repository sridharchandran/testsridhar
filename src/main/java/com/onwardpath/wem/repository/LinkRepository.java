package com.onwardpath.wem.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.onwardpath.wem.entity.Link;

public interface LinkRepository extends JpaRepository<Link, Integer> {
	Link findByExperienceId(int exp_id);
}
