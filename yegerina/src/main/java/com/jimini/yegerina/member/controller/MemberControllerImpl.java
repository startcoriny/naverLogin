package com.jimini.yegerina.member.controller;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.fasterxml.jackson.databind.ObjectMapper;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.github.scribejava.core.model.OAuth2AccessToken;
import com.jimini.yegerina.common.base.BaseController;
import com.jimini.yegerina.member.naverApi.NaverLoginBO;
import com.jimini.yegerina.member.service.MemberService;
import com.jimini.yegerina.member.vo.MemberVO;


@Controller("memberController")
// Spring 컨테이너에서 컨트롤러로 등록되는 것을 나타냄
// memberController라는는 컨트롤러의 이름을 지정 - 컨트롤러를 주입할 때 사용될 이름 
// ex) @Autowired로 주입할때 해당 이름을 사용하여 주입 할수 있음
@RequestMapping(value = "/member")
public class MemberControllerImpl extends BaseController implements MemberController {

	@Autowired
	// Spring Framework에서 의존성 주입(Dependency Injection)을 수행하는 데 사용되는 어노테이션
	// 필드, 생성자, 메서드 등에 붙여서 해당 컴포넌트나 빈에 필요한 의존 객체를 자동으로 주입
	// IoC (Inversion of Control) 컨테이너는 @Autowired 어노테이션이 붙은 필드나 메서드 파라미터의 타입에 해당하는 빈을 찾아서 주입
	
	/* Spring의 IoC 컨테이너
	 * 
	 * .주로 BeanFactory 또는 ApplicationContext 인터페이스를 구현하여 사용
	 * .XML 설정, Java 어노테이션, Java 코드 등 다양한 방식으로 관리되는 빈(Bean)들을 관리
	 * .애플리케이션의 구조를 보다 모듈화하고 관리하기 쉽게 만들어줌
	 * .코드의 유연성, 재사용성, 테스트 용이성을 향상
	 * */ 	
	private MemberService memberService;
	// MemberService 타입의 빈을 자동으로 주입
	// 이 필드를 통해 MemberService의 메서드를 호출하여 비즈니스 로직을 처리
	
	@Autowired
	private MemberVO memberVO;
	// MemberVO 타입의 빈을 자동으로 주입
	
	@Autowired
	private NaverLoginBO naverloginbo;
	
	@RequestMapping(value = "loginForm.do", method = RequestMethod.GET)
	public String loginForm(Model model, HttpSession session) throws Exception {
		
		System.out.println("로그인폼(네이버아이디)");
		String naverAuthUrl = naverloginbo.getAuthorizationUrl(session);
		System.out.println(naverAuthUrl + " : 네이버로그인을 이용하기위한 naverAuthURL");
		model.addAttribute("naverUrl", naverAuthUrl);
		return "/member/loginForm";
	}
	
	
	
