package com.lianjia.controller;



import java.util.Date;
import java.util.List;

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
import com.lianjia.model.TableCode;
import com.lianjia.model.User;
import com.lianjia.pageModel.DataGrid;

@Before(AuthenticationInterceptor.class)
public class SourceController  extends Controller 
{

	public void manager()
	{
		render("/vzp/source/presentee.jsp");
	}

	public void historymanager()
	{
		render("/vzp/source/history_presentee.jsp");
	}

	/**
	 * 增加页面跳转
	 */
	public void accept()
	{
		long pst_id = getParaToLong(0);
		User user = (User)getAttr(Constants.Controller_SESSION_User_Key);		
		Recruit recruit = new Recruit();
		recruit.set("user_id", user.getLong("id"));
		recruit.set("presentee_id", pst_id);
		recruit.set("state", 1);
		recruit.set("createtime", new Date());
		Presentee pst = Presentee.dao.findById(pst_id);
		pst.set("handleman", user.getLong("id"));
		if(recruit.save()&&pst.update())
		{
			renderJson(new ResponseResult(true,"成功",null));
		}
		else
		{
			renderJson(new ResponseResult(false,"失败",null));
		}
		
	}
	
	/**
	 * 修改页面跳转
	 */
	public void update()
	{
		
	}
	/**
	 *客户页面列表数据加载
	 */
	public void dataGrid()
	{
	
		Page<Record> pageList = DataGridUtil.dataGrid(this, "v_source");
		DataGrid dg=new DataGrid();
		List<Record> list = pageList.getList();
		for(Record rd : list)
		{			
			String codeName = TableCode.dao.GetSimpleCodeName("presentee", "cancle", String.valueOf(rd.getInt("cancle")));
			rd.set("canclename", codeName);
		}
		dg.setRows(pageList.getList());
		dg.setTotal(pageList.getTotalRow());
		renderJson(dg);	
	
	}

	
	
	/**
	 * 被推荐人基本信息查看
	 */
	public void xview()
	{
		int id = this.getParaToInt("id");
		Presentee pt = Presentee.dao.findById(id);
		if (pt == null) {
			this.renderError(404);
			return;
		}
		setAttr("pt", pt);
		this.render("/vzp/source/pstXview.jsp");
		
	}
	
	/**
	 * 商铺查看
	 */
	public void view() 
	{
		int id = this.getParaToInt("id");
		Presentee pt = Presentee.dao.findById(id);
		if (pt == null) {
			this.renderError(404);
			return;
		}
		setAttr("pt", pt);
		this.render("/vzp/source/pstView.jsp");

	}
}
