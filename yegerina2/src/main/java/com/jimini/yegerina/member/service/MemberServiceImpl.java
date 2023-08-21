package com.jimini.yegerina.member.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.jimini.yegerina.member.dao.MemberDAO;
import com.jimini.yegerina.member.vo.MemberVO;



@Service("memberService")
// Spring Framework에서 비즈니스 로직을 담당하는 서비스 클래스를 나타내는데 사용

@Transactional(propagation=Propagation.REQUIRED)
// AOP (Aspect-Oriented Programming) 기능 중 하나
// 트랜잭션을 관리하기 위해 사용되는 어노테이션
// 메서드 레벨에 붙여서 해당 메서드 내에서 트랜잭션을 시작하고 관리
// 트랜잭션은 데이터베이스 작업 등과 같이 여러 단계가 연속적으로 수행되어야 하는 작업들을 논리적으로 하나의 작업으로 묶어주는 개념
// 메서드 또는 클래스 내에서 정의된 작업들을 하나의 트랜잭션으로 묶어주고, 
// 이 트랜잭션의 일부 작업이 실패하면 전체 트랜잭션을 롤백하여 데이터의 일관성을 유지

// propagation : 트랜잭션 전파 방식을 설정하는 데 사용
// 트랜잭션 전파 방식은 메서드가 이미 실행 중인 트랜잭션을 재사용할지, 새로운 트랜잭션을 시작할지 결정하는 데 도움이 됨

// Propagation.REQUIRED
// 현재 실행 중인 트랜잭션이 있다면, 해당 트랜잭션을 사용하여 메서드를 실행
// 현재 실행 중인 트랜잭션이 없다면, 새로운 트랜잭션을 시작하여 메서드를 실행
// 가장 일반적으로 사용되는 트랜잭션 전파 방식
// 메서드가 독립적으로 실행되거나, 다른 메서드 내에서 호출될 때, 그리고 특히 서비스 메서드에서 데이터베이스 업데이트 등의 작업을 할 때 유용

public class MemberServiceImpl implements MemberService {
	
	@Autowired
	private MemberDAO memberDAO;
	// MemberDAO 클래스의 인스턴스를 자동으로 주입
	
	
	// 로그인
	@Override
	public MemberVO login(Map loginMap) throws Exception{
		System.out.println(loginMap + " : memberservice에 들어온 ID,PW");
		System.out.println(loginMap.toString() + " : toString으로 확인한 서비스에들어온 ID,PW");
		System.out.println(loginMap.get("member_id") + " : 들어온 id확인(service)");

		return memberDAO.login(loginMap);
	}
	
	// 회원 가입
	@Override
	public void addMember(MemberVO memberVO) throws Exception{
		memberDAO.insertNewMember(memberVO);
	}

	// 아이디 중복체크
	@Override
	public boolean checkDuplicateId(String memberId) throws Exception{
		boolean result = memberDAO.selectcheckDuplicateId(memberId);
		System.out.println(result + " : dao에서 서비스로 넘어온 true,false값");
		return result;
	}
	
	// 네이버 아이디 체크
	public MemberVO naverConnectionCheck(Map<String, Object> apiJson) throws Exception{
		MemberVO naverConnectionCheck = memberDAO.naverConnectionCheck(apiJson);
		System.out.println("서비스로 넘어온 네이버커넥션체크 : " + naverConnectionCheck);
		return naverConnectionCheck;
	}

	
	// 네이버로 가입된 계정 일시
	public MemberVO userNaverLoginPro(Map<String, Object> apiJson) throws Exception{
		MemberVO userNaverLoginPro = memberDAO.userNaverLoginPro(apiJson);
		return userNaverLoginPro;
	}
	
	
	// 일반회원이면서 네이버 로그인은 안되어 있을시
	public void setNaverConnection(Map<String, Object> apiJson)throws Exception{
		memberDAO.setNaverConnection(apiJson);
	}

	// 네이버 신규회원가입
	public int userNaverRegisterPro(Map<String, Object> paramMap)throws Exception{
		return memberDAO.userNaverRegisterPro(paramMap);
	}
}
