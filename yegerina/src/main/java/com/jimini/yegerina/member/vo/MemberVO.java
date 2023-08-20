package com.jimini.yegerina.member.vo;

import java.sql.Date;

import org.springframework.stereotype.Component;

@Component("memberVO")
public class MemberVO {
	private String memberId; // 회원 아이디
	private String memberName; // 회원 이름
	private String memberPw; // 비밀번호
	private String hp1; // 휴대폰번호
	private String zipcode; // 우편번호
	private String address; // 주소
	private String subaddress; // 상세주소
	private Date joinDate; // 회원가입일자
	private String del_yn; // 회원탈퇴유무
	private String naverLogin; // 네이버 아이디


	public MemberVO() {
	}


	public String getNaverLogin() {
		return naverLogin;
	}


	public void setNaverLogin(String naverLogin) {
		this.naverLogin = naverLogin;
	}


	public String getMemberId() {
		return memberId;
	}


	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}


	public String getMemberName() {
		return memberName;
	}


	public void setMemberName(String memberName) {
		this.memberName = memberName;
	}


	public String getMemberPw() {
		return memberPw;
	}


	public void setMemberPw(String memberPw) {
		this.memberPw = memberPw;
	}


	public String getHp1() {
		return hp1;
	}


	public void setHp1(String hp1) {
		this.hp1 = hp1;
	}


	public String getZipcode() {
		return zipcode;
	}


	public void setZipcode(String zipcode) {
		this.zipcode = zipcode;
	}


	public String getAddress() {
		return address;
	}


	public void setAddress(String address) {
		this.address = address;
	}


	public String getSubaddress() {
		return subaddress;
	}


	public void setSubaddress(String subaddress) {
		this.subaddress = subaddress;
	}


	public Date getJoinDate() {
		return joinDate;
	}


	public void setJoinDate(Date joinDate) {
		this.joinDate = joinDate;
	}


	public String getDel_yn() {
		return del_yn;
	}


	public void setDel_yn(String del_yn) {
		this.del_yn = del_yn;
	}


	

}
