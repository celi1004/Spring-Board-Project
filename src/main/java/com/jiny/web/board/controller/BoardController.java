package com.jiny.web.board.controller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.logging.Logger;
import javax.inject.Inject;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FileUtils;
import org.json.JSONObject;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.jiny.web.board.model.BoardVO;
import com.jiny.web.board.model.ReplyVO;
import com.jiny.web.board.service.BoardService;
import com.jiny.web.common.Pagination;
import com.jiny.web.common.Search;
import com.jiny.web.menu.model.MenuVO;
import com.jiny.web.menu.service.MenuService;

@Controller
@RequestMapping(value = "/board")
public class BoardController {
	
	@Inject
	private BoardService boardService;
	
	@Inject
	private MenuService menuService;
	
	@RequestMapping(value ="/getBoardList", method = RequestMethod.GET)
	public String getBoardList(Model model
			, @RequestParam(required = false, defaultValue = "all") String category
			, @RequestParam(required = false, defaultValue="1") int page
			, @RequestParam(required = false, defaultValue="1") int range
			, @RequestParam(required = false, defaultValue="title") String searchType
			, @RequestParam(required = false) String keyword
			, @ModelAttribute("search") Search search
			) throws Exception{
		
		model.addAttribute("search", search);
		search.setSearchType(searchType);
		search.setKeyword(keyword);
		search.setCategory(category);
		
		int listCnt = boardService.getBoardListCnt(search);
		
		search.pageInfo(page, range, listCnt);
		
		model.addAttribute("pagination", search);
		model.addAttribute("boardList", boardService.getBoardList(search));
		return "board/index";
	}
	
	@RequestMapping("/boardForm")
	public String boardForm(@ModelAttribute("boardVO") BoardVO vo, Model model) throws Exception {
		
		model.addAttribute("categoryList",  menuService.getMenuList() );
		return "board/boardForm";
	}
	
	@RequestMapping(value="/saveBoard", method = RequestMethod.POST)
	public String saveBoard(@ModelAttribute("BoardVO") BoardVO boardVO, @RequestParam("mode") String mode, RedirectAttributes rttr) throws Exception{
		
		if(mode.equals("edit")) {
			boardService.updateBoard(boardVO);
		}else {
			boardService.insertBoard(boardVO);
		}
		return "redirect:/board/getBoardContent?bid="+boardVO.getBid();
	}
	
	@RequestMapping(value="/getBoardContent", method = RequestMethod.GET)
	public String getBoardContent(Model model, @RequestParam("bid") int bid) throws Exception{
		model.addAttribute("boardContent", boardService.getBoardContent(bid));
		model.addAttribute("replyVO", new ReplyVO());
		return "board/boardContent";
	}
	
	@RequestMapping(value="/editForm", method = RequestMethod.GET)
	public String editForm(@RequestParam("bid") int bid, @RequestParam("mode") String mode, Model model) throws Exception{
		model.addAttribute("boardContent", boardService.getBoardContent(bid));
		model.addAttribute("mode", mode);
		model.addAttribute("boardVO", new BoardVO());
		model.addAttribute("categoryList",  menuService.getMenuList() );
		
		return "board/boardForm";
	}
	
	@RequestMapping(value="/deleteBoard", method = RequestMethod.GET)
	public String deleteBoard(RedirectAttributes rttr, @RequestParam("bid") int bid) throws Exception{
		boardService.deleteBoard(bid);
		return "redirect:/board/getBoardList";
	}
	
	/*
	@ExceptionHandler(RuntimeException.class)
	public String exceptionHandler(Model model, Exception e) {
		Logger logger = Logger.getLogger("exceptionLog");
		logger.info("exception : "+e.getMessage());
		model.addAttribute("exception", e);
		return "error/exception";
	}*/
}
