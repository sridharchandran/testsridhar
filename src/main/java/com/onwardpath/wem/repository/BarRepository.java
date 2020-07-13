package com.onwardpath.wem.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.onwardpath.wem.entity.Bar;

public interface BarRepository extends JpaRepository<Bar, Integer> {

}
