package com.jimini.yegerina;

import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * Handles requests for the application home page.
 */
@Controller
@RequestMapping(value="/popup")
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		logger.info("Welcome home! The client locale is {}.", locale);
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		
		String formattedDate = dateFormat.format(date);
		
		model.addAttribute("serverTime", formattedDate );
		
		return "home";
	}
	
	@RequestMapping(value = "showpopup.do", method = RequestMethod.GET)
	public String showPopup(Locale locale, Model model) {
		logger.info("Show popup");
		
		// 팝업 관련 처리를 수행
		// 이 부분에 필요한 처리를 추가하시면 됩니다.

		return "/popup/popupContent";
	}	
	@RequestMapping(value = "showpopup2.do", method = RequestMethod.GET)
	public String showPopup2(Locale locale, Model model) {
		logger.info("Show popup2");
		
		// 팝업 관련 처리를 수행
		// 이 부분에 필요한 처리를 추가하시면 됩니다.
		
		return "/popup/popupContent2";
	}	
	
	
	
	
}
