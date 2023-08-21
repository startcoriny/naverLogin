package com.jimini.yegerina.common.file;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import net.coobird.thumbnailator.Thumbnails;


@Controller
public class FileDownloadController {
	private static String CURR_IMAGE_REPO_PATH = "C:\\yegerina\\file_repo";
	
	@RequestMapping("/download.do")
	protected void download(@RequestParam("fileName") String fileName,
		                 	@RequestParam("goods_id") String goods_id,
			                 HttpServletResponse response) throws Exception {
		OutputStream out = response.getOutputStream();
		String filePath=CURR_IMAGE_REPO_PATH+"\\"+goods_id+"\\"+fileName;
		File image=new File(filePath);
	
		response.setHeader("Cache-Control","no-cache");
		response.addHeader("Content-disposition", "attachment; fileName="+fileName);
		FileInputStream in=new FileInputStream(image); 
		byte[] buffer=new byte[1024*8];
		while(true){
			int count=in.read(buffer);
			if(count==-1)
				break;
			out.write(buffer,0,count);
		}
		in.close();
		out.close();
	}
	
	
	@RequestMapping("/thumbnails.do")
	protected void thumbnails(@RequestParam("fileName") String fileName,
                            	@RequestParam("goods_id") String goods_id,
			                 HttpServletResponse response) throws Exception {
		
		System.out.println(fileName + " : 썸네일에서받아온 fileName");
		System.out.println(goods_id + " : 썸네일에서받아온 goods_id");
		
		OutputStream out = response.getOutputStream();
		String filePath=CURR_IMAGE_REPO_PATH+"\\"+goods_id+"\\"+fileName;
		System.out.println(filePath + " : filePath의 경로");
		File image=new File(filePath);
		
		if (image.exists()) { 
			Thumbnails.of(image).size(121,154).outputFormat("png").toOutputStream(out);
		}
		byte[] buffer = new byte[1024 * 8];
		out.write(buffer);
		out.close();
	}
}