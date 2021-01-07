package com.jiny.web.user.dao;

import java.util.List;
import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.jiny.web.common.Pagination;
import com.jiny.web.user.model.UserVO;

@Repository
public class UserDAOImpl implements UserDAO{

	@Inject
	private SqlSession sqlSession;
	
	@Override
	public List<UserVO> getUserList(Pagination pagination) throws Exception {
		return sqlSession.selectList("com.jiny.web.user.userMapper.getUserList", pagination);
	}
	
	@Override
	public UserVO getUserInfo(String uid) throws Exception{
		return sqlSession.selectOne("com.jiny.web.user.userMapper.getUserInfo", uid);
	}
	
	@Override
	public int insertUser(UserVO userVO) throws Exception{
		return sqlSession.insert("com.jiny.web.user.userMapper.insertUser", userVO);
	}
	
	@Override
	public int updateUser(UserVO userVO) throws Exception{
		return sqlSession.update("com.jiny.web.user.userMapper.updateUser", userVO);
	}
	
	@Override
	public int deleteUser(String uid) throws Exception{
		return sqlSession.delete("com.jiny.web.user.userMapper.deleteUser", uid);
	}
	
	@Override
	public int getUserListCnt() throws Exception{
		return sqlSession.selectOne("com.jiny.web.user.userMapper.getUserListCnt");
	}
}
