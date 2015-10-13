package com.lianjia.config;


import com.jfinal.config.Constants;
import com.jfinal.config.Handlers;
import com.jfinal.config.Interceptors;
import com.jfinal.config.JFinalConfig;
import com.jfinal.config.Plugins;
import com.jfinal.config.Routes;
import com.jfinal.plugin.activerecord.ActiveRecordPlugin;
import com.jfinal.plugin.c3p0.C3p0Plugin;
import com.jfinal.plugin.ehcache.EhCachePlugin;
import com.jfinal.render.ViewType;
import com.jfinal.weixin.sdk.api.ApiConfigKit;
import com.lianjia.index.IndexController;
import com.lianjia.model.Agent;
import com.lianjia.model.Employee;
import com.lianjia.model.Remark;
import com.lianjia.model.User;







public class V_RecruitmentConfig extends JFinalConfig {

	@Override
	public void configConstant(Constants me) {   
	    loadPropertyFile("config.txt");
		me.setDevMode(getPropertyToBoolean("devMode", false));
		me.setViewType(ViewType.JSP);
	         
	    // ApiConfigKit 设为开发模式可以在开发阶段输出请求交互的 xml 与 json 数据
	    ApiConfigKit.setDevMode(me.getDevMode());
		
	}

	@Override
	public void configHandler(Handlers arg0) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void configInterceptor(Interceptors arg0) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void configPlugin(Plugins me) {
		// 配置C3p0数据库连接池插件
		C3p0Plugin c3p0Plugin = new C3p0Plugin(getProperty("jdbcUrl"), getProperty("user"), getProperty("password").trim());
		me.add(c3p0Plugin);
		me.add(new EhCachePlugin());
		
		// 配置ActiveRecord插
		ActiveRecordPlugin arp = new ActiveRecordPlugin(c3p0Plugin);
		arp.setShowSql(true);
		me.add(arp);
		
		arp.addMapping("user", User.class);
		arp.addMapping("agent", "pager",Agent.class);
		arp.addMapping("employee", Employee.class);
		arp.addMapping("remark", Remark.class);
		
	}

	@Override
	public void configRoute(Routes me) {
		
		me.add("/", IndexController.class);
	}

}
