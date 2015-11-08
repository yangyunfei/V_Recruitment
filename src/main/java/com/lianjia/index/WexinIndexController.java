package com.lianjia.index;

import java.util.Arrays;

import org.apache.commons.codec.digest.DigestUtils;

import com.jfinal.core.Controller;
import com.jfinal.kit.PropKit;
import com.jfinal.kit.StrKit;

public class WexinIndexController extends Controller 
{
	public void index() 
	{
		render("/weixin/login.jsp");
	}
	
//	public void index() {
//
//		String echostr = getPara("echostr");
//		if (checkSignature() && StrKit.notBlank(echostr)) {
//			renderText(echostr);// 推送
//		} else {
//			renderText("校验失败");
//		}
//
//	}
	
	
	private boolean checkSignature()
    {

        String signature = getPara("signature");
		String timestamp = getPara("timestamp");
		String nonce = getPara("nonce");
		if(!StrKit.notBlank(signature,timestamp,nonce))
		{
			return false;
		}     
        String token = PropKit.get("token");
		String[] ArrTmp = {token,timestamp,nonce};
		Arrays.sort(ArrTmp);
		String tmpStr = String.join("", ArrTmp);
		tmpStr = DigestUtils.sha1Hex(tmpStr);
		tmpStr = tmpStr.toLowerCase();
        if (tmpStr.equals(signature))
        {
            return true;
        }
        else
        {
            return false;
        }
    }
}
