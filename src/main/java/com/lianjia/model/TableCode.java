package com.lianjia.model;

import java.util.List;

import com.jfinal.kit.StrKit;
import com.jfinal.plugin.activerecord.Model;
import com.lianjia.common.Constants;


public class TableCode extends Model<TableCode> {
	private static final long serialVersionUID = 8360405988382274067L;
	public static final TableCode dao = new TableCode();
	
	public List<TableCode> getList(String table,String attr) {
		return this.find( "select code,name from table_code where tablename=? and attribute=? ", table,attr);
	}
	
	public String GetSimpleCodeName(String table,String attr,String code) {
		int  key=(table+attr+code).hashCode();
		List<TableCode> list=  this.findByCache("system",key, "select * from table_code where tablename=? and attribute=? and code=?",table,attr,code);
		if(list.size()>0)
			return  list.get(0).getStr("name");
		else
			return null;

	}
	
	public String GetCodeName(String table,String attr,String code) {
		if(StrKit.isBlank(code)) return null;
		
		if(!code.contains(Constants.SplitStr)) {
			return GetSimpleCodeName(table,attr,code);
		} else {
			String[] attrs= code.split(Constants.SplitStr);
			String str="";
			for(int i=0;i<attrs.length;i++) {
				if(i==0)
					str=GetSimpleCodeName(table,attr,attrs[i]);
				else
					str=str+Constants.SplitStr+GetSimpleCodeName(table,attr,attrs[i]);
			}
			return str;
		}
	}
}