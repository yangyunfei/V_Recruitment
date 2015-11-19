package com.lianjia.server;

import java.net.URLEncoder;


import com.lianjia.model.Agent;
import com.lianjia.util.Util;

import net.sf.json.JSONObject;

public class UserVerificationHttpServer 
{
		// 登录使用 start
		public static String LOGIN_URL = "http://172.16.5.33/HomeSE_house/j_security_check?";
		public static String LOGIN_URL_USERNAME = "j_username=";
		public static String LOGIN_URL_PWD = "&j_password=";
		// 登录使用 end

		
		public static Agent validate(String username, String password) 
		{
			Util util = new Util();
			StringBuffer url = new StringBuffer();
			url.append(LOGIN_URL);
			url.append(LOGIN_URL_USERNAME).append(username)
					.append(LOGIN_URL_PWD).append(URLEncoder.encode(password));
			String[] returnV = util.connect(url.toString());
			Agent agent = null;
			if ("200".equals(returnV[0])) 				
			{
				JSONObject jsonObject = JSONObject.fromObject(returnV[1]);
				agent = new Agent();
				JSONObject msg = (JSONObject)jsonObject.get("resultMsg");
				agent.set("pager", msg.get("employeeSN"));
				agent.set("mail", msg.get("email"));
				agent.set("name", msg.get("employeeName"));
				agent.set("title", msg.get("orgName"));
				agent.set("department", msg.get("wholeOrgName"));
				agent.set("sAMAccountName", msg.get("userName"));
				agent.set("mobile", msg.get("mobile"));
			}
			return agent;
		}
}
