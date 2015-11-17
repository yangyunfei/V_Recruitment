package com.lianjia.controller;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import com.jfinal.aop.Before;
import com.jfinal.core.Controller;
import com.jfinal.kit.StrKit;
import com.jfinal.plugin.activerecord.Db;
import com.lianjia.common.Constants;
import com.lianjia.common.ResponseResult;
import com.lianjia.interceptor.AuthenticationInterceptor;
import com.lianjia.model.Agent;
import com.lianjia.model.Module;
import com.lianjia.model.Role;
import com.lianjia.model.User;
import com.lianjia.model.WechatUser;
import com.lianjia.pageModel.Tree;
import com.lianjia.server.UserVerificationServer;

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
		ResponseResult result= new ResponseResult(true, "", null);
		String loginName = getPara("pager");
		String password = getPara("password");
		String openid = getPara("openid");
		Agent agent = UserVerificationServer.validate(loginName,password);
		//Agent agent = Agent.dao.findById("20127268");
		//帐号密码错误或失效
		if(null == agent)
		{
			result = new ResponseResult(false, "帐号密码错误!", null);
			renderJson(result);
			return;
		}
		else
		{
			//更新或者新增经纪人信息
			String pager = agent.getStr("pager");
			Agent agentElement = agent.dao.findById(pager);
			//如果自己的库中没有该经济人信息新增
			if(null == agentElement)
			{
				agent.save();
			}
			else
			{
				//检查经济人信息是否有更新,如果有则更细经纪人信息表
				Agent.updateInfo(agentElement,agent);
				
			}
			
			//查询微信用户信息
			WechatUser wechatUser = WechatUser.dao.findFirst("SELECT  id,pager,openid FROM wechatuser WHERE pager = ?", pager);
			//没有则添加
			if(null == wechatUser)
			{
				wechatUser = new WechatUser();				
				wechatUser.set("pager", agent.get("pager"));
				wechatUser.set("createTime", new Date());
				wechatUser.set("lastUpdateTime", new Date());
				wechatUser.save();
			}
			//如果上传登录有openid 则为微信绑定信息或者换绑定
			if(!StrKit.isBlank(openid))
			{
				WechatUser wechatUserOpenid = WechatUser.dao.findFirst("SELECT  id,pager,openid FROM wechatuser WHERE openid = ? AND pager <> ?", openid,loginName);
				//该OpenId之前绑定的其他的pager删除掉
				if(null != wechatUserOpenid )
				{
					wechatUserOpenid.delete();
				}
				if(StrKit.notNull(wechatUser.getStr("openid")))
				{
					wechatUser.remove("openid");
				}				
				wechatUser.set("openid", openid);
				wechatUser.update();
			}
						
			
			
			wechatUser.setAgentInfo();
			setSessionAttr(Constants.Controller_SESSION_WeChat_User_Key, wechatUser);
			System.out.println(loginName+password);
			renderJson(result);
		}
		
	}
	

	
	/**
	 * 页面列表左侧树的数据加载
	 */
	@Before(AuthenticationInterceptor.class)
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
