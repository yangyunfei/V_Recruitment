package com.lianjia.model;


import java.util.List;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Model;
import com.jfinal.plugin.activerecord.Record;
import com.lianjia.common.Constants;


public class User extends Model<User> {

	private static final long serialVersionUID = 181334933039834956L;
	public static final User dao = new User();
	
	
	/**
	 * 是否已经到达收藏最大限度
	 * @return
	 */
	public boolean validateHasAttachMaxNum() {
		User user = dao.findById(getLong("id"));
		int maxNum = user.getInt("handleMaxNum").intValue();
		Long userCount = Db.queryLong("select count(*) from recruit where state = "+ Constants.STATE_SUSPENDING +" AND handleman =  ?", getLong("id"));
		return userCount.longValue()>=maxNum ? true : false;
	}
	
	public List<Object> getUsercollectList(User user)
	{
		List<Object> query = Db.query("SELECT DATE_FORMAT(createtime,'%Y-%m') AS TIME,state,COUNT(*) as count  FROM recruit  WHERE  handleman = ?  GROUP BY state,TIME ORDER BY TIME DESC", user.getLong("id"));
		return query;
	}
	
	public List<Object> getTotalUsercollectList(User user)
	{
		List<Object> query = Db.query("select state,count(*) as count from recruit where  handleman =  ? GROUP BY state ", user.getLong("id"));
		return query;
	}
	
	public Long getTotalRecruit()
	{
		return Db.queryLong("select count(*) from recruit where handleman =  ?", getLong("id"));
	}
	
	
	
	

}
