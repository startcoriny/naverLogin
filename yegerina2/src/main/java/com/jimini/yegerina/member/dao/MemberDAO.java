package com.jimini.yegerina.member.dao;

import java.util.Map;

import org.springframework.dao.DataAccessException;

import com.jimini.yegerina.member.vo.MemberVO;

public interface MemberDAO {

	public MemberVO login(Map loginMap) throws DataAccessException;
	public void insertNewMember(MemberVO memberVO) throws DataAccessException;
	boolean selectcheckDuplicateId(String id) throws DataAccessException;
	public MemberVO naverConnectionCheck(Map<String, Object> apiJson) throws Exception;
	public MemberVO userNaverLoginPro(Map<String, Object> apiJson) throws Exception;
	public void setNaverConnection(Map<String, Object> apiJson)throws Exception;
	public int userNaverRegisterPro(Map<String, Object> paramMap)throws Exception;
}
