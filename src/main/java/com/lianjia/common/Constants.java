package com.lianjia.common;

public class Constants {

	/**
	 * 后台
	 * 请求attr中放置user的中得key
	 */
	public static final String Controller_SESSION_User_Key = "Controller_User_Key";
	
	
	/**
	 * 微信
	 * 请求attr中放置wechatuser的中得key
	 */
	public static final String Controller_SESSION_WeChat_User_Key = "Controller_WeChat_User_Key";
	public static final String OPEN_ID = "OPEN_ID";

	/**
	 * 分页使用
	 */
	public static final int PAGESIZE_DEFAULT = 10;

	public static final int PAGENUM_DEFAULT = 1;

	/**
	 * 前台传递的页码,页码容量key
	 */
	public static final String PAGENUM = "pagenum";

	public static final String PAGESIZE = "pagesize";

	/**
	 * 定义分页默认设置
	 */
	public static final int Page_Size_Default = 5;
	public static final int Page_Num_Default = 1;

	public static final String SplitStr = ",";
	public static final String SQLFieldStr = "_field";
	
	
	/**
	 * 待处理
	 */
	public static final int STATE_SUSPENDING = 1;
	/**
	 * 待初试
	 */
	public static final int STATE_WAIT_FIRSTINTERVIEW = 2;
	/**
	 * 待复试
	 */
	public static final int STATE_WAIT_SECONDINTERVIEW = 3;
	/**
	 * 待培训
	 */
	public static final int STATE_WAIT_TRAIN = 4;
	/**
	 * 待入职
	 */
	public static final int STATE_WAIT_ENTRANT = 5;
	
	/**
	 * 已入职
	 */
	public static final int STATE_HAS_ENTRANT = 6;
	/**
	 * 已失效
	 */
	public static final int STATE_INVALID = -1;
	
	
	
	public static final String RECRUIT_CLICK_EVENTKEY  = "http://spartacus.pagekite.me/V_Recruitment/weixin/presenteeController/recruit";
	

}
