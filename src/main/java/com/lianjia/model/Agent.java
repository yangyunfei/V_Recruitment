package com.lianjia.model;

import com.jfinal.plugin.activerecord.Model;

public class Agent extends Model<Agent> {


	private static final long serialVersionUID = -6080960523096072292L;
	
	public static final Agent dao = new Agent();

	/**   
	 * 跟新经纪人信息
	 * @param agentElement 数据库中的信息
	 * @param agent 新查出来的信息
	 * @author yangyunfei
	 * @created 2015年11月8日 下午5:11:12
	 */
	public static void updateInfo(Agent agentElement, Agent agent) 
	{
		//属性  mail  name title department sAMAccountName  mobile  
		
		//是否需要更新属性
		boolean flag = false;
		//mail
		if(!agentElement.getStr("mail").equals(agent.getStr("mail")))
		{
			flag = flag||true;
			agentElement.set("mail", agent.getStr("mail"));
		}
		//name
		if(!agentElement.getStr("name").equals(agent.getStr("name")))
		{
			flag = flag||true;
			agentElement.set("name", agent.getStr("name"));
		}
		//title
		if(!agentElement.getStr("title").equals(agent.getStr("title")))
		{
			flag = flag||true;
			agentElement.set("title", agent.getStr("title"));
		}
		//department
		if(!agentElement.getStr("department").equals(agent.getStr("department")))
		{
			flag = flag||true;
			agentElement.set("department", agent.getStr("department"));
		}
		//sAMAccountName
		if(!agentElement.getStr("sAMAccountName").equals(agent.getStr("sAMAccountName")))
		{
			flag = flag||true;
			agentElement.set("sAMAccountName", agent.getStr("sAMAccountName"));
		}
		//mobile
		if(!agentElement.getStr("mobile").equals(agent.getStr("mobile")))
		{
			flag = flag||true;
			agentElement.set("mobile", agent.getStr("mobile"));
		}
		//是否需要更新
		if(flag)
		{
			agentElement.update();
		}			
	}

}
