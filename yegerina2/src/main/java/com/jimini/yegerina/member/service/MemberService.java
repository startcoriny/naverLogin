package com.jimini.yegerina.member.service;

import java.util.Map;

import com.jimini.yegerina.member.vo.MemberVO;

public interface MemberService {
	public MemberVO login(Map  loginMap) throws Exception;
	public void addMember(MemberVO memberVO) throws Exception;
	boolean checkDuplicateId(String id) throws Exception;
	public MemberVO naverConnectionCheck(Map<String, Object> apiJson) throws Exception;
	public MemberVO userNaverLoginPro(Map<String, Object> apiJson) throws Exception;
	public void setNaverConnection(Map<String, Object> apiJson)throws Exception;
	public int userNaverRegisterPro(Map<String, Object> paramMap)throws Exception;
}
