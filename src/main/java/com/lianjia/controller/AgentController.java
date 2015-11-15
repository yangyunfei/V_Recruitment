package com.lianjia.controller;

import com.jfinal.aop.Before;
import com.jfinal.aop.Clear;
import com.jfinal.core.Controller;
import com.jfinal.kit.StrKit;
import com.lianjia.common.ResponseResult;
import com.lianjia.interceptor.AuthenticationInterceptor;
import com.lianjia.model.Agent;

@Before(AuthenticationInterceptor.class)
public class AgentController extends Controller 
{
	public void view()
	{
		ResponseResult result= new ResponseResult(false, "添加失败", null);
		renderJson(result);
	}
	
	@Clear
	public void agentView() {
		String pager;
		if (!StrKit.isBlank(this.getPara())) {
			pager = this.getPara(0);
		} else {
			pager = this.getPara("pager");
		}
		Agent agent = Agent.dao.findById(pager);
		setAttr("agent", agent);
		render("/vzp/agent/agentDetail.jsp");
	}
}
