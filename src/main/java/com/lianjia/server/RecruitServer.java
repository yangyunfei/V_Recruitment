package com.lianjia.server;

import java.sql.SQLException;
import java.util.Date;

import com.jfinal.log.Logger;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.IAtom;
import com.lianjia.common.CancleEnum;
import com.lianjia.common.Constants;
import com.lianjia.model.Presentee;
import com.lianjia.model.Recruit;
import com.lianjia.model.RecruitRecord;

public class RecruitServer 
{
	public static final RecruitServer server = new RecruitServer();
	
	private static Logger logger = Logger.getLogger(RecruitServer.class);

	public boolean joinInterview(final Recruit recruit, Date interviewtime) 
	{
		Date date = new Date();
		recruit.set("state", Constants.STATE_WAIT_FIRSTINTERVIEW);
		recruit.set("interviewtime", interviewtime);
		recruit.set("lastUpdateTime", date);
		long pst_id = recruit.getLong("presentee_id");
		final Presentee pst = Presentee.dao.findById(pst_id);
		pst.set("state", Constants.STATE_WAIT_FIRSTINTERVIEW);
		pst.set("lastUpdateTime", date);
		
		final RecruitRecord record = new RecruitRecord();
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

	public boolean breakOff(final Recruit recruit, int cancle) 
	{
		CancleEnum cancleEnum = CancleEnum.getByCode(cancle);
		if (null == cancleEnum || (!Constants.Cancle_type_notInterview.equals(cancleEnum.getGroup())))
		{
			return false;
		}
		Date date = new Date();
		recruit.set("state", Constants.STATE_INVALID);
		recruit.set("cancle", cancle);
		recruit.set("lastUpdateTime", new Date());
		long pst_id = recruit.getLong("presentee_id");
		final Presentee pst = Presentee.dao.findById(pst_id);
		pst.set("cancle", cancle);
		pst.set("lastUpdateTime", date);
		pst.set("handleman", 0);
		pst.set("weight", cancleEnum.getWeight());
		
		final RecruitRecord record = new RecruitRecord();
		record.set("recruit_id", recruit.get("id"));
		record.set("presentee_id", pst_id);
		record.set("handleman", recruit.get("handleman"));
		record.set("state", Constants.STATE_INVALID);
		record.set("description", Constants.Record_BreakOff);
		record.set("cancle", cancle);	
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

	public boolean EditInterview(final Recruit recruit, Date interviewtime) 
	{
		Date date = new Date();
		recruit.set("interviewtime", interviewtime);
		recruit.set("lastUpdateTime", date);
		
		final RecruitRecord record = new RecruitRecord();
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

	public boolean getOutTrain(final Recruit recruit, Integer cancle) {
		CancleEnum cancleEnum = CancleEnum.getByCode(cancle);
		if(null == cancleEnum || (!Constants.Cancle_type_noPassTrain.equals(cancleEnum.getGroup())))
		{
			return false;
		}
		Date date = new Date();
		recruit.set("state", Constants.STATE_INVALID);
		recruit.set("cancle", cancle);
		recruit.set("lastUpdateTime", date);
		long pst_id = recruit.getLong("presentee_id");
		final Presentee pst = Presentee.dao.findById(pst_id);
		pst.set("cancle", cancle);		
		pst.set("handleman", 0);
		pst.set("weight", cancleEnum.getWeight());
		pst.set("lastUpdateTime", date);
		
		final RecruitRecord record = new RecruitRecord();
		record.set("recruit_id", recruit.get("id"));
		record.set("presentee_id", recruit.get("presentee_id"));
		record.set("handleman", recruit.get("handleman"));
		record.set("state", Constants.STATE_INVALID);
		record.set("cancle", cancle);
		record.set("description", Constants.Record_GetOutTrain);
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
	 * 初试通过
	 * @param recruit
	 * @return
	 */
	public boolean pass(final Recruit recruit) {
		Date date = new Date();
		recruit.set("state", Constants.STATE_WAIT_SECONDINTERVIEW);
		recruit.set("lastUpdateTime", date);
		long pst_id = recruit.getLong("presentee_id");
		final Presentee pst = Presentee.dao.findById(pst_id);
		pst.set("state", Constants.STATE_WAIT_SECONDINTERVIEW);
		pst.set("lastUpdateTime", date);
		
		final RecruitRecord record = new RecruitRecord();
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
	public boolean nopass(final Recruit recruit) {
		Date date = new Date();
		recruit.set("state", Constants.STATE_INVALID);
		recruit.set("lastUpdateTime", date);
		recruit.set("cancle", CancleEnum.NotPassInterview.getCancleCode());
		long pst_id = recruit.getLong("presentee_id");
		final Presentee pst = Presentee.dao.findById(pst_id);
		pst.set("state", Constants.STATE_INVALID);
		pst.set("lastUpdateTime", date);
		pst.set("handleman", 0);
		pst.set("weight", CancleEnum.NotPassInterview.getWeight());
		pst.set("cancle", CancleEnum.NotPassInterview.getCancleCode());	
		
		final RecruitRecord record = new RecruitRecord();
		record.set("recruit_id", recruit.get("id"));
		record.set("presentee_id", pst_id);
		record.set("cancle", CancleEnum.NotPassInterview.getCancleCode());
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

	public boolean noComeInterview(final Recruit recruit) {
		Date date = new Date();
		recruit.set("state", Constants.STATE_INVALID);
		recruit.set("lastUpdateTime", date);
		recruit.set("cancle", CancleEnum.NoComeInterview.getCancleCode());
		long pst_id = recruit.getLong("presentee_id");
		final Presentee pst = Presentee.dao.findById(pst_id);
		pst.set("state", Constants.STATE_INVALID);
		pst.set("lastUpdateTime", date);
		pst.set("handleman", 0);
		pst.set("weight", CancleEnum.NoComeInterview.getWeight());
		pst.set("cancle", CancleEnum.NoComeInterview.getCancleCode());	
		
		final RecruitRecord record = new RecruitRecord();
		record.set("recruit_id", recruit.get("id"));
		record.set("presentee_id", pst_id);
		record.set("cancle", CancleEnum.NoComeInterview.getCancleCode());	
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
	public boolean notTrain(final Recruit recruit) 
	{
		Date date = new Date();
		recruit.set("state", Constants.STATE_INVALID);
		recruit.set("lastUpdateTime", new Date());
		recruit.set("cancle", CancleEnum.NotTrain.getCancleCode());
		long pst_id = recruit.getLong("presentee_id");
		final Presentee pst = Presentee.dao.findById(pst_id);
		pst.set("state", Constants.STATE_INVALID);
		pst.set("lastUpdateTime", new Date());
		pst.set("handleman", 0);
		pst.set("weight", CancleEnum.NotTrain.getWeight());
		pst.set("cancle", CancleEnum.NotTrain.getCancleCode());	
		
		RecruitRecord record = new RecruitRecord();
		record.set("recruit_id", recruit.get("id"));
		record.set("presentee_id", pst_id);
		record.set("cancle", CancleEnum.NotTrain.getCancleCode());	
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

	public boolean passTrain(final Recruit recruit)
	{
		Date date = new Date();
		recruit.set("state", Constants.STATE_WAIT_ENTRANT);
		recruit.set("lastUpdateTime", new Date());
		long pst_id = recruit.getLong("presentee_id");
		final Presentee pst = Presentee.dao.findById(pst_id);
		pst.set("state", Constants.STATE_WAIT_ENTRANT);
		pst.set("lastUpdateTime", date);

		RecruitRecord record = new RecruitRecord();
		record.set("recruit_id", recruit.get("id"));
		record.set("presentee_id", recruit.get("presentee_id"));
		record.set("handleman", recruit.get("handleman"));
		record.set("state", Constants.STATE_WAIT_ENTRANT);
		record.set("description", Constants.Record_PassTrain);
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

	public boolean entry(final Recruit recruit) {
		Date date = new Date();
		recruit.set("state", Constants.STATE_HAS_ENTRANT);
		recruit.set("lastUpdateTime", date);
		long pst_id = recruit.getLong("presentee_id");
		final Presentee pst = Presentee.dao.findById(pst_id);
		pst.set("state", Constants.STATE_HAS_ENTRANT);
		pst.set("lastUpdateTime", date);
		
		final RecruitRecord record = new RecruitRecord();
		record.set("recruit_id", recruit.get("id"));
		record.set("presentee_id", pst_id);
		record.set("handleman", recruit.get("handleman"));
		record.set("state", Constants.STATE_HAS_ENTRANT);
		record.set("description", Constants.Record_Entry);
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
	
	public boolean notEntry(final Recruit recruit) {
		Date date = new Date();
		recruit.set("state", Constants.STATE_INVALID);
		recruit.set("lastUpdateTime", date);
		recruit.set("cancle", CancleEnum.NotEntry.getCancleCode());
		
		long pst_id = recruit.getLong("presentee_id");
		final Presentee pst = Presentee.dao.findById(pst_id);
		pst.set("state", Constants.STATE_INVALID);
		pst.set("lastUpdateTime", date);
		pst.set("handleman", 0);
		pst.set("cancle", CancleEnum.NotEntry.getCancleCode());
		
		final RecruitRecord record = new RecruitRecord();
		record.set("recruit_id", recruit.get("id"));
		record.set("presentee_id", pst_id);
		record.set("cancle", CancleEnum.NotEntry.getCancleCode());
		record.set("handleman", recruit.get("handleman"));
		record.set("state", Constants.STATE_INVALID);
		record.set("description", Constants.Record_NotEntry);
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

	public boolean PassEagleEye(final Recruit recruit) {
		Date date = new Date();
		recruit.set("state", Constants.STATE_WAIT_TRAIN);
		recruit.set("lastUpdateTime", date);
		long pst_id = recruit.getLong("presentee_id");
		final Presentee pst = Presentee.dao.findById(pst_id);
		pst.set("state", Constants.STATE_WAIT_TRAIN);
		pst.set("lastUpdateTime", date);
		
		final RecruitRecord record = new RecruitRecord();
		record.set("recruit_id", recruit.get("id"));
		record.set("presentee_id", pst_id);
		record.set("handleman", recruit.get("handleman"));
		record.set("state", Constants.STATE_WAIT_TRAIN);
		record.set("description", Constants.Record_PassEagleEye);
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

	public boolean notPassEagleEye(final Recruit recruit) {
		Date date = new Date();
		recruit.set("state", Constants.STATE_INVALID);
		recruit.set("lastUpdateTime", date);
		recruit.set("cancle", CancleEnum.notPassEagleEye.getCancleCode());	
		long pst_id = recruit.getLong("presentee_id");
		final Presentee pst = Presentee.dao.findById(pst_id);
		pst.set("state", Constants.STATE_INVALID);
		pst.set("lastUpdateTime", date);
		pst.set("handleman", 0);
		pst.set("weight", CancleEnum.notPassEagleEye.getWeight());
		pst.set("cancle", CancleEnum.notPassEagleEye.getCancleCode());	
		
		final RecruitRecord record = new RecruitRecord();
		record.set("recruit_id", recruit.get("id"));
		record.set("presentee_id", pst_id);
		record.set("handleman", recruit.get("handleman"));
		record.set("state", Constants.STATE_INVALID);
		record.set("cancle", CancleEnum.notPassEagleEye.getCancleCode());	
		record.set("description", Constants.Record_NotPassEagleEye);
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

	public boolean notComeEagleEye(final Recruit recruit) {
		Date date = new Date();
		recruit.set("state", Constants.STATE_INVALID);
		recruit.set("lastUpdateTime", date);
		recruit.set("cancle", CancleEnum.notComeEagleEye.getCancleCode());	
		long pst_id = recruit.getLong("presentee_id");
		final Presentee pst = Presentee.dao.findById(pst_id);
		pst.set("state", Constants.STATE_INVALID);
		pst.set("lastUpdateTime", date);
		pst.set("handleman", 0);
		pst.set("weight", CancleEnum.notComeEagleEye.getWeight());
		pst.set("cancle", CancleEnum.notComeEagleEye.getCancleCode());	
		
		final RecruitRecord record = new RecruitRecord();
		record.set("recruit_id", recruit.get("id"));
		record.set("presentee_id", pst_id);
		record.set("handleman", recruit.get("handleman"));
		record.set("state", Constants.STATE_INVALID);
		record.set("cancle", CancleEnum.notComeEagleEye.getCancleCode());	
		record.set("description", Constants.Record_NotComeEagleEye);
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

}
