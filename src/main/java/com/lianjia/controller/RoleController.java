package com.lianjia.controller;

import java.util.List;

import org.apache.commons.lang3.StringUtils;

import com.jfinal.aop.Before;
import com.jfinal.core.Controller;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.lianjia.common.DataGridUtil;
import com.lianjia.common.ResponseResult;
import com.lianjia.interceptor.AuthenticationInterceptor;
import com.lianjia.model.Module;
import com.lianjia.model.Role;
import com.lianjia.pageModel.DataGrid;

@Before(AuthenticationInterceptor.class)
public class RoleController extends Controller
{

	/**
	 * 用户管理页面跳转
	 */
	public void manager()
	{
		render("/vzp/authority/role.jsp");
	}
	/**
	 *用户页面列表数据加载
	 */
	public void dataGrid()
	{
		Page<Record> pageList = DataGridUtil.dataGrid(this, "role");
		DataGrid dg=new DataGrid();
		dg.setRows(pageList.getList());
		dg.setTotal(pageList.getTotalRow());
		renderJson(dg);	
	}
	
	public void editPage()
	{
		String id = getPara("id");
		Role role = (Role) Role.dao.findById(id);
		setAttr("role", role);
		render("/vzp/authority/roleEdit.jsp");
	}
	
	public void getModule()
	{
		List<Module> allModule = Module.dao.findAllModule();
		renderJson(allModule);	
	}
	
	//修改角色权限
	public void edit()
	{
		String roleid = getPara("roleid");
		String name = getPara("name");
		String[] modules = getParaValues("id");
		Role role = (Role) Role.dao.findById(roleid);
		String moduleids = StringUtils.join(modules, ',');
		role.set("role_name", name);
		role.set("module", moduleids);
		ResponseResult j=new ResponseResult(); 	
		boolean flag = role.update();
		j.setSuccess(flag); 
		renderJson(j);	
		
	}
	
	public void addPage()
	{
		render("/vzp/authority/roleAdd.jsp");
	}
	
	public void add()
	{
		String name = getPara("name");
		String[] modules = getParaValues("id");
		String moduleids = StringUtils.join(modules, ',');
		Role role = new Role();
		role.set("role_name", name);
		role.set("module", moduleids);
		ResponseResult j=new ResponseResult(); 	
		boolean flag = role.save();
		j.setSuccess(flag); 
		renderJson(j);	
	}
	
//	public void treeGrid()
//	{
//		
//		List<Tree> rolesList = new ArrayList<Tree>();
//		List<Role> allRole = Role.dao.findAllRole();
//		List<Module> allModule = Module.dao.findAllModule();
//		for(Role role : allRole)
//		{
//			Tree roleTree = new Tree();
//			Integer roleId = role.getInt("id");
//			roleTree.setId(roleId.toString());
//			roleTree.setText(role.getStr("role_name"));
//			String modules = role.getStr("module");
//			List<Module> moduleList = Module.dao.getModuleList(modules);
//			List<Tree> childrenList = new ArrayList<Tree>();
//			for(Module module : moduleList)
//			{
//				Tree childrenTree = new Tree();
//				childrenTree.setId(module.getInt("id").toString());
//				childrenTree.setText(module.getStr("name"));
//				childrenTree.setPid(roleId.toString());
//				childrenList.add(childrenTree);
//			}
//			roleTree.setChildren(childrenList);
//			rolesList.add(roleTree);
//		}
//		renderJson(rolesList);	
//	}
}
