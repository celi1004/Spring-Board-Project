package com.jiny.web.user.service;

import java.util.List;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.jiny.web.common.Pagination;
import com.jiny.web.user.dao.UserDAO;
import com.jiny.web.user.model.UserVO;

@Service
public class UserServiceImple implements UserService {
	
	@Inject
	private UserDAO userDAO;
	
	@Override
	public List<UserVO> getUserList(Pagination pagination) throws Exception{
		return userDAO.getUserList(pagination);
	}
	
	@Override
	public UserVO getUserInfo(String uid) throws Exception{
		return userDAO.getUserInfo(uid);
	}
	
	@Override
	public void insertUser(UserVO userVO) throws Exception{
		userDAO.insertUser(userVO);
	}
	
	@Override
	public void updateUser(UserVO userVO) throws Exception{
		userDAO.updateUser(userVO);
	}
	
	@Override
	public void deleteUser(String uid) throws Exception{
		userDAO.deleteUser(uid);
	}
	
	@Override
	public int getUserListCnt() throws Exception{
		return userDAO.getUserListCnt();
	}
	
}
