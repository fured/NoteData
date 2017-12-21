package com.ioc;

public class UserService{
	private UserDao userDao;

	public void setUserDao(UserDao userDao){
		this.userDao = userDao;
	}

	public void add(){
		System.out.println("service add ...");
		this.userDao.add();
	}
}
