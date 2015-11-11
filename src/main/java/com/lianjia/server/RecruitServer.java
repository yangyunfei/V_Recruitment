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

public class RecruitServer 
{
	public static final RecruitServer server = new RecruitServer();
	
	private static Logger logger = Logger.getLogger(RecruitServer.class);

	public boolean joinInterview(Recruit recruit, Date interviewtime) 
	{
		Date date = new Date();
		recruit.set("state", Constants.STATE_WAIT_FIRSTINTERVIEW);
		recruit.set("interviewtime", interviewtime);
		recruit.set("lastUpdateTime", date);
		long pst_id = recruit.getLong("presentee_id");
		Presentee pst = Presentee.dao.findById(pst_id);
		pst.set("state", Constants.STATE_WAIT_FIRSTINTERVIEW);
		pst.set("lastUpdateTime", new Date());
		
		RecruitRecord record = new RecruitRecord();
		record.set("recruit_id", recruit.get("id"));
		record.set("presentee_id", pst.get("id"));
		record.set("handleman", recruit.get("handleman"));
		record.set("state", Constants.STATE_WAIT_FIRSTINTERVIEW);
		record.set("description", Constants.Record_joinInterview);
		record.set("createtime", date);		
		
		boolean tx = Db.tx(new IAtom() 
		{			
			@Override
			public boolean run() throws SQLException 
			{				
				return recruit.update()&&pst.update()&&record.save();
			}
		});
		return tx;
		
		
	}

