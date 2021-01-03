package com.jiny.web.menu.dao;

import java.util.List;
import com.jiny.web.menu.model.MenuVO;

public interface MenuDAO {
	
	public List<MenuVO> getMenuList() throws Exception;
	
	public int saveMenu(MenuVO menuVO) throws Exception;
	
	public int updateMenu(MenuVO menuVO) throws Exception;
	
	public int deleteMenu(String code) throws Exception;

}
