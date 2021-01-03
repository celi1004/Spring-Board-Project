package com.jiny.web;

import java.util.List;
import javax.inject.Inject;

import org.junit.Ignore;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.jiny.web.board.dao.BoardDAO;
import com.jiny.web.board.model.BoardVO;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {
		"classpath:spring/root-context.xml",
		"classpath:spring/dataSource-context.xml"
	})

public class BoardDAOTest{
	private static final Logger logger = LoggerFactory.getLogger(BoardDAOTest.class);
	
	@Inject
	private BoardDAO boardDAO;
	
	@Test @Ignore
	public void testGetBoardList() throws Exception{
		List<BoardVO> boardList = boardDAO.getBoardList();
		logger.info("\n Board List \n ");

		if(boardList.size() > 0) {
			for(BoardVO list : boardList) {
				logger.info(list.title);
			}
		} else {
			logger.info("데이터가 없습니다.");
		}
	}
	
	@Test @Ignore
	public void testGetBoardContent() throws Exception {

		BoardVO boardVO = boardDAO.getBoardContent(1);

		logger.info("\n Board List \n ");

		if(boardVO != null) {
			logger.info("글번호 : " + boardVO.getBid() );
			logger.info("글제목 : " + boardVO.getTitle() );
			logger.info("글내용 : " + boardVO.getContent() );
			logger.info("글태그 : " + boardVO.getTag() );
			logger.info("조회수 : " + boardVO.getView_cnt() );
			logger.info("작성자 : " + boardVO.getReg_id() );
			logger.info("작성일 : " + boardVO.getReg_dt() );
			logger.info("수정일 : " + boardVO.getEdit_dt() );
		} else {
			logger.info("데이터가 없습니다.");
		}
	}

	@Test
	public void testInsertBoard() throws Exception {

		BoardVO boardVO = new BoardVO();
		
		boardVO.setCate_cd("1");
		//boardVO.setTitle("첫번째 게시물 입니다.");
		//boardVO.setContent("첫번째 게시물입니다.");
		boardVO.setTag("1");
		boardVO.setReg_id("1");

		for(int i=1; i<1234; i++) {
			boardVO.setTitle(i+" 번째 게시물 입니다.");
			boardVO.setContent(i+" 번째 게시물 입니다.");
			int result = boardDAO.insertBoard(boardVO);

			logger.info("\n Insert Board Result " +result);

			if(result == 1) {
				logger.info("\n 게시물 등록 성공 ");
			} else {
				logger.info("\n 게시물 등록 실패");
			}
		}
	}

	@Test @Ignore
	public void testUpdateBoard() throws Exception {
		BoardVO boardVO = new BoardVO();

		boardVO.setBid(1);

		boardVO.setCate_cd("1");

		boardVO.setTitle("첫번째 게시물 입니다-수정 합니다.");

		boardVO.setContent("첫번째 게시물입니다-수정합니다.");

		boardVO.setTag("1-1");

		int result = boardDAO.updateBoard(boardVO);

		logger.info("\n Update Board Result \n ");

		if(result > 0) {
			logger.info("\n 게시물 수정 성공 ");
		} else {
			logger.info("\n 게시물 수정 실패");
		}
	}

	@Test @Ignore
	public void tesDeleteBoard() throws Exception {
		int result = boardDAO.deleteBoard(2);

		logger.info("\n Delete Board Result \n ");

		if(result > 0) {
			logger.info("\n 게시물 삭제 성공 ");
		} else {
			logger.info("\n 게시물 삭제 실패");
		}
	}

	@Test @Ignore
	public void testUpdateViewCnt() throws Exception {
		int result = boardDAO.updateViewCnt(1);

		logger.info("\n Update View Count Result \n ");

		if(result > 0) {
			logger.info("\n 게시물 조회수 업데이트 성공 ");
		} else {
			logger.info("\n 게시물 조회수 업데이트 실패");
		}
	}
}