package com.lianjia.common;

import java.util.EnumSet;
import java.util.HashMap;
import java.util.Map;

/**
 * 该信息必须严格与table_code表的数据对应,切记！切记
 * @author homelink
 *
 */
public enum CancleEnum 
{
	//weight  权重       0 共享  1 历史
	
	
	
	PhoneNumError("号码有误",Constants.Cancle_type_notInterview,1,1),
	ParentNotAllow("家里人不同意",Constants.Cancle_type_notInterview,2,0),
	HasJob("已经找到其他工作",Constants.Cancle_type_notInterview,3,1),
	HastemporaryThings("临时有事",Constants.Cancle_type_notInterview,4,0),
	NotAnswerThePhone("拒接电话",Constants.Cancle_type_notInterview,5,1),
	BeenCutOff("被切户了",Constants.Cancle_type_notInterview,6,1),
	NotConsider("不考虑了",Constants.Cancle_type_notInterview,7,1),
	
	NotPassInterview("初试未通过",Constants.Cancle_type_noPassInterview,10,1),
	
	NoComeInterview("初试未参加",Constants.Cancle_type_NoComeInterview,11,0),
	
	notPassEagleEye("鹰眼复试未通过",Constants.Cancle_type_NotPassEagleEye,20,1),
	
	notComeEagleEye("鹰眼复试未参加",Constants.Cancle_type_NotComeEagleEye,21,0),
	
	NotTrain("未参加培训",Constants.Cancle_type_notTrain,30,0),
	
	NoPassTrain_GuaKe("考试挂科淘汰",Constants.Cancle_type_noPassTrain,31,1),
	NoPassTrain_ZuoBi("考试作弊淘汰",Constants.Cancle_type_noPassTrain,32,1),
	NoPassTrain_BangZhuZuoBi("帮助作弊淘汰",Constants.Cancle_type_noPassTrain,33,1),
	NoPassTrain_DingZhuangJiaoGuan("顶撞教官或班主任",Constants.Cancle_type_noPassTrain,34,1),
	NoPassTrain_ZhuDongTuiChu("主动退出",Constants.Cancle_type_noPassTrain,35,1),
	NoPassTrain_XiYan("在非定点区域吸烟",Constants.Cancle_type_noPassTrain,36,1),
	NoPassTrain_Weiji("违纪淘汰",Constants.Cancle_type_noPassTrain,37,1),
	NoPassTrain_Other("其他(培训淘汰原因)",Constants.Cancle_type_noPassTrain,38,1),
	
	NotEntry("没有入职",Constants.Cancle_type_noEntry,40,0);
	
	//淘汰原因
	private String name;
	
	//淘汰原因分组
	private String group;
		
	//淘汰原因code
	private int cancleCode;
	
	//该原因是放入历史信息还是共享信息
	private int weight;
	
	private static final Map<Integer, CancleEnum> dmap = new HashMap<Integer, CancleEnum>();
	
	static
	{
		for(CancleEnum c : EnumSet.allOf(CancleEnum.class))
		{
			dmap.put(c.getCancleCode(),c);
		}
	}
	
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getGroup() {
		return group;
	}

	public void setGroup(String group) {
		this.group = group;
	}

	public int getCancleCode() {
		return cancleCode;
	}

	public void setCancleCode(int cancleCode) {
		this.cancleCode = cancleCode;
	}

	public int getWeight() {
		return weight;
	}

	public void setWeight(int weight) {
		this.weight = weight;
	}

	CancleEnum(String name,String group,int cancleCode,int weight)
	{
		this.name = name;
		this.group = group;
		this.cancleCode = cancleCode;
		this.weight = weight;
	}
	
	/**
	 * 通过取消编码获取取消对象
	 * @param code
	 * @return
	 */
	public static CancleEnum getByCode(Integer code)
	{
		return dmap.get(code);		
	}

}
