package com.onwardpath.wem.repository;

import com.onwardpath.wem.entity.User;
import com.onwardpath.wem.projections.NamesOnly;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface UserRepository extends JpaRepository<User, Integer> {
    User findByEmail(String email);
    User findByUserName(String userName);
    User findByid(int id);
  //  User updateUserSetStatus();
    List<NamesOnly> findByOrgidIs(int org_id);
}