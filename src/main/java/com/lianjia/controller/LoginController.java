package com.lianjia.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import com.jfinal.aop.Clear;
import com.jfinal.core.Controller;
import com.lianjia.common.ResponseResult;
import com.lianjia.model.Module;
import com.lianjia.model.Role;
import com.lianjia.model.User;
import com.lianjia.pageModel.Tree;

public class LoginController extends Controller 
{
	public void login() 
	{
		ResponseResult result= new ResponseResult(false, "添加失败", null);
		String loginName = getPara("name");
		String password = getPara("pwd");
		List<User> users = User.dao.find("select * from user where login_name=? and password=? and  state=0",loginName,password);
		System.out.println("controller");
		if(users.size()>0){
			User user = users.get(0);
			setSessionAttr("user", user);
			result.setSuccess(true);
			
		}else{
			result.setMsg("用户名或密码错误！");
			result.setSuccess(false);
		}
       	renderJson(result);
	}
	
	public void wechatlogin()
	{
		String loginName = getPara("username");
		String password = getPara("password");
		//Agent agent = UserVerificationServer.validate(loginName,password);
		setSessionAttr("wechatuser", "");
		System.out.println(loginName+password);
		render("/WEB-INF/jsp/main.jsp");
	}
	
	/**
	 * 页面列表左侧树的数据加载
	 */
	@Clear
	public void tree(){
//    	Module module =new Module();
    	//Role_Module role_module = new Role_Module();
    	User user = getSessionAttr("user");
    	
    	String roles = user.get("roles");
    	//String roles = "3";
    	List<Role> roleList = Role.dao.getRoleList(roles);
    	Set<Module> modules = Module.dao.getModule(roleList);
    	
    	
    	
    	//**********模拟拦截器功能********************************************
    	//List<Module> modules = Module.dao.find("select * from module");
    	System.out.println(modules);
    	List<Tree> lt = new ArrayList<Tree>();
    	//功能模块的实现
    	List<Module> mods = new ArrayList<Module>();
    	for (Module m : modules) {
			//System.out.println(m.get("id"));
    		Tree tree = new Tree();
    		if(m.get("type").equals(0) ){
    		if (m.get("id")!=null){
    			tree.setId(m.get("id").toString());
    		}
    		if(m.get("name")!=null){
    			tree.setText((String) m.get("name"));
    		}
    		if(m.get("ico")!=null){
    			tree.setIconCls((String) m.get("ico"));
    		}
    		if(m.get("fid")!=null){
    			tree.setPid(m.get("fid").toString());
    		}
    		Map<String, Object> attr = new HashMap<String, Object>();
			attr.put("url", m.get("url"));
			tree.setAttributes(attr);
    		lt.add(tree);
    		}else{
    			
    			mods.add(m);
    		}
		}
    	//System.out.println(moduleList.toString());
    	setSessionAttr("modules", modules);
    	//setSessionAttr("mods", mods);
        renderJson(lt);

       // System.out.println(lt);
    	//render("index.jsp");
    }
	/**
	 * 用户注销操作
	 */
	public void logout()
	{
		this.removeSessionAttr("modules");
		this.removeSessionAttr("user");
//		ResponseResult  j=new ResponseResult(); 	
//		j.setSuccess(true);
//       	renderJson(j);
		render("/login.jsp");
	}

}
