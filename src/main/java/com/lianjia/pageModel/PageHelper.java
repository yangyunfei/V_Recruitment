package com.lianjia.pageModel;

import com.jfinal.core.Controller;


/**
 * EasyUI 分页帮助类
 * 
 * @author 孙宇
 * 
 */
public class PageHelper implements java.io.Serializable {

	private int page;// 当前页
	private int rows;// 每页显示记录数
	private String sort;// 排序字段
	private String order;// asc/desc

	public int getPage() {
		return page;
	}

	public void setPage(int page) {
		this.page = page;
	}

	public int getRows() {
		return rows;
	}

	public void setRows(int rows) {
		this.rows = rows;
	}

	public String getSort() {
		return sort;
	}

	public void setSort(String sort) {
		this.sort = sort;
	}

	public String getOrder() {
		return order;
	}

	public void setOrder(String order) {
		this.order = order;
	}

	public static PageHelper CreateFromController(Controller controller)
	{
		PageHelper ph=new PageHelper();
		ph.setSort(controller.getPara("sort"));
		ph.setOrder(controller.getPara("order"));
		ph.setPage(controller.getParaToInt("page",0));
		ph.setRows(controller.getParaToInt("rows",0));
		return ph;
	}
	
}
