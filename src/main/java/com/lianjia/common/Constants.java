package com.lianjia.common;

public  class Constants 
{
	/**
	 * 1:当前推广;2:库存;3:经纪人推荐;4:后台 5其它  6安卓客户端 7 苹果端
	 *
	 */
	 public static final int Source_Spead = 1;
	 public static final int Source_Repertory = 2;
	 public static final int Source_Agent = 3;
	 public static final int Source_BAM = 4;
	 public static final int Source_Other = 5;
	 public static final int Source_Android = 6;
	 public static final int Source_IOS = 7;
	 
	/*public enum Source
	{
		Spead(1),Repertory(2),Agent(3),BAM(4),Other(5),Android(6),IOS(7);
	    private final int nCode;
	    private Source(int _nCode)
	    {
	        this.nCode = _nCode;
	    }
	    @Override
	    public String toString()
	    {
	    	return String.valueOf(this.nCode);
	    }		
	};*/
	/**
	 *状态,1,正常客户，2 失效客户
	 *
	 */
	 public static final int State_Normal = 1;
	 public static final int State_Invalid = 2; 
	 
	 /**
		 *商铺状态,1,成交，2 未成交 3删除
		 *
		 */
		 public static final int Store_State_RentOut = 1;
		 public static final int Store_State_NoRent = 2; 
		 public static final int Store_State_Del = 3; 
	 
	 /**
	 * 0默认  1 价格由低到高   2 价格由高到低
	 */
	public static final int Sort_Default = 0;
	 public static final int Sort_Price_ASC = 1;
	 public static final int Sort_Price_DESC  = 2;
	 
	 /**
	 * 定义分页默认设置
	 */
	public static final int Page_Size_Default = 5;
	 public static final int Page_Num_Default  = 1;
	 
	 public static final String Image_NoFind="NoImage.jpg";
	 
	 public static final String SplitStr=",";
	 public static final String SQLFieldStr="_field";

	 //永久缓存
      public static final String Cache_ForEver="system";
      //非永久缓存
      public static final String Cache_OneHour="SimplePageCachingFilter";
	 
}
