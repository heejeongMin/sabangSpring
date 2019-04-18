package com.dto;

public class MemberDTO {
	
	private String userid;
	private String passwd;
	private String ssn;
	private String username;
	private String post;
	private String addr;
	private String phone;
	private String email;
	private String email1;
	private String email2;
	private char agent;
	private String ssn1;
	private String ssn2;
	private String phone1;
	private String phone2;
	private String phone3;
	
	public MemberDTO() {
		super();
		// TODO Auto-generated constructor stub
	}
	public MemberDTO(String userid, String passwd, String phone) {
		super();
		this.userid = userid;
		this.passwd = passwd;
		this.phone = phone;
	}
	
	
	
	

	
	
	
	public MemberDTO(String userid, String passwd, String ssn, String username, String post, String addr, String phone,
			String email, String email1, String email2, char agent, String ssn1, String ssn2, String phone1,
			String phone2, String phone3) {
		super();
		this.userid = userid;
		this.passwd = passwd;
		this.ssn = ssn;
		this.username = username;
		this.post = post;
		this.addr = addr;
		this.phone = phone;
		this.email = email;
		this.email1 = email1;
		this.email2 = email2;
		this.agent = agent;
		this.ssn1 = ssn1;
		this.ssn2 = ssn2;
		this.phone1 = phone1;
		this.phone2 = phone2;
		this.phone3 = phone3;
	}
	public MemberDTO(String userid, String passwd, String ssn, String username, String post, String addr, String phone,
			String email, char agent) {
		super();
		this.userid = userid;
		this.passwd = passwd;
		this.ssn = ssn;
		this.username = username;
		this.post = post;
		this.addr = addr;
		this.phone = phone;
		this.email = email;
		this.agent = agent;
	}
	public MemberDTO(String userid, String passwd, String ssn, String username, String post, String addr, String phone,
			String email) {
		super();
		this.userid = userid;
		this.passwd = passwd;
		this.ssn = ssn;
		this.username = username;
		this.post = post;
		this.addr = addr;
		this.phone = phone;
		this.email = email;
	}

	
	
	
	public String getUserid() {
		return userid;
	}

	public void setUserid(String userid) {
		this.userid = userid;
	}

	public String getPasswd() {
		return passwd;
	}

	public void setPasswd(String passwd) {
		this.passwd = passwd;
	}

	public String getSsn() {
		return ssn;
	}

	public void setSsn(String ssn) {
		this.ssn = ssn;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPost() {
		return post;
	}

	public void setPost(String post) {
		this.post = post;
	}

	public String getAddr() {
		return addr;
	}

	public void setAddr(String addr) {
		this.addr = addr;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public char getAgent() {
		return agent;
	}
	public void setAgent(char agent) {
		this.agent = agent;
	}
	@Override
	public String toString() {
		return "MemberDTO [userid=" + userid + ", passwd=" + passwd + ", ssn=" + ssn + ", username=" + username
				+ ", post=" + post + ", addr=" + addr + ", phone=" + phone + ", email=" + email + ", email1=" + email1
				+ ", email2=" + email2 + ", agent=" + agent + ", ssn1=" + ssn1 + ", ssn2=" + ssn2 + ", phone1=" + phone1
				+ ", phone2=" + phone2 + ", phone3=" + phone3 + "]";
	}
	public String getEmail1() {
		return email1;
	}
	public void setEmail1(String email1) {
		this.email1 = email1;
	}
	public String getEmail2() {
		return email2;
	}
	public void setEmail2(String email2) {
		this.email2 = email2;
	}
	public String getSsn1() {
		return ssn1;
	}
	public void setSsn1(String ssn1) {
		this.ssn1 = ssn1;
	}
	public String getSsn2() {
		return ssn2;
	}
	public void setSsn2(String ssn2) {
		this.ssn2 = ssn2;
	}
	public String getPhone1() {
		return phone1;
	}
	public void setPhone1(String phone1) {
		this.phone1 = phone1;
	}
	public String getPhone2() {
		return phone2;
	}
	public void setPhone2(String phone2) {
		this.phone2 = phone2;
	}
	public String getPhone3() {
		return phone3;
	}
	public void setPhone3(String phone3) {
		this.phone3 = phone3;
	}
	
	

	
	
	
	
	
}
