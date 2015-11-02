package com.lianjia.tools;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;

public class ToolDate {
	/**
	 * 增加天数
	 * 
	 * @param date
	 * @return
	 * @throws ParseException
	 */
	public static String DateAddOne(String date,int n) {
		try {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			Calendar cd = Calendar.getInstance();
			cd.setTime(sdf.parse(date));
			cd.add(Calendar.DATE, n);
			return sdf.format(cd.getTime());
		} catch (Exception e) {
			return date;
		}
	}
}
