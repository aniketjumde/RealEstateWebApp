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

	@Override
	public void updateUser(User user) 
	{
		user.setName(user.getName().toLowerCase());
		userDao.updateUser(user);
	}

	@Override
	public long getTotalUsers() 
	{
		
		return userDao.getTotalUsers();
	}

	@Override
	public void updateRole(User user, Role role) 
	{
        userDao.updateUserRole(user, role);

	}

	@Override
	public void deleteUser(Long userId) 
	{
		User user=userDao.findById(userId);
		
		userDao.deleteUser(user);
	}

	@Override
	public User findById(Long userId) {
		
        return userDao.findById(userId);
	}

	

	

}
