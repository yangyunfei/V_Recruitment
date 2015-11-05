package com.lianjia.controller;

import java.util.Date;

import com.jfinal.aop.Before;
import com.jfinal.core.Controller;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.lianjia.common.Constants;
import com.lianjia.common.DataGridUtil;
import com.lianjia.common.ResponseResult;
import com.lianjia.interceptor.AuthenticationInterceptor;
import com.lianjia.model.Presentee;
import com.lianjia.model.Recruit;
import com.lianjia.model.User;
import com.lianjia.pageModel.DataGrid;
import com.lianjia.server.RecruitServer;

@Before(AuthenticationInterceptor.class)
public class RecruitController extends Controller 
{

	/**
	 * 招聘待处理页面跳转
	 */
	public void manager_suspending()
	{
		
		render("/vzp/recruit/recruit_suspending.jsp");
	}
	/**
	 * 招聘待面试页面跳转
	 */
	public void manager_waitInterview()
	{
		
		render("/vzp/recruit/recruit_waitInterview.jsp");
	}
	/**
	 * 招聘初试通过后处理页面跳转
	 */
	public void manager_handling()
	{
		
		render("/vzp/recruit/recruit_handling.jsp");
	}
	

	/**
	 * 添加面试时间页面跳转
	 */
	public void toJoinInterview()
	{
		long rt_id = getParaToLong(0);		
		Recruit recruit =Recruit.dao.findById(rt_id);	
		setAttr("recruit", recruit);
		render("/vzp/recruit/recruitaddTime.jsp");
	}
	
	/**
	 * 邀请面试
	 */
	public void joinInterview()
	{
		Date interviewtime = getParaToDate("interviewtime");	
		if(null == interviewtime)
		{
			renderJson(new ResponseResult(false,"请选择时间！",null));
			return;
		}
		long rt_id = getParaToLong("rt_id");
		Recruit recruit =Recruit.dao.findById(rt_id);
		User user = (User)getAttr(Constants.Controller_SESSION_User_Key);		
		if(!recruit.validateBelongtoUser(user))
		{
			renderJson(new ResponseResult(false,"该人员不属于你,请刷新！",null));
			return;
		};
		if(!recruit.validateState(Constants.STATE_SUSPENDING))
		{
			renderJson(new ResponseResult(false,"该任务不是待处理状态，请刷新页面！",null));
			return;
		};
		boolean result = RecruitServer.server.joinInterview(recruit,interviewtime);		
		if(result)
		{
			renderJson(new ResponseResult(true,"成功",null));
		}
		else
		{
			renderJson(new ResponseResult(false,"失败",null));
		}
		
		
	}
	
	public void toBreakOff()
	{
		long rt_id = getParaToLong(0);		
		Recruit recruit =Recruit.dao.findById(rt_id);
		setAttr("recruit", recruit);
		render("/vzp/recruit/recruitCancel.jsp");
	}
	
	
	public void breakOff()
	{
		long rt_id = getParaToLong("rt_id");
		Integer cancle = getParaToInt("cancle");	
		Recruit recruit =Recruit.dao.findById(rt_id);
		if(null == cancle)
		{
			renderJson(new ResponseResult(false,"请选择原因！",null));
			return;
		};
		User user = (User)getAttr(Constants.Controller_SESSION_User_Key);		
		if(!recruit.validateBelongtoUser(user))
		{
			renderJson(new ResponseResult(false,"该人员不属于你,请刷新！",null));
			return;
		};
		if(!recruit.validateState(Constants.STATE_WAIT_FIRSTINTERVIEW))
		{
			renderJson(new ResponseResult(false,"该任务不是待初试状态，请刷新页面！",null));
			return;
		};
		boolean result = RecruitServer.server.breakOff(recruit,cancle);			
		
		if(result)
		{
			renderJson(new ResponseResult(true,"成功",null));
		}
		else
		{
			renderJson(new ResponseResult(false,"失败",null));
		}
		
		
	}
	/**
	 *客户页面列表数据加载
	 */
	public void dataGrid()
	{
		Page<Record> pageList = DataGridUtil.dataGrid(this, "v_recruit");
		DataGrid dg=new DataGrid();
		dg.setRows(pageList.getList());
		dg.setTotal(pageList.getTotalRow());
		renderJson(dg);	
	
	
	}


	public  void  pass()
	{
		
		long rt_id = getParaToLong(0);		
		Recruit recruit =Recruit.dao.findById(rt_id);
		recruit.set("state", 3);
		recruit.set("lastUpdateTime", new Date());
		long pst_id = recruit.getLong("presentee_id");
		Presentee pst = Presentee.dao.findById(pst_id);
		pst.set("state", 3);
		pst.set("handleman", 0);
		pst.set("weight", 1);
		pst.set("lastUpdateTime", new Date());
		if(recruit.update()&&pst.update())
		{
			renderJson(new ResponseResult(true,"成功",null));
		}
		else
		{
			renderJson(new ResponseResult(false,"失败",null));
		}
	   
	}
	
	public void toNoPass()
	{
		long rt_id = getParaToLong(0);		
		Recruit recruit =Recruit.dao.findById(rt_id);
		setAttr("recruit", recruit);
		render("/vzp/recruit/recruitNoPass.jsp");
	}
	
	public  void  nopass()
	{
		
		
		long rt_id = getParaToLong(0);
		Recruit recruit =Recruit.dao.findById(rt_id);
		recruit.set("state", -1);
		recruit.set("lastUpdateTime", new Date());
		recruit.set("cancle", 8);
		long pst_id = recruit.getLong("presentee_id");
		Presentee pst = Presentee.dao.findById(pst_id);
		pst.set("state", -1);
		pst.set("lastUpdateTime", new Date());
		pst.set("handleman", 0);
		pst.set("weight", 1);
		pst.set("cancle", 8);	
		if(recruit.update()&&pst.update())
		{
			renderJson(new ResponseResult(true,"成功",null));
		}
		else
		{
			renderJson(new ResponseResult(false,"失败",null));
		}
	   
	}
	
	/**
	 * 商铺推广或取消
	 */
	public  void  spread()
	{
	  
	   
	}
	/**
	 * 商铺查看
	 */
	public void view()
	{
	   
		
	}
}
