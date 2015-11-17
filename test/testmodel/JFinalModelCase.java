package testmodel;

import org.junit.After;
import org.junit.BeforeClass;


import com.jfinal.plugin.activerecord.ActiveRecordPlugin;
import com.jfinal.plugin.c3p0.C3p0Plugin;
import com.lianjia.model.Agent;
import com.lianjia.model.BusinessArea;
import com.lianjia.model.Module;
import com.lianjia.model.Presentee;
import com.lianjia.model.Recruit;
import com.lianjia.model.RecruitRecord;
import com.lianjia.model.Remark;
import com.lianjia.model.Role;
import com.lianjia.model.School;
import com.lianjia.model.TableCode;
import com.lianjia.model.User;
import com.lianjia.model.V_Recruit;
import com.lianjia.model.V_Source;
import com.lianjia.model.WechatUser;

/**
 * @author ff
 * JFinal的Model测试用例
 */
public class JFinalModelCase 
{
	protected static C3p0Plugin c3p0Plugin;
	protected static ActiveRecordPlugin arp;
	

	/**
	 * 数据连接地址
	*/
	private static final String URL = "jdbc:mysql://10.10.4.20/v_recruitment?characterEncoding=utf8&zeroDateTimeBehavior=convertToNull";
	
	/**
	 * 数据库账号
	 */
	private static final String USER = "root";
	
	/**
	 * 数据库密码
	 */
	private static final String PASSWORD = "root123";
	
	@BeforeClass
	public static void setUpBeforeClass() throws Exception
	{
		c3p0Plugin = new C3p0Plugin(URL, USER,PASSWORD);
		c3p0Plugin.start();
		arp = new ActiveRecordPlugin(c3p0Plugin);
		arp.setShowSql(true);
		
		//配置数据库和具体类的实现
		arp.addMapping("user", User.class);
		arp.addMapping("wechatuser", WechatUser.class);
		arp.addMapping("agent", "pager",Agent.class);
		arp.addMapping("school",School.class);
		arp.addMapping("presentee", Presentee.class);
		arp.addMapping("remark", Remark.class);
		arp.addMapping("module", Module.class);
		arp.addMapping("role", Role.class);
		arp.addMapping("table_code", TableCode.class);
		arp.addMapping("business_area", BusinessArea.class);
		arp.addMapping("recruit", Recruit.class);
		arp.addMapping("recruit_record",RecruitRecord.class);
		arp.addMapping("v_recruit",V_Recruit.class);
		arp.addMapping("v_source",V_Source.class);
		
		arp.start();		
	}
	
	@After
	public void tearDown() throws Exception
	{
		c3p0Plugin.stop();
		arp.stop();
	}
	
}
