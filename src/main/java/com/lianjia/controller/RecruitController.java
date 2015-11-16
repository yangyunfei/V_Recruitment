package com.lianjia.controller;

import java.util.Date;
import java.util.Random;

import com.jfinal.aop.Before;
import com.jfinal.core.Controller;
import com.jfinal.kit.StrKit;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.lianjia.common.CancleEnum;
import com.lianjia.common.Constants;
import com.lianjia.common.DataGridUtil;
import com.lianjia.common.ResponseResult;
import com.lianjia.interceptor.AuthenticationInterceptor;
import com.lianjia.model.Presentee;
import com.lianjia.model.Recruit;
import com.lianjia.model.User;
import com.lianjia.pageModel.DataGrid;
import com.lianjia.server.RecruitServer;
import com.lianjia.tools.ToolDateTime;

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
	 * 招聘初试通过后处理页面跳转
	 */
	public void manager_entried()
	{
		
		render("/vzp/recruit/recruit_entried.jsp");
	}
	

	/**
	 * 添加面试时间页面跳转
	 */
	public void toJoinInterview()
	{
		long rt_id = getParaToLong(0);		
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
		setAttr("recruit", recruit);
		setAttr("url", "joinInterview");
		setAttr("title", "添加面试时间");
		render("/vzp/recruit/recruitTime.jsp");
	}
	
	/**
	 * 邀请面试
	 */
	public void joinInterview()
	{
		String timeStr = getPara("interviewtime");			
		if(null == timeStr)
		{
			renderJson(new ResponseResult(false,"请选择时间！",null));
			return;
		}
		Date interviewtime = ToolDateTime.parse(timeStr);
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
		User user = (User)getAttr(Constants.Controller_SESSION_User_Key);		
		if(!recruit.validateBelongtoUser(user))
		{
			renderJson(new ResponseResult(false,"该人员不属于你,请刷新！",null));
			return;
		};
		if(!recruit.validateState(Constants.STATE_SUSPENDING))
		{
			renderJson(new ResponseResult(false,"该任务不是待初试状态，请刷新页面！",null));
			return;
		};
		setAttr("recruit", recruit);
		setAttr("url", "breakOff");
		setAttr("title", "取消初试"); 
		setAttr("content", "请选择不参加初试的原因");
		setAttr("cancle_url", "cancle-notInterview");
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
		CancleEnum cancleEnum = CancleEnum.getByCode(cancle);
		if(null == cancleEnum || (!Constants.Cancle_type_notInterview.equals(cancleEnum.getGroup())))
		{
			renderJson(new ResponseResult(false,"原因编号错误，不匹配当前招聘状态!！",null));
			return;
		}
		User user = (User)getAttr(Constants.Controller_SESSION_User_Key);		
		if(!recruit.validateBelongtoUser(user))
		{
			renderJson(new ResponseResult(false,"该人员不属于你,请刷新！",null));
			return;
		};
		if(!recruit.validateState(Constants.STATE_SUSPENDING))
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
		User user = (User)getAttr(Constants.Controller_SESSION_User_Key);	
		if(!recruit.validateBelongtoUser(user))
		{
			renderJson(new ResponseResult(false,"该人员不属于你,请刷新！",null));
			return;
		};
		if(!recruit.validateState(Constants.STATE_WAIT_FIRSTINTERVIEW))
		{
			renderJson(new ResponseResult(false,"该任务不是待面试状态，请刷新页面！",null));
			return;
		};
		boolean result = RecruitServer.server.pass(recruit);			
		if(result)
		{
			renderJson(new ResponseResult(true,"成功",null));
		}
		else
		{
			renderJson(new ResponseResult(false,"失败",null));
		}
	   
	}
	
	
	public  void  nopass()
	{
		
		
		long rt_id = getParaToLong(0);
		Recruit recruit =Recruit.dao.findById(rt_id);
		User user = (User)getAttr(Constants.Controller_SESSION_User_Key);	
		if(!recruit.validateBelongtoUser(user))
		{
			renderJson(new ResponseResult(false,"该人员不属于你,请刷新！",null));
			return;
		};
		if(!recruit.validateState(Constants.STATE_WAIT_FIRSTINTERVIEW))
		{
			renderJson(new ResponseResult(false,"该任务不是待面试状态，请刷新页面！",null));
			return;
		};
		boolean result = RecruitServer.server.nopass(recruit);	
		if(result)
		{
			renderJson(new ResponseResult(true,"成功",null));
		}
		else
		{
			renderJson(new ResponseResult(false,"失败",null));
		}
	   
	}
	
	
	public  void  noComeInterview()
	{
		
		
		long rt_id = getParaToLong(0);
		Recruit recruit =Recruit.dao.findById(rt_id);
		User user = (User)getAttr(Constants.Controller_SESSION_User_Key);	
		if(!recruit.validateBelongtoUser(user))
		{
			renderJson(new ResponseResult(false,"该人员不属于你,请刷新！",null));
			return;
		};
		if(!recruit.validateState(Constants.STATE_WAIT_FIRSTINTERVIEW))
		{
			renderJson(new ResponseResult(false,"该任务不是待面试状态，请刷新页面！",null));
			return;
		};
		boolean result = RecruitServer.server.noComeInterview(recruit);
		
		if(result)
		{
			renderJson(new ResponseResult(true,"成功",null));
		}
		else
		{
			renderJson(new ResponseResult(false,"失败",null));
		}
	   
	}
	
	
	

	public  void  toEditInterview()
	{
		long rt_id = getParaToLong(0);		
		Recruit recruit =Recruit.dao.findById(rt_id);	
		User user = (User)getAttr(Constants.Controller_SESSION_User_Key);		
		if(!recruit.validateBelongtoUser(user))
		{
			renderJson(new ResponseResult(false,"该人员不属于你,请刷新！",null));
			return;
		};
		if(!recruit.validateState(Constants.STATE_WAIT_FIRSTINTERVIEW))
		{
			renderJson(new ResponseResult(false,"该任务不是待面试状态，请刷新页面！",null));
			return;
		};
		setAttr("url", "joinInterview");
		setAttr("title", "修改面试时间");
		setAttr("recruit", recruit);
		setAttr("url", "EditInterview");
		render("/vzp/recruit/recruitTime.jsp");
	   
	}
	
	public void EditInterview()
	{
		String timeStr = getPara("interviewtime");			
		if(null == timeStr)
		{
			renderJson(new ResponseResult(false,"请选择时间！",null));
			return;
		}
		Date interviewtime = ToolDateTime.parse(timeStr);
		long rt_id = getParaToLong("rt_id");
		Recruit recruit =Recruit.dao.findById(rt_id);
		User user = (User)getAttr(Constants.Controller_SESSION_User_Key);		
		if(!recruit.validateBelongtoUser(user))
		{
			renderJson(new ResponseResult(false,"该人员不属于你,请刷新！",null));
			return;
		};
		if(!recruit.validateState(Constants.STATE_WAIT_FIRSTINTERVIEW))
		{
			renderJson(new ResponseResult(false,"该任务不是待面试状态，请刷新页面！",null));
			return;
		};
		boolean result = RecruitServer.server.EditInterview(recruit,interviewtime);		
		if(result)
		{
			renderJson(new ResponseResult(true,"成功",null));
		}
		else
		{
			renderJson(new ResponseResult(false,"失败",null));
		}
		
		
	}
	
	public  void  callOnEagleEye()
	{
		long rt_id = getParaToLong(0);		
		Recruit recruit =Recruit.dao.findById(rt_id);	
		User user = (User)getAttr(Constants.Controller_SESSION_User_Key);		
		if(!recruit.validateBelongtoUser(user))
		{
			renderJson(new ResponseResult(false,"该人员不属于你,请刷新！",null));
			return;
		};
		if(!recruit.validateState(Constants.STATE_WAIT_SECONDINTERVIEW))
		{
			renderJson(new ResponseResult(false,"该任务不是待面试状态，请刷新页面！",null));
			return;
		};
		Random random = new Random();
		int nextInt = random.nextInt(100);
		boolean result = false;
		if(0 == nextInt%5)
		{
			result = true;
			recruit.set("state", Constants.STATE_WAIT_TRAIN);
			recruit.set("lastUpdateTime", new Date());
			long pst_id = recruit.getLong("presentee_id");
			Presentee pst = Presentee.dao.findById(pst_id);
			pst.set("state", Constants.STATE_WAIT_TRAIN);
			pst.set("lastUpdateTime", new Date());
			result = recruit.update()&&pst.update();
			
			
		}
		if(result)
		{
			renderJson(new ResponseResult(true,"成功",null));
		}
		else
		{
			renderJson(new ResponseResult(false,"还没有查询出来结果！请等一段时间后再试！",null));
		}
	   
	}
	
	
	public  void  notTrain()
	{
		
		
		long rt_id = getParaToLong(0);
		Recruit recruit =Recruit.dao.findById(rt_id);
		User user = (User)getAttr(Constants.Controller_SESSION_User_Key);	
		if(!recruit.validateBelongtoUser(user))
		{
			renderJson(new ResponseResult(false,"该人员不属于你,请刷新！",null));
			return;
		};
		if(!recruit.validateState(Constants.STATE_WAIT_TRAIN))
		{
			renderJson(new ResponseResult(false,"该任务不是待培训状态，请刷新页面！",null));
			return;
		};
		boolean result = RecruitServer.server.notTrain(recruit);				
		if(result)
		{
			renderJson(new ResponseResult(true,"成功",null));
		}
		else
		{
			renderJson(new ResponseResult(false,"失败",null));
		}
	   
	}
	
	public  void  passTrain()
	{	
		long rt_id = getParaToLong(0);
		Recruit recruit =Recruit.dao.findById(rt_id);
		User user = (User)getAttr(Constants.Controller_SESSION_User_Key);	
		if(!recruit.validateBelongtoUser(user))
		{
			renderJson(new ResponseResult(false,"该人员不属于你,请刷新！",null));
			return;
		};
		if(!recruit.validateState(Constants.STATE_WAIT_TRAIN))
		{
			renderJson(new ResponseResult(false,"该任务不是待培训状态，请刷新页面！",null));
			return;
		};
		boolean result = RecruitServer.server.passTrain(recruit);

		if(result)
		{
			renderJson(new ResponseResult(true,"成功",null));
		}
		else
		{
			renderJson(new ResponseResult(false,"失败",null));
		}
	   
	}
	
	public void toGetOutTrain()
	{
		long rt_id = getParaToLong(0);		
		Recruit recruit =Recruit.dao.findById(rt_id);
		User user = (User)getAttr(Constants.Controller_SESSION_User_Key);		
		if(!recruit.validateBelongtoUser(user))
		{
			renderJson(new ResponseResult(false,"该人员不属于你,请刷新！",null));
			return;
		};
		if(!recruit.validateState(Constants.STATE_WAIT_TRAIN))
		{
			renderJson(new ResponseResult(false,"该任务不是待培训状态，请刷新页面！",null));
			return;
		};
		setAttr("recruit", recruit);
		setAttr("url", "getOutTrain");
		setAttr("title", "培训淘汰"); 
		setAttr("content", "请选择培训淘汰的原因");
		setAttr("cancle_url", "cancle-noPassTrain");
		render("/vzp/recruit/recruitCancel.jsp");
	}
	
	public void getOutTrain()
	{
		long rt_id = getParaToLong("rt_id");
		Integer cancle = getParaToInt("cancle");	
		Recruit recruit =Recruit.dao.findById(rt_id);
		if(null == cancle)
		{
			renderJson(new ResponseResult(false,"请选择原因！",null));
			return;
		};
		CancleEnum cancleEnum = CancleEnum.getByCode(cancle);
		if(null == cancleEnum || (!Constants.Cancle_type_noPassTrain.equals(cancleEnum.getGroup())))
		{
			renderJson(new ResponseResult(false,"原因编号错误，不匹配当前招聘状态!！",null));
			return;
		}
		User user = (User)getAttr(Constants.Controller_SESSION_User_Key);		
		if(!recruit.validateBelongtoUser(user))
		{
			renderJson(new ResponseResult(false,"该人员不属于你,请刷新！",null));
			return;
		};
		if(!recruit.validateState(Constants.STATE_WAIT_TRAIN))
		{
			renderJson(new ResponseResult(false,"该任务不是待初试状态，请刷新页面！",null));
			return;
		};
		boolean result = RecruitServer.server.getOutTrain(recruit,cancle);			
		
		if(result)
		{
			renderJson(new ResponseResult(true,"成功",null));
		}
		else
		{
			renderJson(new ResponseResult(false,"失败",null));
		}
	}
	
	public void toaddProperty()
	{
	   
		long rt_id = getParaToLong(0);		
		Recruit recruit =Recruit.dao.findById(rt_id);
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
		long pst_id = recruit.getLong("presentee_id");
		Presentee pst = Presentee.dao.findById(pst_id);
		setAttr("rt_id", rt_id);
		setAttr("presentee", pst);		
		render("/vzp/recruit/presenteeAddProperty.jsp");
	}
	
	public void addProperty()
	{
	   
		long rt_id = getParaToLong("rt_id");		
		Recruit recruit =Recruit.dao.findById(rt_id);
		String idcard = getPara("idcard");
		String school_name = getPara("school_name");
		String school_level = getPara("school_level");
		String address = getPara("address");
		String remarks = getPara("remarks");
		if(!StrKit.notBlank(idcard,school_name,school_level,address))
		{
			renderJson(new ResponseResult(false,"修改信息不全！",null));
			return;
		}
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
		long pst_id = recruit.getLong("presentee_id");
		Presentee pst = Presentee.dao.findById(pst_id);
		pst.set("idcard", idcard);
		pst.set("school_name", school_name);
		pst.set("school_level", school_level);
		pst.set("address", address);
		pst.set("remarks", remarks);
		pst.set("lastUpdateTime", new Date());			
		if(pst.update())
		{
			renderJson(new ResponseResult(true,"成功",null));
		}
		else
		{
			renderJson(new ResponseResult(false,"失败",null));
		}
		
	}
	
	/**
	 * 入职
	 */
	public  void  entry()
	{	
		long rt_id = getParaToLong(0);
		Recruit recruit =Recruit.dao.findById(rt_id);
		User user = (User)getAttr(Constants.Controller_SESSION_User_Key);	
		if(!recruit.validateBelongtoUser(user))
		{
			renderJson(new ResponseResult(false,"该人员不属于你,请刷新！",null));
			return;
		};
		if(!recruit.validateState(Constants.STATE_WAIT_ENTRANT))
		{
			renderJson(new ResponseResult(false,"该任务不是待入职状态，请刷新页面！",null));
			return;
		};
		boolean result = RecruitServer.server.entry(recruit);

		if(result)
		{
			renderJson(new ResponseResult(true,"成功",null));
		}
		else
		{
			renderJson(new ResponseResult(false,"失败",null));
		}
	   
	}
}
