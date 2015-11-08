package com.lianjia.server;

import com.jfinal.kit.StrKit;
import com.jfinal.log.Logger;
import com.lianjia.model.WechatUser;

public class WexinUserServer 
{
	public static final WexinUserServer server = new WexinUserServer();	
	
	private static Logger logger = Logger.getLogger(UserServer.class);
	
	
	public WechatUser getWeixinUserByOpenId(String openId)
	{
		if(StrKit.isBlank(openId)) return null;
		WechatUser wechatUser = WechatUser.dao.findFirst("SELECT id,pager,openid FROM wechatuser WHERE openid = ?",openId);
		if(null != wechatUser)
		{
			wechatUser.setAgentInfo();
		}
		return wechatUser;
	}
	
	
}
