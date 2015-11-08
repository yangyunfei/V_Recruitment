package com.lianjia.index;

import com.jfinal.core.Controller;
import com.lianjia.model.Agent;
import com.lianjia.server.UserVerificationServer;

public class IndexController extends Controller 
{
	public void index() 
	{
		render("/login.jsp");
	}
	
	
	public void TextUser() 
	{
		Agent user=UserVerificationServer.validate("20127268", "H0meL1nk");
		renderJson(user);
	}

}
