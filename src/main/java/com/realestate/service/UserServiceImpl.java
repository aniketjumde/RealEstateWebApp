package com.realestate.service;

import java.util.List;

import com.realestate.dao.UserDAO;
import com.realestate.enums.Role;
import com.realestate.factory.UserDaoFactory;
import com.realestate.model.User;

public class UserServiceImpl implements UserService
{
	private UserDAO userDao=UserDaoFactory.getDaoInstance();


	@Override
	public User save(User user) 
	{
		user.setEmail(user.getEmail().toLowerCase());
		user.setName(user.getName().toLowerCase());
		return userDao.save(user);
	}

	@Override
	public User getUserByEmail(String email) 
	{
		return userDao.findByEmail(email).orElse(null);

	}

	@Override
	public User findByFirebaseUid(String firebaseUid) 
	{
		return userDao.findByFirebaseUid(firebaseUid).orElse(null);
	}

	@Override
	public void updateUserRole(String email, Role role) 
	{
		userDao.updateRole(email.toLowerCase(), role);
	}

	@Override
	public List<User> getAllUsers() 
	{
		return userDao.findAll();
	}

}
