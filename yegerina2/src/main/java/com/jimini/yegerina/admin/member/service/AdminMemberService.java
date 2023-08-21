package com.jimini.yegerina.admin.member.service;

import java.util.ArrayList;
import java.util.HashMap;

import com.jimini.yegerina.member.vo.MemberVO;

public interface AdminMemberService {
	public ArrayList<MemberVO> listMember(HashMap condMap) throws Exception;
}
