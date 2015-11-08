package com.lianjia.model;


import com.jfinal.plugin.activerecord.Model;


public class WechatUser extends Model<WechatUser> {

	private static final long serialVersionUID = 181334933039834956L;
	public static final WechatUser dao = new WechatUser();
	
	public void setAgentInfo() 
	{
		Agent agent = Agent.dao.findById(getStr("pager"));
		if(null != agent)
		{
			put("name",agent.getStr("name"));
			put("mobile",agent.getStr("mobile"));
			put("title",agent.getStr("title"));	
		}	
	}
}
