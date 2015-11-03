package com.lianjia.controller.weichat;

import com.jfinal.core.Controller;
import com.lianjia.common.ResponseResult;

public class PresenteeControll extends Controller 
{
	public void toadd()
	{
		//ResponseResult result= new ResponseResult(false, "添加失败", null);
//		model.addAttribute("educationLevel",educationLevel);
//		model.addAttribute("schoolLevels",schoolLevel);
		render("/WEB-INF/jsp/assistantMain.jsp");
	}
}
