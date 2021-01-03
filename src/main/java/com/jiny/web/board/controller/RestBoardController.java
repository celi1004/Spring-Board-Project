package com.jiny.web.board.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FileUtils;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.jiny.web.board.model.ReplyVO;
import com.jiny.web.board.service.BoardService;

@RestController
@RequestMapping(value="/restBoard")
public class RestBoardController {
	
	private static final Logger logger = LoggerFactory.getLogger(BoardController.class);

	@Inject
	private BoardService boardService;
	
	@ResponseBody
	@RequestMapping(value = "/fileUpload", method = {RequestMethod.POST, RequestMethod.GET})
	public String fileUpload(Model model,
			@RequestParam(value = "upload", required = false) MultipartFile fileload
			, HttpServletRequest req
			, HttpServletResponse response) {
		
		if(!fileload.isEmpty()) {
			try {
				//get filename 
				String filename = fileload.getOriginalFilename();
				
				//image path should be absolute path
				//if not image will save at wacky directory
				String fuploadPath = "C:\\Users\\pjpp8\\eclipse-workspace\\JinyBoard\\src\\main\\webapp\\resources\\images\\upload";
				File file = new File(fuploadPath + "/" + filename);
				
				//create actual file
				FileOutputStream fos = new FileOutputStream(fuploadPath + "/" + filename);
				fos.write(fileload.getBytes());
				fos.close();
				
				//make Json which transfer to jsp
				JSONObject outData = new JSONObject();
				
				outData.put("uploaded", true);
				outData.put("url", "/resources/images/upload/"+filename);
				
				logger.info("upload success"+filename +", " +fuploadPath);
				return outData.toString();
			}catch (Exception e) {
				
				logger.info("upload fail ");
				JSONObject outData = new JSONObject();
				outData.put("uploaded", false);
				return outData.toString();
			}
		}else {
			logger.info("upload fail: no file");
			JSONObject outData = new JSONObject();
			outData.put("uploaded", false);
			return outData.toString();
		}
	}
	
	@RequestMapping(value = "/getReplyList", method = RequestMethod.POST)
	public List<ReplyVO> getReplyList(@RequestParam("bid") int bid) throws Exception{
		return boardService.getReplyList(bid);
	}

	@RequestMapping(value = "/saveReply", method = RequestMethod.POST)
	public Map<String, Object> saveReply(@RequestBody ReplyVO replyVO) throws Exception {
		Map<String, Object> result = new HashMap<>();

		try {
			boardService.saveReply(replyVO);
			result.put("status", "OK");
		} catch (Exception e) {
			e.printStackTrace();
			result.put("status", "False");
		}

		return result;
	}
	
	@RequestMapping(value = "/updateReply", method = {RequestMethod.GET, RequestMethod.POST})
	public Map<String, Object> updateReply(@RequestBody ReplyVO replyVO) throws Exception{
		Map<String, Object> result = new HashMap<>();
		try {
			boardService.updateReply(replyVO);
			result.put("status", "OK");
		}catch(Exception e) {
			e.printStackTrace();
			result.put("status", "False");
		}
		return result;
	}
	
	@RequestMapping(value = "/deleteReply", method = {RequestMethod.GET, RequestMethod.POST})
	public Map<String, Object> deleteReply(@RequestParam("rid") int rid) throws Exception{
		
		Map<String, Object> result = new HashMap<>();
		
		try {
			boardService.deleteReply(rid);
			result.put("status", "OK");
		}catch(Exception e) {
			e.printStackTrace();
			result.put("status", "False");
		}
		return result;
	}
}
