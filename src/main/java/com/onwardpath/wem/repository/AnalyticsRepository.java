package com.onwardpath.wem.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import com.onwardpath.wem.entity.Analytics;

@Repository
public interface AnalyticsRepository extends JpaRepository<Analytics, Integer> {
	Analytics findById(int id);
	Analytics findByDomainUrlIs(String domainURL);
	Analytics findByRootDomainIs(String root_domain);
}
