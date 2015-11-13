package com.lianjia.model;


import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Model;
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
}
