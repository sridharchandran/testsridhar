package com.onwardpath.wem.repository;

import com.onwardpath.wem.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface UserRepository extends JpaRepository<User, Integer> {
    User findByEmail(String email);
   // User findByUserName(String userName);
    User findById(int id);
}