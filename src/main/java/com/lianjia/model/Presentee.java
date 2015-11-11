package com.lianjia.model;

import com.jfinal.plugin.activerecord.Model;

public class Presentee extends Model<Presentee>
{
	private static final long serialVersionUID = 4470629640649976696L;
	
	public static final Presentee dao = new Presentee();

	public void toDetailshow() 
	{
		
		
	}

	/**
	 * 该人员已被有人处理
	 * @return
	 */
	public boolean validateHasHandleman() 
	{	
		return getLong("handleman").longValue() == 0L ? false : true;
	}

}