	@RequestMapping(value="/userNaverLoginPro.do",  method = {RequestMethod.GET,RequestMethod.POST})
	public String userNaverLoginPro(Model model,@RequestParam Map<String,Object> paramMap, @RequestParam String code, @RequestParam String state,HttpSession session) throws SQLException, Exception {
		System.out.println("paramMap:" + paramMap);
		Map <String, Object> resultMap = new HashMap<String, Object>();

		OAuth2AccessToken oauthToken;
		oauthToken = naverloginbo.getAccessToken(session, code, state);
		//로그인 사용자 정보를 읽어온다.
		String apiResult = naverloginbo.getUserProfile(oauthToken);
		System.out.println("apiResult =>"+apiResult);
		ObjectMapper objectMapper =new ObjectMapper();
		Map<String, Object> apiJson = (Map<String, Object>) objectMapper.readValue(apiResult, Map.class).get("response");
		
		Map<String, Object> naverConnectionCheck = (Map<String, Object>) memberService.naverConnectionCheck(apiJson);
		
		System.out.println("체크해온 네이버 커넥션 체크@@@@@@@@" + naverConnectionCheck);
		
		if(naverConnectionCheck == null) { //일치하는 아이디 없으면 가입
			
			model.addAttribute("email",apiJson.get("email"));
			return "/member/setdataForm";
			
			
		}else if(naverConnectionCheck.get("NAVERLOGIN") == null && naverConnectionCheck.get("email") != null) { //아이디 가입 되어있고 네이버 연동 안되어 있을시
			memberService.setNaverConnection(apiJson);
			Map<String, Object> loginCheck = (Map<String, Object>) memberService.userNaverLoginPro(apiJson);
			session.setAttribute("userInfo", loginCheck);
			
			
		}else { //모두 연동 되어있을시
			Map<String, Object> loginCheck = (Map<String, Object>) memberService.userNaverLoginPro(apiJson);
			session.setAttribute("userInfo", loginCheck);
		}

		return "redirect:main/main.do";
	}
	
	
	@RequestMapping(value="/userNaverRegisterPro.do", method=RequestMethod.POST)
	public Map<String, Object> userNaverRegisterPro(@RequestParam Map<String,Object> paramMap,HttpSession session) throws SQLException, Exception {
		System.out.println("paramMap:" + paramMap);
		Map <String, Object> resultMap = new HashMap<String, Object>();
		Integer registerCheck = memberService.userNaverRegisterPro(paramMap);
		System.out.println(registerCheck);
		
		if(registerCheck != null && registerCheck > 0) {
			Map<String, Object> loginCheck = (Map<String, Object>) memberService.userNaverLoginPro(paramMap);
			session.setAttribute("userInfo", loginCheck);
			resultMap.put("JavaData", "YES");
		}else {
			resultMap.put("JavaData", "NO");
		}
		return resultMap;
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	@Override
	@RequestMapping(value="/login.do" ,method = RequestMethod.POST)
	// 컨트롤러 클래스 또는 메서드에 웹 요청 경로를 매핑하는데 사용되는 어노테이션
	// 특정 URL 경로에 해당하는 요청을 처리하는 메서드를 지정할 수 있음.
	// value : 매핑할 URL 경로, method : 요청의 HTTP 메서드 타입 지정
	
	public ModelAndView login(@RequestParam Map<String, String> loginMap,
			// @RequestParam 어노테이션을 사용하여 HTTP 요청 파라미터 받아와서 loginMap에 저장
			// @RequestParam은 Spring MVC에서 웹 요청 파라미터를 컨트롤러 메서드의 매개변수로 바인딩 하는데 사용되는 어노테이션
			// 클라이언트에서 전달된 HTTP 요청의 파라미터 값을 컨트롤러 메서드의 매개변수에 자동으로 매핑
			// 쿼리 문자열, HTML form으로 전송된 데이터, JSON 형식의 요청 본문을 받아올때 사용
			// value : 요청 들어온 파라미터의 이름을 지정 , 생략할 경우 매개변수으이 이름과 동일한 문자열로 매핑
			// required : 해당 파라미터가 필수인지 여부를 지정, 기본값은 true, 아닐경우 defaultValue속성을 사용하여 기본값을 지정
			// defaultValue : 파라미터가 전달되지 않았을 경우 사용할 기본값을 지정
			
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		System.out.println(loginMap + " : member컨트롤러에 들어온 ID,PW");
		System.out.println(loginMap.toString() + " : toString으로 확인한 들어온 ID,PW");
		System.out.println(loginMap.get("member_id") + " : 들어온 id확인");
		ModelAndView mav = new ModelAndView();
		// ModelAndView객체는 springMVC에서 사용되는 뷰와 데이터를 함게 처리하는 클래스
		// 컨트롤러에서 데이터와 뷰 정보를 담아서 반환하여 클라이언트에게 전달
		// addObject(String attributeName, Object attributeValue) 메서드를 사용하여 데이터를 ModelAndView에 추가및 전달
		// setViewName 메서드를 사용하여 뷰 이름을 설정하면서 "redirect:"나 "forward:" 접두어를 붙여 리다이렉트나 포워드를 수행
		 memberVO=memberService.login(loginMap);
		 System.out.println(memberVO + " : login메서드로 받아온 memberVO");
	
		 
		 // 로그인 성공할시
		 // session에 키,value값들을 담아서 view리졸버로 리턴
		if(memberVO!= null && memberVO.getMemberId()!=null){
			HttpSession session=request.getSession();
			// 현재 요청(request)에 대한 세션 객체를 가져옴
			
			session.setAttribute("isLogOn", true);
			// "isLogOn"이라는 이름으로 true 값을 저장
			
			session.setAttribute("memberInfo",memberVO);
			// "memberInfo"라는 이름으로 로그인한 회원 정보(memberVO 객체)를 저장
			
			String action=(String)session.getAttribute("action");
			if(action!=null && action.equals("/order/orderEachGoods.do")){
				mav.setViewName("forward:"+action);
				// Model and View 객체를 생성
				// "forward:"를 통해 지정된 경로로 요청을 전달
				// forward : 웹 애플리케이션에서 다른 URL로 현재 요청을 전달하는 방식
				// 			  웹 컨테이너(서버) 내에서 다른 서블릿 또는 JSP 페이지로 요청을 전달하고, 
				// 			  그 결과를 받아와서 현재 요청의 응답을 생성
				// 			  전달된 페이지에서는 동일한 요청 객체와 파라미터 등을 사용하여 처리할 수 있음
				//			  원래 요청에 전달된 데이터를 그대로 사용할 수 있음
				//			  주로 서블릿이나 JSP 페이지 간에 데이터나 작업을 전달하고자 할 때 사용
				// 			  웹 애플리케이션에서 로그인 후 특정 페이지로 이동하거나, 작업을 처리한 후 결과 페이지를 표시할 때 "forward"를 사용
			 
			}else{
				mav.setViewName("redirect:/main/main.do");
				// action이 null이거나 일치하지 않는 경우 로그인 후 메인 페이지로 이동
				// redirect : 웹 애플리케이션에서 다른 URL로 클라이언트(브라우저)를 이동시키는 방식
				// 			    클라이언트에게 다른 페이지로 이동하라는 명령을 내림으로써, 클라이언트가 새로운 요청을 생성하고 해당 페이지로 이동
				//			    클라이언트가 실제로 다른 페이지로 이동한 것과 동일한 효과를 가지며, 브라우저의 주소창에 새로운 URL이 표시
				// 			    클라이언트가 새로운 요청을 보내므로, 서버 외부로 요청이 전달
				// 			    클라이언트와 서버 간의 통신이 끊기게 되며, 클라이언트의 상태나 데이터는 유지되지 않음
				// 			  "redirect"는 클라이언트의 새로운 요청이므로, 요청 객체가 새롭게 생성
				//			    원래 요청에서 사용되었던 데이터나 파라미터 등을 전달하지 않음
				//			    주로 다른 도메인으로 이동해야 할 경우나 외부 URL로 이동할 때 사용
				// 			    로그인 후 메인 페이지로 리다이렉트하거나, 작업을 완료한 후 결과 페이지로 이동하는 경우에도 활용
				
			}
			
			
		// 로그인 실패시	
		// 메세지를 담아서 로그인폼으로 돌아감.
		}else{
			String message="아이디나  비밀번호가 틀립니다. 다시 로그인해주세요";
			mav.addObject("message", message);
			mav.setViewName("/member/loginForm");
		}
		return mav;
		// 리턴 값이 뷰리졸버로 반환
		// 뷰 리졸버(View Resolver)를 통해 실제 뷰로 변환
		// 타일즈(Tiles)와 같은 뷰 템플릿을 사용할 때 특히 유용하게 활용
	}

	
	
	// 로그아웃
	@Override
	@RequestMapping(value = "/logout.do", method = RequestMethod.GET)
	public ModelAndView logout(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		ModelAndView mav = new ModelAndView();
		HttpSession session=request.getSession();
		// 현재 요청(request)에 대한 세션 객체를 가져옴
		session.setAttribute("isLogOn", false);
		session.removeAttribute("memberInfo");
		// 세션에서 memberInfo속성(회원 정보) 제거
		mav.setViewName("redirect:/main/main.do");
		
		return mav;
	}

	

	//회원가입
	@Override
	@RequestMapping(value="/addMember.do" ,method = RequestMethod.POST)
	public ResponseEntity addMember(@ModelAttribute MemberVO member, HttpServletRequest request, HttpServletResponse response)
			throws Exception {
	// ResponseEntity : HTTP 응답을 나타내는 데 사용
	// 					컨트롤러 메서드에서 클라이언트에게 반환되는 응답을 구성하는 데 사용
	// 					다양한 상태 코드나 헤더 설정, 커스텀 응답을 구성할 수 있어서 RESTful API를 개발할 때 유용하게 사용
	
	//@ModelAttribute어노테이션 : 데이터 바인딩을 간편하게 처리하고, 모델에 미리 데이터를 채워놓는 등의 작업을 도와줌
	//						     주로 컨트롤러 메서드의 파라미터 또는 메서드에서 사용.
	//						     메서드 파라미터 앞에 붙이면 해당 파라미터가 HTTP 요청의 데이터를 모델 객체에 바인딩.
	//						     주로 폼 데이터나 URL 쿼리 파라미터를 객체로 변환할 때 사용.

		response.setContentType("text/html; charset=UTF-8");
		// 응답의 Context-Type을 설정하는 역할을 함
		// 클라이언트가 받는 응답 컨텐츠가 HTML이며 UTF-8로 인코딩
		
		request.setCharacterEncoding("utf-8");
		// 요청의 문자 인코딩을 설정하는 역할
		
		String message = null;
		ResponseEntity resEntity = null;
		
		HttpHeaders responseHeaders = new HttpHeaders();
		// HttpHeaders 클래스 : HTTP 응답의 헤더 정보를 관리하는 데 사용
		// HTTP 응답에서 헤더는 클라이언트에게 전송되는 메타데이터로, 응답의 특성 및 설정을 제어하는 데 사용
		// HttpHeaders 객체는 이후에 ResponseEntity를 생성하거나 사용할 때 응답의 헤더 정보로 활용
		// HTTP 헤더는 키와 값의 쌍으로 구성
		
		System.out.println(member.toString() + " : 회원가입창에서 받아온 정보");
		System.out.println(member + " : 회원가입창에서 받아온 정보");
		System.out.println(member.getMemberId() + " : 회원가입창에서 받아온 id 정보");
		System.out.println(member.getAddress() + " : 회원가입창에서 받아온 id 정보");
		System.out.println(member.getSubaddress() + " : 회원가입창에서 받아온 id 정보");
		System.out.println(member.getZipcode() + " : 회원가입창에서 받아온 id 정보");
		System.out.println(member.getHp1() + " : 회원가입창에서 받아온 id 정보");
		System.out.println(member.getMemberPw() + " : 회원가입창에서 받아온 id 정보");
		
		
		
		responseHeaders.add("Content-Type", "text/html; charset=utf-8");
		// KEY, VALUE값으로 Content-Type 헤더를 설정
		// 클라이언트에게 응답의 데이터 유형과 문자 인코딩 방식을 알려줌
		
		
		try {
			// 에러가 나지 않았을 경우 로그인 페이지로 리다이렉트
		    memberService.addMember(member);		
		    message  = "<script>";
		    message +=" alert('환영합니다!! 로그인후 사용해주세요!!');";
		    message += " location.href='"+request.getContextPath()+"/member/loginForm.do';";
		    message += " </script>";
		    // location.href - JavaScript에서 현재 창의 URL을 변경하여 다른 페이지로 이동하는 역할
		    // 브라우저의 주소창 URL을 변경하고, 그에 따라 해당 URL로 페이지를 로드
		    
		    // request.getContextPath() - 현재 웹 애플리케이션의 컨텍스트 경로를 가져오는 메서드
		    
		}catch(Exception e) {
			// 에러가 났을 경우 회원가입페이지로 리다이렉트
			message  = "<script>";
		    message +=" alert('아이디, 비밀번호의 조건이 안맞거나 입력되지 않은 곳이 있습니다. \\n다시 입력해주세요');";
		    message += " location.href='"+request.getContextPath()+"/member/memberForm.do';";
		    message += " </script>";
			e.printStackTrace();
		}
		
		resEntity =new ResponseEntity(message, responseHeaders, HttpStatus.OK);
		// ResponseEntity - 사용자에게 응답을 전송하는데 사용
		// 응답 본문, 헤더, 상태 코드 등을 자세히 제어
		// 응답 본문(Response Body) : * 클라이언트에게 전달할 실제 데이터나 내용을 포함
		// 						   * 문자열, JSON객체, XML등 다양한 형식의 데이터를 응답 본문으로 전송가능	
		
		// 응답 헤더(Response Headers) : * 응답에 대한 추가 정보를 제공하는 헤더 설정, HttpHeaders객체를 사용하여 헤더를 추가
		// HTTP응답 상태코드(HTTP Status Code) : 요청의 처리 결과를 나타내는 HTTP응답 상태코드를 설정
		// ex) 'HttpStatus.OK', 'HttpStatus.CREATED', 'HttpStatus.BAD_REQUEST'
		return resEntity;
	}
	
	//아이디 중복확인
	@Override
	@RequestMapping(value="/checkDuplicateId.do" ,method = RequestMethod.GET)
	public ResponseEntity checkDuplicateId(@RequestParam("memberId") String memberId,HttpServletRequest request, HttpServletResponse response) throws Exception{
		ResponseEntity resEntity = null;
		
		System.out.println(memberId + " : 중복체크로 받아온 아이디");
		boolean result = memberService.checkDuplicateId(memberId);
		System.out.println(result + " : boolean타입으로 받아온 아이디 중복 여부(true이면 중복)");
		
		if(result==true) {			
			return resEntity = new ResponseEntity("duplicate", HttpStatus.OK);
			// ResponseEntity 생성자에 responseHeaders를 명시적으로 지정하지 않은 경우에도 기본적으로 Content-Type 헤더가 자동으로 설정
		}else {			
			return resEntity = new ResponseEntity("AvailableId", HttpStatus.OK);
		}
	}
}
