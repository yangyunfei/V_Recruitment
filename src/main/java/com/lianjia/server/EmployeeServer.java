package com.lianjia.server;

import com.jfinal.log.Logger;
import com.lianjia.model.Employee;

public class EmployeeServer 
{
	public static final EmployeeServer server = new EmployeeServer();
	
	private static Logger logger = Logger.getLogger(EmployeeServer.class);
	
	public boolean addEmployee(Employee ee)
	{
		boolean result = false;
		try 
		{
			result = ee.save();
		} 
		catch (Exception e) 
		{
			logger.error("添加推荐人员报错：  \n {}",e);
			e.printStackTrace();
			
		}
		return result;
	}

}
