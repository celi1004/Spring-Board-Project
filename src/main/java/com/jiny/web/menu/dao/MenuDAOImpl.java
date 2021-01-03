package com.jiny.web.menu.dao;

import java.util.List;
import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.jiny.web.menu.model.MenuVO;

@Repository
public class MenuDAOImpl implements MenuDAO{
	
	@Inject
	private SqlSession sqlSession;
	
	@Override
	public List<MenuVO> getMenuList() throws Exception{
		return sqlSession.selectList("com.jiny.web.menu.menuMapper.getMenuList");
	}
	
	@Override
	public int saveMenu(MenuVO menuVO) throws Exception{
		return sqlSession.insert("com.jiny.web.menu.menuMapper.insertMenu", menuVO);
	}
	
	@Override
	public int updateMenu(MenuVO menuVO) throws Exception{
		return sqlSession.update("com.jiny.web.menu.menuMapper.updateMenu", menuVO);
	}
	
	@Override
	public int deleteMenu(String code) throws Exception{
		return sqlSession.delete("com.jiny.web.menu.menuMapper.deleteMenu", code);
	}
}
