package com.lianjia.controller;

import com.jfinal.core.Controller;
import com.lianjia.common.ResponseResult;

public class LoginController extends Controller 
{
	public void login() 
	{
		ResponseResult result= new ResponseResult(false, "添加失败", null);
		renderJson(result);
	}

}
