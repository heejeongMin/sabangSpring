package com.dto;

public class HcodeDTO {
	public String lastCode;

	public String getLastCode() {
		return lastCode;
	}
	

	public HcodeDTO(String lastCode) {
		super();
		this.lastCode = lastCode;
	}


	public HcodeDTO() {
		super();
		// TODO Auto-generated constructor stub
	}


	public void setLastCode(String lastCode) {
		this.lastCode = lastCode;
	}

	@Override
	public String toString() {
		return "HcodeDTO [lastCode=" + lastCode + "]";
	}
	
	
	
	

}
