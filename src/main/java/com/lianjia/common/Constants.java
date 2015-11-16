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
	 * 待处理 1 
	 */
	public static final int STATE_SUSPENDING = 1;
	/**
	 * 待初试 2
	 */
	public static final int STATE_WAIT_FIRSTINTERVIEW = 2;
	/**
	 * 待复试 3
	 */
	public static final int STATE_WAIT_SECONDINTERVIEW = 3;
	/**
	 * 待培训 4
	 */
	public static final int STATE_WAIT_TRAIN = 4;
	/**
	 * 待入职 5
	 */
	public static final int STATE_WAIT_ENTRANT = 5;
	
	/**
	 * 已入职 6
	 */
	public static final int STATE_HAS_ENTRANT = 6;
	/** 
	 * 已失效 -1
	 */
	public static final int STATE_INVALID = -1;
	
	
	
	//public static final String RECRUIT_CLICK_EVENTKEY  = "http://spartacus.pagekite.me/V_Recruitment/weixin/presenteeController/recruit";
	
	public static final String Record_accept = "该人员被收藏";
	
	public static final String Record_joinInterview = "初次确定面试时间";
	
	public static final String Record_EditInterview = "修改面试时间";
	
	public static final String Record_BreakOff = "初试取消";
	
	public static final String Record_Nopass = "初试没有通过";
	
	public static final String Record_Pass = "初试通过";

	public static final String Record_NoComeInterview = "没有来参加初试";
	
	public static final String Record_NotTrain = "没有参加培训";
	
	public static final String Record_GetOutTrain = "培训淘汰";
	
	public static final String Record_PassTrain = "通过培训";
	
	public static final String Record_Entry = "入职成功";
	
	public static final String Record_NotEntry = "未入职";
	
	
	public static final String Cancle_type_notInterview = "notInterview";
	public static final String Cancle_type_noPassInterview = "noPassInterview";
	public static final String Cancle_type_NoComeInterview = "NoComeInterview";
	public static final String Cancle_type_notTrain = "notTrain";
	public static final String Cancle_type_noPassTrain = "noPassTrain";
	public static final String Cancle_type_noEntry = "noEntry";
	

	
	

}
