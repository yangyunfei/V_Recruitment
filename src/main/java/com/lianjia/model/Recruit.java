package com.lianjia.model;

import com.jfinal.plugin.activerecord.Model;

public class Recruit extends Model<Recruit>
{
	private static final long serialVersionUID = 4470629640649976696L;
	
	public static final Recruit dao = new Recruit();
	
	public boolean validateBelongtoUser(User user)
	{
		//该招聘任务所属人
		long handling_id = getLong("handleman").longValue();
		long user_id = user.getLong("id").longValue();
		//该发起请求人
		return handling_id == user_id ? true : false ;
	}
	
	public boolean validateState(int State)
	{
		//该招聘任务所属人
		int handling_id = getInt("state").intValue();
		return handling_id == State ? true : false ;
	}

}
