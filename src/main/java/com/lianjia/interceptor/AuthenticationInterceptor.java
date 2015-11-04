package com.lianjia.interceptor;

import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.jfinal.aop.Interceptor;
import com.jfinal.aop.Invocation;
import com.jfinal.core.Controller;
import com.lianjia.common.Constants;
import com.lianjia.model.Module;
import com.lianjia.model.User;

public class AuthenticationInterceptor implements Interceptor{

	@Override
	public void intercept(Invocation ai) {
		Controller controller = ai.getController();
//		HttpServletRequest request = controller.getRequest();
//		HttpServletResponse response = controller.getResponse();
		String uri = ai.getActionKey();
		User user = controller.getSessionAttr("user");
		if(user == null){
			controller.redirect("/login.jsp");
			return;
		}
		controller.setAttr(Constants.Controller_SESSION_User_Key, user);
		//如果不在模块表中的，就直接放行
		Module module=  Module.dao.getUrl(uri);
		if(module==null)  
			{
		     	ai.invoke(); 	 
			   return;
			}
		Set<Module> mods = controller.getSessionAttr("modules");
		if(mods==null)
		{
			controller.redirect("/login.jsp");
			return;
		}
		if(mods.contains(module))
			ai.invoke(); 	
		else
			controller.renderError(404);
		}
}
