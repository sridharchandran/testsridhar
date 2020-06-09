package com.onwardpath.wem.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.onwardpath.wem.entity.Organization;

	@Repository
	public interface OrgRepository extends JpaRepository<Organization, Integer> {
		Organization findById(int id);
		Organization findByDomain(String domain);
}
