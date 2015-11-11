package com.lianjia.controller.weichat;

import java.util.Date;
import java.util.List;


import com.jfinal.aop.Before;
import com.jfinal.aop.Clear;
import com.jfinal.kit.PropKit;
import com.jfinal.kit.StrKit;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.weixin.sdk.api.ApiConfig;
import com.jfinal.weixin.sdk.api.ApiConfigKit;
import com.jfinal.weixin.sdk.api.ApiResult;
import com.jfinal.weixin.sdk.api.MenuApi;
import com.jfinal.weixin.sdk.api.UserApi;
import com.jfinal.weixin.sdk.jfinal.ApiController;
import com.lianjia.common.Constants;
import com.lianjia.common.ResponseResult;
import com.lianjia.interceptor.WeixinAuthenticationInterceptor;
import com.lianjia.interceptor.WeixinSessionInterceptor;
import com.lianjia.model.Presentee;
import com.lianjia.model.TableCode;
import com.lianjia.model.WechatUser;

@Before(WeixinAuthenticationInterceptor.class)
public class WeixinApiController extends ApiController{

	
	@Clear(WeixinAuthenticationInterceptor.class)
	@Before(WeixinSessionInterceptor.class)
	public void main()
	{

		WechatUser wechatUser = (WechatUser)getSessionAttr(Constants.Controller_SESSION_WeChat_User_Key);
		if(null == wechatUser || StrKit.isBlank(wechatUser.getStr("pager")))
		{
			render("/weixin/login.jsp");
		}
		else
		{
			render("/WEB-INF/jsp/main.jsp");
		}
	
	}
	
	
	
	public void toLogin()
	{
		
		
		render("/weixin/login.jsp");
		
	
	}
	
	
	public void toWeixnMain()
	{
		render("/WEB-INF/jsp/main.jsp");
	}
	
	public void toadd()
	{
		List<TableCode> degreeList = TableCode.dao.getList("presentee", "degree");
		List<TableCode> originList = TableCode.dao.getList("presentee", "origin");
		setAttr("degreeList", degreeList);
		setAttr("originList", originList);	
		//ResponseResult result= new ResponseResult(false, "添加失败", null);
		
//		model.addAttribute("educationLevel",educationLevel);
//		model.addAttribute("schoolLevels",schoolLevel);
		render("/WEB-INF/jsp/assistantMain.jsp");
	}
	
	
	public void add()
	{
		ResponseResult result= new ResponseResult(true, "保存成功", null);
		Presentee presentee = getModel(Presentee.class, "pst");
		Presentee pst = Presentee.dao.findFirst("SELECT * FROM presentee WHERE phone = ?",presentee.get("phone"));
		if(null != pst)
		{
			result.setSuccess(false);
			result.setMsg("该应聘者已添加！");
			renderJson(result);
			return;
		}
		WechatUser wechatUser = (WechatUser)getSessionAttr(Constants.Controller_SESSION_WeChat_User_Key);
		presentee.set("recordman", wechatUser.get("pager"));
		//TODO :　待做处理
		presentee.set("handleman", 0);
		presentee.set("createtime", new Date());
		presentee.set("lastUpdateTime", new Date());
		if(presentee.save())
		{
			renderJson(result);
			return;
		}
		else
		{
			result.setSuccess(false);
			result.setMsg("保存失败!");
			renderJson(result);
		}
	}
	
	public void presenteeList()
	{
		int pagenum = this.getParaToInt(Constants.PAGENUM,Constants.Page_Num_Default);
		int pagesize =  getParaToInt(Constants.PAGESIZE,Constants.PAGESIZE_DEFAULT) ;
		WechatUser wechatUser = (WechatUser)getSessionAttr(Constants.Controller_SESSION_WeChat_User_Key);
		Page<Presentee> paginate = Presentee.dao.paginate(pagenum, pagesize, "SELECT * ", "FROM presentee WHERE recordman = ? ORDER BY createtime DESC",(Object)wechatUser.get("pager"));
		List<Presentee> list = paginate.getList();
		for(Presentee pst : list)
		{
			pst.toDetailshow();
		}
		setAttr("list", list);
		render("/WEB-INF/jsp/assistant.jsp");
	}
	
	
	public void index() {
        render("/api/index.html");
    }

    /**
     * 获取公众号菜单
     */
    public void getMenu() {
        ApiResult apiResult = MenuApi.getMenu();
        if (apiResult.isSucceed())
            renderText(apiResult.getJson());
        else
            renderText(apiResult.getErrorMsg());
    }
	
	
	/**
     * 获取公众号关注用户
     */
    public void getFollowers() {
        ApiResult apiResult = UserApi.getFollows();
        renderText(apiResult.getJson());
    }
	@Override
	public ApiConfig getApiConfig() {
		ApiConfig ac = new ApiConfig();

        // 配置微信 API 相关常量
        ac.setToken(PropKit.get("token"));
        ac.setAppId(PropKit.get("appId"));
        ac.setAppSecret(PropKit.get("appSecret"));        

        /**
         *  是否对消息进行加密，对应于微信平台的消息加解密方式：
         *  1：true进行加密且必须配置 encodingAesKey
         *  2：false采用明文模式，同时也支持混合模式
         */
        ac.setEncryptMessage(PropKit.getBoolean("encryptMessage", false));
        ac.setEncodingAesKey(PropKit.get("encodingAesKey", "setting it in config file"));
        return ac;
	}

}
