package com.lianjia.controller;

import com.jfinal.core.Controller;
import com.lianjia.common.ResponseResult;

public class EmployeeControll extends Controller 
{
	public void add()
	{
		ResponseResult result= new ResponseResult(false, "添加失败", null);
//		model.addAttribute("educationLevel",educationLevel);
//		model.addAttribute("schoolLevels",schoolLevel);
		render("/WEB-INF/jsp/assistantMain.jsp");
	}
}
