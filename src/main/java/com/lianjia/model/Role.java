package com.lianjia.model;

import java.util.List;
import com.jfinal.kit.StrKit;
import com.jfinal.plugin.activerecord.Model;


public class Role extends Model<Role> {
		public static final Role dao = new Role();
		
		public List<Role> findAllRole() {
			List<Role> allRole = dao.find("select * from role");
		    return allRole;
		}
		/**
		 *  查找拥有相关模块的角色
		 * @param moduleId
		 * @return
		 */
		public List<Role> findRoleByModule(int moduleId) {
			String sql=String.format("select * from role where module REGEXP '[^0-9]%d[^0-9]|^%d[^0-9]|[^0-9]%d$' ", moduleId,moduleId,moduleId);
			return dao.find(sql);
		}
		
		public String getRoleStr(String roles) {
			if(StrKit.isBlank(roles)) return "";
			List<Role> roleList= dao.find(String.format("select role_name from role where id in (%s)", roles));
			String str="";
			for(Role r:roleList) {
				if(StrKit.isBlank(str))
					str=r.getStr("role_name");
				else
					str=str+","+r.getStr("role_name");
			}
			return str;
		}
		public List<Role> getRoleList(String roles) {
			if(StrKit.isBlank(roles)) return null;
			List<Role> roleList= dao.find(String.format("select distinct * from role where id in (%s)", roles));
			return roleList;
		}
}