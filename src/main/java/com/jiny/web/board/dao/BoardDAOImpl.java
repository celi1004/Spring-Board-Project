package com.jiny.web.board.dao;

import java.util.List;
import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.jiny.web.board.model.BoardVO;
import com.jiny.web.board.model.ReplyVO;
import com.jiny.web.common.Pagination;
import com.jiny.web.common.Search;

@Repository
public class BoardDAOImpl implements BoardDAO {
	
	@Inject
	private SqlSession sqlSession;
	
	@Override
	public List<BoardVO> getBoardList(Search search) throws Exception{
		return sqlSession.selectList("com.jiny.web.board.boardMapper.getBoardList", search);
	}

	@Override
	public BoardVO getBoardContent(int bid) throws Exception{
		return sqlSession.selectOne("com.jiny.web.board.boardMapper.getBoardContent", bid);
	}
	
	@Override
	public int insertBoard(BoardVO boardVO) throws Exception{
		return sqlSession.insert("com.jiny.web.board.boardMapper.insertBoard", boardVO);
	}
	
	@Override
	public int updateBoard(BoardVO boardVO) throws Exception{
		return sqlSession.update("com.jiny.web.board.boardMapper.updateBoard", boardVO);
	}
	
	@Override
	public int deleteBoard(int bid) throws Exception{
		return sqlSession.insert("com.jiny.web.board.boardMapper.deleteBoard", bid);
	}
	
	@Override
	public int updateViewCnt(int bid) throws Exception{
		return sqlSession.update("com.jiny.web.board.boardMapper.updateViewCnt", bid);
	}
	
	@Override
	public int getBoardListCnt(Search search) throws Exception{
		return sqlSession.selectOne("com.jiny.web.board.boardMapper.getBoardListCnt", search);
	}
	
	@Override
	public List<ReplyVO> getReplyList(int bid) throws Exception{
		return sqlSession.selectList("com.jiny.web.board.replyMapper.getReplyList", bid);
	}
	
	@Override
	public int saveReply(ReplyVO replyVO) throws Exception {
		return sqlSession.insert("com.jiny.web.board.replyMapper.saveReply", replyVO);
	}

	@Override
	public int updateReply(ReplyVO replyVO) throws Exception {
		return sqlSession.update("com.jiny.web.board.replyMapper.updateReply", replyVO);
	}

	@Override
	public int deleteReply(int rid) throws Exception {
		return sqlSession.delete("com.jiny.web.board.replyMapper.deleteReply", rid);
	}

}
