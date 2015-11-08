package com.lianjia.interceptor;

import com.jfinal.aop.Interceptor;
import com.jfinal.aop.Invocation;
import com.jfinal.core.Controller;
import com.lianjia.common.Constants;
import com.lianjia.model.WechatUser;




public class WeixinAuthenticationInterceptor implements Interceptor
{
	
	
	@Override
	public void intercept(Invocation inv) 
	{
		Controller controller = inv.getController();
		WechatUser wechatUser = (WechatUser)controller.getSessionAttr(Constants.Controller_SESSION_WeChat_User_Key);
		if (null == wechatUser)
		{
			controller.render("/weixin/login.jsp");
			return;
		}		
		inv.invoke();
		
	}

}
