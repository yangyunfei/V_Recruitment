package com.lianjia.interceptor;

import net.sf.json.JSONObject;

import com.gson.oauth.Oauth;
import com.jfinal.aop.Interceptor;
import com.jfinal.aop.Invocation;
import com.jfinal.core.Controller;
import com.jfinal.kit.StrKit;
import com.jfinal.weixin.sdk.api.AccessToken;
import com.jfinal.weixin.sdk.api.SnsAccessTokenApi;
import com.lianjia.common.Constants;
import com.lianjia.model.WechatUser;
import com.lianjia.server.WexinUserServer;




public class WeixinSessionInterceptor implements Interceptor
{

	
	public static final Oauth oauth = new Oauth();
	
	@Override
	public void intercept(Invocation inv) 
	{
		Controller controller = inv.getController();
		String code = controller.getPara("code");
		if (StrKit.isBlank(code))
		{
			controller.renderText("服务器繁忙,请关掉浏览器,重新点击");
			return;
		}		
		try {
			AccessToken accessToken = SnsAccessTokenApi.getAccessToken(code);			
			String openid = (String) JSONObject.fromObject(accessToken.getJson()).get("openid");
			if(StrKit.isBlank(openid))
			{
				controller.renderText("网络错误,请关掉浏览器,重新点击");
				return;
			}			

        	WechatUser wechatUser = WexinUserServer.server.getWeixinUserByOpenId(openid);
        	if(null != wechatUser)
        	{      		     		
        		if(StrKit.isBlank(wechatUser.getStr("pager")))
        		{
        			controller.setSessionAttr(Constants.OPEN_ID, openid);
        			controller.render("/weixin/login.jsp");
    				return;
        		}
        		controller.setSessionAttr(Constants.OPEN_ID, openid);
    			controller.setSessionAttr(Constants.Controller_SESSION_WeChat_User_Key, wechatUser);
        		inv.invoke();
  		
        	}
        	else
        	{
        		controller.setSessionAttr(Constants.OPEN_ID, openid);
        		controller.render("/weixin/login.jsp");
        	}
	        
		}
		catch (Exception e) 
		{			
			controller.renderText("网络错误,请关掉浏览器,重新点击");
			e.printStackTrace();
		}
		
	}

}
