package com.jimini.yegerina.member.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import com.jimini.yegerina.member.vo.MemberVO;

@Repository("memberDAO")
public class MemberDAOImpl implements MemberDAO {

	@Autowired
	private SqlSession sqlSession;	
	// SqlSession 클래스의 인스턴스를 자동으로 주입
	// MyBatis 프레임워크에서 데이터베이스와 상호작용하는 핵심 객체
	// MyBatis는 SQL 매핑과 데이터베이스 연동을 쉽게 수행할 수 있도록 도와주는 프레임워크
	// SqlSession을 통해 데이터베이스 쿼리를 실행하고 결과를 받아옴
	
	// 로그인
	@Override
	public MemberVO login(Map loginMap) throws DataAccessException{
		System.out.println(loginMap + " : memberDAO에 들어온 ID,PW");
		System.out.println(loginMap.toString() + " : toString으로 확인한 DAO에 들어온 ID,PW");
		System.out.println(loginMap.get("memberId") + " : 들어온 id확인(dao)");

		MemberVO member=(MemberVO)sqlSession.selectOne("mapper.member.login",loginMap);
		// mapper.member.login은 MyBatis의 네임스페이스와 SQL 매핑 구문의 ID, 해당 ID에 매핑된 SQL 문이 실행
		// selectOne 메서드는 결과가 단일 객체인 경우 해당 객체를 반환
		//
		System.out.println(member + " : member.XML을 다녀온 ID,PW");
	   return member;
	}

	
	// 회원가입
	@Override
	public void insertNewMember(MemberVO memberVO) throws DataAccessException {
		sqlSession.insert("mapper.member.insertNewMember",memberVO);
		// sqlSession.insert 데이터베이스에 새로운 레코드를 추가하는 데 사용
		// 추가된 레코드의 수를 반환
		
	}

	// 아이디 중복확인
	@Override
	public boolean selectcheckDuplicateId(String memberId) throws DataAccessException {
		System.out.println(memberId + " : dao까지 전달된 중복확인 아이디");
		
		String response =  sqlSession.selectOne("mapper.member.selectcheckDuplicateId",memberId);
		System.out.println(response + " : 조건문으로 판별한 memberID존재여부");
		
		boolean result = Boolean.parseBoolean(response);
		// 쿼리문에서 문자열로 넘어오기 때문에 String 타입의 객체에 저장한뒤 boolean타입으로 파싱
		
		System.out.println(result + " : 파싱한 memberID결과");
		return result;
		
	}
	
	
	
	  // 네이버 로그인 아이디확인 
	 public MemberVO naverConnectionCheck(Map<String, Object> apiJson) throws Exception{ 
	 System.out.println(apiJson +" : memberDAO에 들어온 네이버 로그인 정보@@@@@@@@@@"); 
	 MemberVO naverConnectionCheck = sqlSession.selectOne("mapper.member.naverConnectionCheck",apiJson); 
	 System.out.println("DAO에서 쿼리문돌고 나온 네이버커넥션체크 : " + naverConnectionCheck.toString());
	 
	 return naverConnectionCheck;
	 }
	 

	
	// 네이버로 가입된 계정 일시
	public MemberVO userNaverLoginPro(Map<String, Object> apiJson) throws Exception{
		System.out.println(apiJson + " : memberDAO에 들어온 네이버 로그인 정보@@@@@@@@@@");
		MemberVO userNaverLoginPro = sqlSession.selectOne("mapper.member.userNaverLoginPro",apiJson);
		return userNaverLoginPro;
	}

	
	// 일반회원이면서 네이버 로그인은 안되어 있을시
	public void setNaverConnection(Map<String, Object> apiJson)throws Exception{
		System.out.println("셋네이버커넥션 진입");
		sqlSession.insert("mapper.member.setNaverConnection",apiJson);
		System.out.println("셋네이버커넥션 나옴");
	}

	// 일반회원이면서 네이버 로그인은 안되어 있을시
	public int userNaverRegisterPro(Map<String, Object> paramMap)throws Exception{
		return sqlSession.insert("mapper.member.userNaverRegisterPro",paramMap);
	}
	


	
	
}
