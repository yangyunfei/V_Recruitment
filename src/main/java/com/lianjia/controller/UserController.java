package com.lianjia.controller;

import java.util.Arrays;
import java.util.List;








import com.jfinal.aop.Clear;
import com.jfinal.core.Controller;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.lianjia.common.DataGridUtil;
import com.lianjia.common.ResponseResult;
import com.lianjia.model.Role;
import com.lianjia.model.User;
import com.lianjia.pageModel.DataGrid;
import com.lianjia.tools.ToolDateTime;

public class UserController extends Controller 
{
	/**
	 * 用户管理页面跳转
	 */
	public void manager()
	{
		render("/vzp/authority/user.jsp");
	}
	/**
	 *用户页面列表数据加载
	 */
	public void dataGrid()
	{
		Page<Record> pageList = DataGridUtil.dataGrid(this, "user");
		DataGrid dg=new DataGrid();
		for(Record u:pageList.getList())
		{
			u.set("roleName", Role.dao.getRoleStr(u.getStr("roles")));
		}
		dg.setRows(pageList.getList());
		dg.setTotal(pageList.getTotalRow());
		renderJson(dg);	
	}
	/**
	 * 修改密码页面跳转
	 */
	@Clear
	public void editPwdPage()
	{
		//this.keepPara("id");
		String id = getPara("id");
		System.out.println(id);
		User user = (User) User.dao.findById(id);
		setAttr("user", user);
		render("/vzp/authority/userEditPwd.jsp");
	}
    /**
     * 修改密码操作
     */
	public void editPwd()
	{
		String id = getPara("id");
		String pwd = getPara("pwd");
		 ResponseResult  j=new ResponseResult(); 	
		boolean flag = User.dao.findById(id).set("password", pwd).update();
		//render("/admin/userEditPwd.jsp");
		j.setSuccess(flag); 
		renderJson(j);	
	}
	/**
	 * 页面下拉列表生成数据查询
	 */
	public void roleList()
	{
		List<Role> list= Role.dao.find("select id,role_name from role");
		renderJson(list);
	}
	/**
	 * 用户状态修改操作
	 */
	public void delete()
	{
		String id = getPara("id");
		//根据对应的状态进行状态转换
		String state = getPara("state");
		System.out.println(state);
		boolean flag = false;
		ResponseResult  j=new ResponseResult(); 	
		if("1".equals(state)){
			 flag = User.dao.findById(id).set("state", 0).update();
			 j.setMsg("启用该用户操作成功！");
		}else if("0".equals(state)){
			 flag = User.dao.findById(id).set("state", 1).update();
			 j.setMsg("停用该用户操作成功！");
		}
		j.setSuccess(flag);
		
       	renderJson(j);
	}
	
	/**
	 * 页面跳转到添加用户视图
	 */
	public void addPage()
	{
		render("/vzp/authority/userAdd.jsp");
	}
	/**
	 * 用户添加后台处理
	 */
	public void add()
	{
		User userModel = getModel(User.class);
		ResponseResult j=new ResponseResult(); 	
		
		String loginName = userModel.get("login_name");
		List<User> users = User.dao.find("select * from user where login_name=?",loginName);
		if(users.size()>0){
			j.setMsg("登录名已经存在，请重新设置您的信息");
			j.setSuccess(false);
		}else{
		//插入数据库操作
		boolean save =  userModel.set("roles", Arrays.toString(getParaValues("user.roles")).replace("[","").replace("]",""))
						.set("createTime", ToolDateTime.format(ToolDateTime.getDate(),ToolDateTime.pattern_ymd_hms))				  
						.save();
		j.setSuccess(save);
		}
       	renderJson(j);
	}

}
