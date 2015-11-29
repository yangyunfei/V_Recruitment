package com.lianjia.server;

import java.sql.SQLException;
import java.util.Date;

import com.jfinal.log.Logger;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.IAtom;
import com.lianjia.common.Constants;
import com.lianjia.model.Presentee;
import com.lianjia.model.Recruit;
import com.lianjia.model.RecruitRecord;
import com.lianjia.model.User;

public class SourceServer 
{
	public static final SourceServer server = new SourceServer();
	
	private static Logger logger = Logger.getLogger(SourceServer.class);

	public boolean accept(final Presentee pst, User user) {
		Date date = new Date();
		pst.set("handleman", user.get("id"));
		pst.set("lasthandleman", user.get("id"));
		pst.set("lastUpdateTime", date);
		pst.set("state", Constants.STATE_SUSPENDING);
		final Recruit recruit = new Recruit();
		recruit.set("handleman", user.getLong("id"));
		recruit.set("presentee_id", pst.get("id"));
		recruit.set("state", Constants.STATE_SUSPENDING);
		recruit.set("createtime",date);	
		recruit.set("lastUpdateTime",date);	
		
		final RecruitRecord record = new RecruitRecord();
		record.set("presentee_id", pst.get("id"));
		record.set("handleman", user.get("id"));
		record.set("state", Constants.STATE_SUSPENDING);
		record.set("description", Constants.Record_accept);
		record.set("createtime", date);		
			
		boolean tx = Db.tx(new IAtom() 
		{			
			@Override
			public boolean run() throws SQLException 
			{			
				boolean save1 = recruit.save();
				boolean update1 = pst.update();
				boolean save2 = record.set("recruit_id", recruit.get("id")).save();
				
				return save1&&update1&&save2;
			}
		});
		
		return tx;		
		
	}
}
