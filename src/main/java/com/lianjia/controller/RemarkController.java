package com.lianjia.controller;

import com.jfinal.core.Controller;
import com.lianjia.common.ResponseResult;

public class RemarkController extends Controller 
{
	public void add() 
	{
		ResponseResult result= new ResponseResult(false, "添加失败", null);
		renderJson(result);
	}
}