	public boolean breakOff(Recruit recruit, int cancle) 
	{
		Date date = new Date();
		recruit.set("state", Constants.STATE_INVALID);
		recruit.set("cancle", cancle);
		recruit.set("lastUpdateTime", new Date());
		long pst_id = recruit.getLong("presentee_id");
		Presentee pst = Presentee.dao.findById(pst_id);
		pst.set("cancle", cancle);
		pst.set("lastUpdateTime", date);
		
		RecruitRecord record = new RecruitRecord();
		record.set("recruit_id", recruit.get("id"));
		record.set("presentee_id", pst_id);
		record.set("handleman", recruit.get("handleman"));
		record.set("state", Constants.STATE_INVALID);
		record.set("description", Constants.Record_BreakOff);
		record.set("cancle", cancle);	
		record.set("createtime", date);		
		
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
				return recruit.update()&&pst.update()&&record.save();
			}
		});
		
		return tx;
	}

	public boolean EditInterview(Recruit recruit, Date interviewtime) 
	{
		Date date = new Date();
		recruit.set("interviewtime", interviewtime);
		recruit.set("lastUpdateTime", date);
		
		RecruitRecord record = new RecruitRecord();
		record.set("recruit_id", recruit.get("id"));
		record.set("presentee_id", recruit.get("presentee_id"));
		record.set("handleman", recruit.get("handleman"));
		record.set("state", Constants.STATE_WAIT_FIRSTINTERVIEW);
		record.set("description", Constants.Record_EditInterview);
		record.set("createtime", date);		
		boolean tx = Db.tx(new IAtom() 
		{			
			@Override
			public boolean run() throws SQLException 
			{				
				return recruit.update()&&record.save();
			}
		});
		return tx;
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

	/**
	 * 初试通过
	 * @param recruit
	 * @return
	 */
	public boolean pass(Recruit recruit) {
		Date date = new Date();
		recruit.set("state", Constants.STATE_WAIT_SECONDINTERVIEW);
		recruit.set("lastUpdateTime", date);
		long pst_id = recruit.getLong("presentee_id");
		Presentee pst = Presentee.dao.findById(pst_id);
		pst.set("state", Constants.STATE_WAIT_SECONDINTERVIEW);
		pst.set("lastUpdateTime", date);
		
		RecruitRecord record = new RecruitRecord();
		record.set("recruit_id", recruit.get("id"));
		record.set("presentee_id", pst_id);
		record.set("handleman", recruit.get("handleman"));
		record.set("state", Constants.STATE_WAIT_SECONDINTERVIEW);
		record.set("description", Constants.Record_Pass);
		record.set("createtime", date);	
		boolean tx = Db.tx(new IAtom() 
		{			
			@Override
			public boolean run() throws SQLException 
			{				
				return recruit.update()&&pst.update()&&record.save();
			}
		});
		return tx;
		
	}

	/**
	 * 初试未通过
	 * @param recruit
	 * @return
	 */
	public boolean nopass(Recruit recruit) {
		Date date = new Date();
		recruit.set("state", Constants.STATE_INVALID);
		recruit.set("lastUpdateTime", date);
		recruit.set("cancle", 8);
		long pst_id = recruit.getLong("presentee_id");
		Presentee pst = Presentee.dao.findById(pst_id);
		pst.set("state", Constants.STATE_INVALID);
		pst.set("lastUpdateTime", date);
		pst.set("handleman", 0);
		pst.set("weight", 1);
		pst.set("cancle", 8);	
		
		RecruitRecord record = new RecruitRecord();
		record.set("recruit_id", recruit.get("id"));
		record.set("presentee_id", pst_id);
		record.set("handleman", recruit.get("handleman"));
		record.set("state", Constants.STATE_INVALID);
		record.set("description", Constants.Record_Nopass);
		record.set("createtime", date);		
		
		boolean tx = Db.tx(new IAtom() 
		{			
			@Override
			public boolean run() throws SQLException 
			{				
				return recruit.update()&&pst.update()&&record.save();
			}
		});
		return tx;
	}

	public boolean noComeInterview(Recruit recruit) {
		Date date = new Date();
		recruit.set("state", Constants.STATE_INVALID);
		recruit.set("lastUpdateTime", date);
		recruit.set("cancle", 9);
		long pst_id = recruit.getLong("presentee_id");
		Presentee pst = Presentee.dao.findById(pst_id);
		pst.set("state", Constants.STATE_INVALID);
		pst.set("lastUpdateTime", date);
		pst.set("handleman", 0);
		pst.set("weight", 0);
		pst.set("cancle", 9);	
		
		RecruitRecord record = new RecruitRecord();
		record.set("recruit_id", recruit.get("id"));
		record.set("presentee_id", pst_id);
		record.set("handleman", recruit.get("handleman"));
		record.set("state", Constants.STATE_INVALID);
		record.set("description", Constants.Record_NoComeInterview);
		record.set("createtime", date);		
		boolean tx = Db.tx(new IAtom() 
		{			
			@Override
			public boolean run() throws SQLException 
			{				
				return recruit.update()&&pst.update()&&record.save();
			}
		});
		return tx;
	}

	/**
	 * 没有参加培训
	 * @param recruit
	 * @return
	 */
	public boolean notTrain(Recruit recruit) 
	{
		Date date = new Date();
		recruit.set("state", Constants.STATE_INVALID);
		recruit.set("lastUpdateTime", new Date());
		recruit.set("cancle", 10);
		long pst_id = recruit.getLong("presentee_id");
		Presentee pst = Presentee.dao.findById(pst_id);
		pst.set("state", Constants.STATE_INVALID);
		pst.set("lastUpdateTime", new Date());
		pst.set("handleman", 0);
		pst.set("weight", 0);
		pst.set("cancle", 10);	
		
		RecruitRecord record = new RecruitRecord();
		record.set("recruit_id", recruit.get("id"));
		record.set("presentee_id", pst_id);
		record.set("handleman", recruit.get("handleman"));
		record.set("state", Constants.STATE_INVALID);
		record.set("description", Constants.Record_NotTrain);
		record.set("createtime", date);		
		
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

	public boolean passTrain(Recruit recruit) {
		recruit.set("state", Constants.STATE_WAIT_ENTRANT);
		recruit.set("lastUpdateTime", new Date());
		long pst_id = recruit.getLong("presentee_id");
		Presentee pst = Presentee.dao.findById(pst_id);
		pst.set("state", Constants.STATE_WAIT_ENTRANT);
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
