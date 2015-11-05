package com.lianjia.server;

import java.sql.SQLException;
import java.util.Date;

import com.jfinal.log.Logger;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.IAtom;
import com.jfinal.plugin.activerecord.tx.Tx;
import com.lianjia.common.Constants;
import com.lianjia.model.Presentee;
import com.lianjia.model.Recruit;

public class RecruitServer 
{
	public static final RecruitServer server = new RecruitServer();
	
	private static Logger logger = Logger.getLogger(RecruitServer.class);

	public boolean joinInterview(Recruit recruit, Date interviewtime) 
	{
		recruit.set("state", Constants.STATE_WAIT_FIRSTINTERVIEW);
		recruit.set("interviewtime", interviewtime);
		recruit.set("lastUpdateTime", new Date());
		long pst_id = recruit.getLong("presentee_id");
		Presentee pst = Presentee.dao.findById(pst_id);
		pst.set("state", Constants.STATE_WAIT_FIRSTINTERVIEW);
		pst.set("lastUpdateTime", new Date());
		
		boolean tx = Db.tx(new IAtom() 
		{			
			@Override
			public boolean run() throws SQLException 
			{				
				return recruit.update()&&pst.update();
			}
		});
		return tx;
		
		
	}

	public boolean breakOff(Recruit recruit, int cancle) 
	{
		recruit.set("state", Constants.STATE_INVALID);
		recruit.set("cancle", cancle);
		recruit.set("lastUpdateTime", new Date());
		long pst_id = recruit.getLong("presentee_id");
		Presentee pst = Presentee.dao.findById(pst_id);
		pst.set("cancle", cancle);
		//放入历史
		if(1 ==cancle||cancle==3||cancle==6||cancle==7)
		{
			pst.set("handleman", 0);
			pst.set("weight", 1);
			pst.set("lastUpdateTime", new Date());
		}
		else
		{
			pst.set("handleman", 0);
			pst.set("lastUpdateTime", new Date());
		}
		
		boolean tx = Db.tx(new IAtom() 
		{			
			@Override
			public boolean run() throws SQLException 
			{				
				return recruit.update()&&pst.update();
			}
		});
		
		return tx;
	}

	public boolean EditInterview(Recruit recruit, Date interviewtime) {
		recruit.set("interviewtime", interviewtime);
		recruit.set("lastUpdateTime", new Date());
		return recruit.update();
	}

	public boolean getOutTrain(Recruit recruit, Integer cancle) {
		recruit.set("state", Constants.STATE_INVALID);
		recruit.set("cancle", cancle);
		recruit.set("lastUpdateTime", new Date());
		long pst_id = recruit.getLong("presentee_id");
		Presentee pst = Presentee.dao.findById(pst_id);
		pst.set("cancle", cancle);
		//放入历史
		
		pst.set("handleman", 0);
		pst.set("weight", 1);
		pst.set("lastUpdateTime", new Date());
		
		
		boolean tx = Db.tx(new IAtom() 
		{			
			@Override
			public boolean run() throws SQLException 
			{				
				return recruit.update()&&pst.update();
			}
		});
		
		return tx;
	}

}
