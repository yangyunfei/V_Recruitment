package com.lianjia.common;

public class ResponseResult 
{
	private int code = 0;
	
	private boolean success = false;

	private String msg = "";

	private Object obj = null;
	
	public ResponseResult(boolean success,String msg,Object obj)
	{
		this.success=success;
		this.msg=msg;
		this.obj=obj;
	}
	
	public ResponseResult() 
	{
		
	}

	public int getCode() {
		return code;
	}

	public void setCode(int code) {
		this.code = code;
	}

	public boolean isSuccess() {
		return success;
	}

	public void setSuccess(boolean success) {
		this.success = success;
	}

	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}

	public Object getObj() {
		return obj;
	}

	public void setObj(Object obj) {
		this.obj = obj;
	}	
	
	

}
