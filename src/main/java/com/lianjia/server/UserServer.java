package com.lianjia.server;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.jfinal.log.Logger;
import com.lianjia.common.AnalysisBean;
import com.lianjia.model.User;

public class UserServer 
{
	public static final UserServer server = new UserServer();
	
	private static Logger logger = Logger.getLogger(UserServer.class);
	
	public static final User dao = User.dao;
	
	
	public Map<String,Object> getAnalysisInfo(User user)
	{
		Map<String, Object> result = new HashMap<String, Object>();
		List<Object> totalUsercollect = dao.getTotalUsercollectList(user);	
		AnalysisBean bean = new AnalysisBean();
		for(int i=0; i < totalUsercollect.size(); i++)
		{
			Object[] record = (Object[]) totalUsercollect.get(i);
			int state = (int) record[0];
			long count = (long) record[1];
			bean.setData(state, count);
		}	
		List<Object> usercollect = dao.getUsercollectList(user);
		List<AnalysisBean> monthList = new ArrayList<AnalysisBean>();
		Map<String,AnalysisBean> dataMap = new HashMap<String,AnalysisBean>();
		for(int i=0; i < usercollect.size(); i++)
		{
			AnalysisBean bean2 = null;
			Object[] record = (Object[]) usercollect.get(i);
			String date= (String) record[0];
			int state = (int) record[1];
			long count = (long) record[2];
			if(null == dataMap.get(date))
			{
				bean2 = new AnalysisBean();
				bean2.addTotal(count);
				dataMap.put(date, bean2);
			}
			else
			{
				bean2 = dataMap.get(date);
				bean2.addTotal(count);
			}
			
			bean2.setData(state, count);
			bean2.setDate(date);
			if(!monthList.contains(bean2))
			{
				monthList.add(bean2);
			}
		}
		result.put("monthList",monthList);
		result.put("totalBean",bean);
		result.put("total",user.getTotalRecruit());	
		return result;
	}

}
