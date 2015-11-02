package com.lianjia.controller;


import com.jfinal.core.Controller;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.lianjia.common.DataGridUtil;
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
	 * 页面添加是否重点商铺
	 */
	/**
	 * 商铺删除或恢复
	 */
	public  void  del()
	{
	  
	   
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
