package com.realestate.service;

import java.util.List;

import com.realestate.enums.Role;
import com.realestate.model.User;

public interface UserService 
{
	public User save(User user);
	public User getUserByEmail(String email);
	public User findByFirebaseUid(String firebaseUid);
	public void updateUserRole(String email, Role role);
    public List<User> getAllUsers();


}
