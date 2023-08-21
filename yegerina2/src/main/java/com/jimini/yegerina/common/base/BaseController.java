package com.jimini.yegerina.common.base;

import java.io.File;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.jimini.yegerina.goods.vo.ImageFileVO;

public abstract class BaseController {

	private static final String CURR_IMAGE_REPO_PATH = "C:\\yegerina\\file_repo";
	
	protected List<ImageFileVO> upload(MultipartHttpServletRequest multipartRequest) throws Exception{
		
		List<ImageFileVO> fileList = new ArrayList<ImageFileVO>();
		
		Iterator<String> fileNames = multipartRequest.getFileNames();
		
		System.out.println(fileNames + " : 전달된 fileName들");
		while (fileNames.hasNext()) {
			
			ImageFileVO imageFileVO = new ImageFileVO();
			String fileName = fileNames.next();
			System.out.println(fileName + " : 전달된 fileName 1개");
			
			imageFileVO.setFileType(fileName);
			MultipartFile mFile = multipartRequest.getFile(fileName);
			System.out.println(mFile + " : mFile의 정보");
			String originalFileName = mFile.getOriginalFilename();
			System.out.println(originalFileName + " : originalFileName의 정보");
			imageFileVO.setFileName(originalFileName);
			fileList.add(imageFileVO);
			
			File file = new File(CURR_IMAGE_REPO_PATH + "\\" + fileName);
			if(mFile.getSize()!=0) {
				if(! file.exists()) {
					if(file.getParentFile().mkdirs()) {
						file.createNewFile();
					}
				}				
				mFile.transferTo(new File(CURR_IMAGE_REPO_PATH +"\\"+"temp"+ "\\"+originalFileName));				
			}						
		}		
		return fileList;
	}

	
	
	private void deleteFile(String fileName) {
		File file = new File(CURR_IMAGE_REPO_PATH + "\\" + fileName);
		
		try {
			
			file.delete();
		}catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	
	@RequestMapping(value="/*.do" ,method={RequestMethod.POST,RequestMethod.GET})
	protected  ModelAndView viewForm(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String viewName=(String)request.getAttribute("viewName");
		ModelAndView mav = new ModelAndView(viewName);
		return mav;
	}
	
	
	
	// 관리자, 마이페이지에서 공통으로 사용될 버튼식조회 기간설정 메소드
	protected String calcSearchPeriod(String fixedSearchPeriod){
		String beginDate=null;
		String endDate=null;
		String endYear=null;
		String endMonth=null;
		String endDay=null;
		String beginYear=null;
		String beginMonth=null;
		String beginDay=null;
		DecimalFormat df = new DecimalFormat("00");
		Calendar cal=Calendar.getInstance();
		
		endYear   = Integer.toString(cal.get(Calendar.YEAR));
		endMonth  = df.format(cal.get(Calendar.MONTH) + 1);
		endDay   = df.format(cal.get(Calendar.DATE));
		endDate = endYear +"-"+ endMonth +"-"+endDay;
		
		//별다른 지정이 없을경우, 1개월
		if(fixedSearchPeriod == null) {
			cal.add(cal.MONTH, -1);
		}else if(fixedSearchPeriod.equals("today")) {
			cal.add(Calendar.DAY_OF_YEAR,-0);
		}else if(fixedSearchPeriod.equals("one_month")) {
			cal.add(cal.MONTH, -1);
		}else if(fixedSearchPeriod.equals("two_month")) {
			cal.add(cal.MONTH,-2);
		}else if(fixedSearchPeriod.equals("three_month")) {
			cal.add(cal.MONTH,-3);
		}else if(fixedSearchPeriod.equals("six_month")) {
			cal.add(cal.MONTH,-6);
		}
		
		beginYear   = Integer.toString(cal.get(Calendar.YEAR));
		beginMonth  = df.format(cal.get(Calendar.MONTH) + 1);
		beginDay   = df.format(cal.get(Calendar.DATE));
		beginDate = beginYear +"-"+ beginMonth +"-"+beginDay;
		
		return beginDate+","+endDate;
	}	
		
	
	
}


