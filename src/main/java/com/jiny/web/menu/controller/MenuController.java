package com.jiny.web.menu.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.jiny.web.menu.model.MenuVO;

@Controller
@RequestMapping("/menu")
public class MenuController {

	private static final Logger logger = LoggerFactory.getLogger(MenuController.class);
	
	@RequestMapping(value = "/getMenu", method = RequestMethod.GET)
	public String getMenuList(Model model) throws Exception{
		model.addAttribute("menuVO", new MenuVO());
		
		return "menu/menu";
	}
}
