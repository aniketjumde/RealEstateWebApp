package com.realestate.dao;

import java.util.List;
import java.util.Optional;

import com.realestate.enums.Role;
import com.realestate.model.User;

public interface UserDAO 
{
	 public User save(User user);
	 public Optional<User> findByEmail(String email);
	 public Optional<User> findByFirebaseUid(String firebaseUid);
	 public void updateRole(String email, Role role);
	 public List<User> findAll();
}
