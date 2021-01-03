package com.jiny.web.user.service;

import java.util.List;

import com.jiny.web.user.model.UserVO;

public interface UserService {
	
	public List<UserVO> getUserList() throws Exception;
	
	public UserVO getUserInfo(String uid) throws Exception;
	
	public void insertUser(UserVO userVO) throws Exception;
	
	public void updateUser(UserVO userVO) throws Exception;
	
	public void deleteUser(String uid) throws Exception;

}
