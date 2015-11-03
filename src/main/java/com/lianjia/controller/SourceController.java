package com.lianjia.controller;



import java.util.Map;

import com.jfinal.core.Controller;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.lianjia.common.DataGridUtil;
import com.lianjia.model.Presentee;
import com.lianjia.pageModel.DataGrid;

public class SourceController  extends Controller 
{

	/**
	 * 共享资源页面跳转
	 * (被推荐人 == 资源)
	 */
	public void manager()
	{
		render("/vzp/presentee/presentee.jsp");
	}
	

	/**
	 * 增加页面跳转
	 */
	public void add()
	{
		
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
	
		Page<Record> pageList = DataGridUtil.dataGrid(this, "presentee");
		DataGrid dg=new DataGrid();
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
		this.render("/vzp/presentee/pstXview.jsp");
		
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
		this.render("/vzp/presentee/pstView.jsp");

	}
}
