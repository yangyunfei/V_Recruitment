package com.lianjia.controller;

import java.util.List;

import com.jfinal.aop.Before;
import com.jfinal.aop.Clear;
import com.jfinal.core.Controller;
import com.jfinal.kit.StrKit;
import com.lianjia.interceptor.AuthenticationInterceptor;
import com.lianjia.model.TableCode;

@Before(AuthenticationInterceptor.class)
public class CommonController extends Controller {

	@Clear
	public void getTableCode() {
		String tab, attr;
		if (!StrKit.isBlank(this.getPara())) {
			tab = this.getPara(0);
			attr = this.getPara(1);
		} else {
			tab = this.getPara("tab");
			attr = this.getPara("attr");
		}
		List<TableCode> list = TableCode.dao.getList(tab, attr);
		renderJson(list);
	}

}
