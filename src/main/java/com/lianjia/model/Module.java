package com.lianjia.model;

import java.util.ArrayList;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Set;

import com.jfinal.plugin.activerecord.Model;



public class Module extends Model<Module> {
	public static final Module dao = new Module();
		
	public List<Module> findAllModule() {
		List<Module> allModules = dao.find("SELECT * FROM module ORDER BY sort");
		return allModules;
	}
	public Set<Module> getModule(List<Role> roleList) {
		List<Module> moduleList=new ArrayList<Module>();
		//Set<Module> modules=new HashSet<Module>();
		for(Role r:roleList) {
			List<Module> list=dao.find(String.format("select * from module where id in (%s)  order by sort asc", r.getStr("module")));
			moduleList.addAll(list);
		}
		Set<Module> modules=new LinkedHashSet<Module>(moduleList);
			
		return modules;
	}
		
	public List<Module> getModuleList(String moduleids) {
		List<Module> list = dao.find(String.format("select * from module where id in (%s)", moduleids));
		return list;
	}
	// action是否在控制表中
	public  Module getUrl(String url) {
		List<Module> list = this.find("select * from module where url  =?", url);
		if(list!=null&&list.size()>0)
			return list.get(0);
		else
			return null;
	}
}