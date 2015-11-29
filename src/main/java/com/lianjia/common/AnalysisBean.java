package com.lianjia.common;

import java.util.Date;

public class AnalysisBean 
{
	private Long invalid = 0l;
	
	private Long suspending = 0l;
	
	private Long waitfirstinterview = 0l;
	
	private Long waitsecondinterview = 0l;
	
	private Long waittrain = 0l;
	
	private Long waitentrant = 0l;
	
	private Long hasentrant = 0l;
	
	private Long total = 0l;
	
	private String date ;

	public Long getInvalid() {
		return invalid;
	}

	public void setInvalid(Long invalid) {
		this.invalid = invalid;
	}

	public Long getSuspending() {
		return suspending;
	}

	public void setSuspending(Long suspending) {
		this.suspending = suspending;
	}

	public Long getWaitfirstinterview() {
		return waitfirstinterview;
	}

	public void setWaitfirstinterview(Long waitfirstinterview) {
		this.waitfirstinterview = waitfirstinterview;
	}

	public Long getWaitsecondinterview() {
		return waitsecondinterview;
	}

	public void setWaitsecondinterview(Long waitsecondinterview) {
		this.waitsecondinterview = waitsecondinterview;
	}

	public Long getWaittrain() {
		return waittrain;
	}

	public void setWaittrain(Long waittrain) {
		this.waittrain = waittrain;
	}

	public Long getWaitentrant() {
		return waitentrant;
	}

	public void setWaitentrant(Long waitentrant) {
		this.waitentrant = waitentrant;
	}

	public Long getHasentrant() {
		return hasentrant;
	}

	public void setHasentrant(Long hasentrant) {
		this.hasentrant = hasentrant;
	}

	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}
	
	
	
	public Long getTotal() {
		return total;
	}

	public void setTotal(Long total) {
		this.total = total;
	}
	
	public void addTotal(Long total) {
		this.total = this.total + total;
	}

	public void setData(int state,Long count)
	{
		switch (state) {
		case Constants.STATE_INVALID:
			invalid = count;
			break;
		case Constants.STATE_SUSPENDING:
			suspending = count;
			break;
		case Constants.STATE_WAIT_FIRSTINTERVIEW:
			waitfirstinterview = count;
			break;
		case Constants.STATE_WAIT_SECONDINTERVIEW:
			waitsecondinterview = count;
			break;
		case Constants.STATE_WAIT_TRAIN:
			waittrain = count;
			break;
		case Constants.STATE_WAIT_ENTRANT:
			waitentrant = count;
			break;
		case Constants.STATE_HAS_ENTRANT:
			hasentrant = count;
			break;
		default:
			break;
		}
	}
}
