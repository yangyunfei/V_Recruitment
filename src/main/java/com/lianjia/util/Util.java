package com.lianjia.util;

import java.io.BufferedInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.ObjectOutputStream;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.regex.Pattern;

import org.apache.commons.httpclient.Header;
import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.methods.GetMethod;
import org.apache.http.HttpHost;
import org.apache.http.HttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.conn.params.ConnRouteParams;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.params.HttpConnectionParams;


public class Util {
	// userId,orgId,city
	public static void main(String[] args) {
//		Calendar c = Calendar.getInstance();
//		System.out.println(c.get(Calendar.DATE));
		// Util util = new Util();

		// util.sendGet1("http://172.16.5.23:9080/le8server/login.jsp");

		// String body = "j_username=lina18&j_password=2008324";
		// String body ="j_username=yangyh21&j_password=2008324";
		// util.sendPost("http://sezhun_was01.homelink.com.cn/HomeSE_customer/j_security_check",
		// body);
		// util.sendPost(
		// "http://nseapp.homelink.com.cn/HomeSE_house/j_security_check",
		// body);
		// util.sendRedirects();

		// String[] returnV = util
		// .connect("http://nseapp.homelink.com.cn/HomeSE_house/j_security_check?j_username=lina18&j_password=2008324");
		// String[] returnV =
		// util.connect("http://nseapp.homelink.com.cn/HomeSE_house/j_security_check?j_username=20014367&j_password=123456789");
		// if ("200".equals(returnV[0])) {
		// System.out.println(returnV[1]);
		// LoginHttpClientRequest request = new LoginHttpClientRequest();
		// request.paseJson(returnV[1]);
		// System.out.println(request.employeeName + "," + request.employeeSN
		// + "," + request.currentOrgLevel + ","
		// + request.currentOrgType + "," + request.mobile);
		// }
		// System.out.println(formatDate());
		// System.out.println(phoneSubstring("12345678901"));
		// long time = System.currentTimeMillis();
		// Date date = new Date(time);
		// SimpleDateFormat formatter2 = new
		// SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		// System.out.println(formatter2.format(date));
		// System.out.println(System.currentTimeMillis()+"");
		// formatCurrentTimeHmsToLong();
//		System.out.println(phoneSubstring("1234567823"));
	}

	public String[] connect(String urlStr) {
		String[] bodyJson = new String[3];
		try {
			HttpClient client = new HttpClient();
			GetMethod getMethod = new GetMethod(urlStr);
			int statusCode = client.executeMethod(getMethod);

			Header header[] = getMethod.getRequestHeaders();
			for (int i = 0; i < header.length; i++) {
				System.out.println(header[i].getName() + ":"
						+ header[i].getValue());
				if (i == 3) {
					bodyJson[2] = header[i].getValue();
				}
			}
			System.out.println("返回码: " + statusCode);
			byte[] body = getMethod.getResponseBody();
			bodyJson[0] = statusCode + "";
			bodyJson[1] = new String(body, "utf-8");
			getMethod.releaseConnection();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return bodyJson;
	}

	public void send1() {
		try {
			DefaultHttpClient httpClient = new DefaultHttpClient();

			HttpHost proxy = new HttpHost("nseapp.homelink.com.cn", 80);
			httpClient.getParams().setParameter(ConnRouteParams.DEFAULT_PROXY,
					proxy);
			HttpConnectionParams.setConnectionTimeout(httpClient.getParams(),
					20 * 1000);
			HttpConnectionParams
					.setSoTimeout(httpClient.getParams(), 20 * 1000);
			HttpGet httpget = new HttpGet(
					"http://nseapp.homelink.com.cn/HomeSE_house/j_security_check?j_username=lina18&j_password=2008324");
			HttpResponse response = httpClient.execute(httpget);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public static boolean sendPost(String urlStr, String body) {
		String value = "";
		boolean b = false;
		try {
			HttpURLConnection urlConnection = null;
			URL url = new URL(urlStr);
			urlConnection = (HttpURLConnection) url.openConnection();
			urlConnection.setInstanceFollowRedirects(false);
			urlConnection.setConnectTimeout(30000);
			urlConnection.setReadTimeout(30000);
			urlConnection.setRequestMethod("POST");
			urlConnection.setDoOutput(true);
			urlConnection.setDoInput(true);
			urlConnection.setUseCaches(false);
			urlConnection.setRequestProperty("Accept-Charset", "UTF-8");
			urlConnection.setRequestProperty("Content-Type",
					"application/x-www.form-urlencoded");
			urlConnection.setRequestProperty("Content-Encoding", "UTF-8");
			urlConnection
					.setRequestProperty("User-Agent",
							"Mozilla/5.0 (Windows NT 6.1; WOW64; Trident/7.0; rv:11.0) like Gecko");
			
			urlConnection.getOutputStream().write(body.getBytes("UTF-8"));
//			ObjectOutputStream oop = getObjOutStream(urlConnection);
//			oop.writeObject(body);
//			oop.flush();
//			oop.close();
			urlConnection.getOutputStream().flush();
			urlConnection.getOutputStream().close();
			//getObjOutStream
			InputStream inputStream = urlConnection.getInputStream();
			Map<String, List<String>> map = urlConnection.getHeaderFields();
			Set<String> set = map.keySet();
			for (String str : set) {
				System.out.println(str + "---" + map.get(str));
				// if ("Set-Cookie".equals(str)) {
				// List<String> list = map.get(str);
				// for (String v : list) {
				// if (value.indexOf("LtpaToken2") > 0) {
				// b = true;
				// break;
				// }
				// System.out.println(v);
				// }
				//
				// }
			}
			int total = urlConnection.getInputStream().available();
			byte[] b1 = new byte[total];
			inputStream.read(b1);
			String str = new String(b1, "utf-8");
			System.out.println("str====" + str);
			// getContent(urlConnection,"");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return b;
	}

	public void sendGet1(String urlStr) {
		try {
			// urlStr =
			// "http://172.16.31.83:8080/le8_homelink_call/api/serverApi/forAddHouseDelByOwner/"
			// + ownerinfoId + "/" + delegationType;
			HttpURLConnection urlConnection = null;
			URL url = new URL(urlStr);
			urlConnection = (HttpURLConnection) url.openConnection();
			urlConnection.setRequestMethod("GET");
			urlConnection.setUseCaches(false);
			urlConnection.setDoOutput(false);
			urlConnection.setDoInput(true);
			// urlConnection.setRequestProperty("ownerinfoId", ownerinfoId);
			// urlConnection.setRequestProperty("delegationType",
			// delegationType);
			int responseCode = urlConnection.getResponseCode();
			System.out.println("responseCode=" + responseCode);
			String responseMsg = urlConnection.getResponseMessage();
			InputStream ins = urlConnection.getInputStream();
			BufferedInputStream bis = new BufferedInputStream(ins);
			ByteArrayOutputStream baos = new ByteArrayOutputStream();
			int c;
			while (-1 != (c = bis.read())) {
				baos.write(c);
			}
			bis.close();
			ins.close();
			baos.flush();
			byte[] data = baos.toByteArray();
			responseMsg = new String(data);
			System.out.println("responseMsg=" + responseMsg);
			// JSONObject jsn = newSONObject(responseMsg);
			// urlConnection.setConnectTimeout(30000);
			// urlConnection.setReadTimeout(30000);
			// urlConnection.setRequestMethod("POST");
			// urlConnection.setDoOutput(true);
			// urlConnection.setDoInput(true);
			// urlConnection.setUseCaches(false);
			// urlConnection.setRequestProperty("Content-Type",
			// "text/xml; charset=UTF-8");
			// urlConnection.getOutputStream().write(body.getBytes());
			// urlConnection.getOutputStream().flush();
			// urlConnection.getOutputStream().close();

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public void sendGet(String urlStr, String ownerinfoId, String delegationType) {
		try {
			urlStr = "http://172.16.31.83:8080/le8_homelink_call/api/serverApi/forAddHouseDelByOwner/"
					+ ownerinfoId + "/" + delegationType;
			HttpURLConnection urlConnection = null;
			URL url = new URL(urlStr);
			urlConnection = (HttpURLConnection) url.openConnection();
			urlConnection.setRequestMethod("GET");
			urlConnection.setUseCaches(false);
			urlConnection.setDoOutput(false);
			urlConnection.setDoInput(true);
			// urlConnection.setRequestProperty("ownerinfoId", ownerinfoId);
			// urlConnection.setRequestProperty("delegationType",
			// delegationType);
			int responseCode = urlConnection.getResponseCode();
			System.out.println("responseCode=" + responseCode);
			String responseMsg = urlConnection.getResponseMessage();
			InputStream ins = urlConnection.getInputStream();
			BufferedInputStream bis = new BufferedInputStream(ins);
			ByteArrayOutputStream baos = new ByteArrayOutputStream();
			int c;
			while (-1 != (c = bis.read())) {
				baos.write(c);
			}
			bis.close();
			ins.close();
			baos.flush();
			byte[] data = baos.toByteArray();
			responseMsg = new String(data);
			System.out.println("responseMsg=" + responseMsg);
			// JSONObject jsn = newSONObject(responseMsg);
			// urlConnection.setConnectTimeout(30000);
			// urlConnection.setReadTimeout(30000);
			// urlConnection.setRequestMethod("POST");
			// urlConnection.setDoOutput(true);
			// urlConnection.setDoInput(true);
			// urlConnection.setUseCaches(false);
			// urlConnection.setRequestProperty("Content-Type",
			// "text/xml; charset=UTF-8");
			// urlConnection.getOutputStream().write(body.getBytes());
			// urlConnection.getOutputStream().flush();
			// urlConnection.getOutputStream().close();

		} catch (Exception e) {
			e.printStackTrace();
		}
	}


	private void sendRedirects() {
		try {
			String url = "http://nseapp.homelink.com.cn/HomeSE_house/j_security_check?j_username=lina18&j_password=2008324";
			System.out.println("访问地址:" + url);
			URL serverUrl = new URL(url);
			HttpURLConnection conn = (HttpURLConnection) serverUrl
					.openConnection();
			conn.setRequestMethod("GET");
			// 必须设置false，否则会自动redirect到Location的地址
			conn.setInstanceFollowRedirects(false);
			conn.setUseCaches(false);
			conn.setDoOutput(false);
			conn.setDoInput(true);
			conn.addRequestProperty("Accept-Charset", "UTF-8;");
			conn.addRequestProperty("User-Agent",
					"Mozilla/5.0 (Windows; U; Windows NT 5.1; zh-CN; rv:1.9.2.8) Firefox/3.6.8");
			conn.addRequestProperty("Referer", "http://zuidaima.com/");
			conn.connect();

			int responseCode1 = conn.getResponseCode();
			System.out.println("responseCode=" + responseCode1);
			String responseMsg1 = conn.getResponseMessage();

			InputStream ins1 = conn.getInputStream();
			BufferedInputStream bis1 = new BufferedInputStream(ins1);
			ByteArrayOutputStream baos1 = new ByteArrayOutputStream();
			int c1;
			while (-1 != (c1 = bis1.read())) {
				baos1.write(c1);
			}
			bis1.close();
			ins1.close();
			baos1.flush();
			byte[] data1 = baos1.toByteArray();
			responseMsg1 = new String(data1);
			System.out.println("responseMsg1=" + responseMsg1);

			String location = conn.getHeaderField("Location");

			serverUrl = new URL(location);
			conn = (HttpURLConnection) serverUrl.openConnection();
			conn.setRequestMethod("GET");
			conn.setInstanceFollowRedirects(false);
			conn.setUseCaches(false);
			conn.setDoOutput(false);
			conn.setDoInput(true);
			conn.addRequestProperty("Accept-Charset", "UTF-8;");
			conn.addRequestProperty("User-Agent",
					"Mozilla/5.0 (Windows; U; Windows NT 5.1; zh-CN; rv:1.9.2.8) Firefox/3.6.8");
			conn.addRequestProperty("Referer", "http://zuidaima.com/");
			conn.connect();
			System.out.println("跳转地址:" + location);

			int responseCode = conn.getResponseCode();
			System.out.println("responseCode=" + responseCode);
			String responseMsg = conn.getResponseMessage();

			InputStream ins = conn.getInputStream();
			BufferedInputStream bis = new BufferedInputStream(ins);
			ByteArrayOutputStream baos = new ByteArrayOutputStream();
			int c;
			while (-1 != (c = bis.read())) {
				baos.write(c);
			}
			bis.close();
			ins.close();
			baos.flush();
			byte[] data = baos.toByteArray();
			responseMsg = new String(data);
			System.out.println("responseMsg=" + responseMsg);

			// InputStream ins = conn.getInputStream();
			// BufferedInputStream bis = new BufferedInputStream(ins);
			// ByteArrayOutputStream baos = new ByteArrayOutputStream();
			// int c;
			// while (-1 != (c = bis.read())) {
			// baos.write(c);
			// }
			// bis.close();
			// ins.close();
			// baos.flush();
			// byte[] data = baos.toByteArray();
			// responseMsg = new String(data);
			// System.out.println("responseMsg=" + responseMsg);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public static String replaceNullString(String str) {
		if (str == null)
			return "";
		else
			return str;
	}

	public static final String FORMAT_DATE_TIME = "yyyyMMddHHmmss";
	public static final String FORMAT_DATE = "yyyyMMdd";

	/**
	 * 获得日期
	 * @param num 0当天，1明天，-1昨天
	 * @return
	 */
	public static Date getDate(int num) {
		Calendar cal = Calendar.getInstance();
		
		cal.add(Calendar.DATE, num);
		Date d = cal.getTime();
		return d;
	}


	/**
	 * 系统当前时间 时分秒转为时间戳
	 * 
	 * @return
	 */
	public static long formatCurrentTimeHmsToLong() {
		long longHms = 0;
		try {
			Date date = new Date();
			SimpleDateFormat formatter2 = new SimpleDateFormat("HH:mm:ss");
			System.out.println(formatter2.format(date));
			String time = formatter2.format(date);
			String[] my = time.split(":");
			int hour = Integer.parseInt(my[0]);
			int min = Integer.parseInt(my[1]);
			int sec = Integer.parseInt(my[2]);
			// Date date3 = formatter2.parse(formatter2.format(date));
			// Date date3 = formatter2.parse("14:56:14");
			longHms = hour * 3600000 + min * 60000 + sec;
			System.out.println(longHms);
			System.out.println(System.currentTimeMillis());
		} catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
		return longHms;
	}

	/**
	 * 获得周几
	 * 
	 * @param pTime
	 *            不填判断当天，填写yyyy-MM-dd
	 * @return
	 */
	public static int getWeekday(String pTime) {
		int dayForWeek = 0;
		try {
			SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
			Date d = new Date();
			Calendar c = Calendar.getInstance();
			if (pTime != null && !"".equals(pTime) && pTime.length() > 0) {
				c.setTime(format.parse(pTime));
			} else {
				c.setTime(d);
			}
			if (c.get(Calendar.DAY_OF_WEEK) == 1) {
				dayForWeek = 7;
			} else {
				dayForWeek = c.get(Calendar.DAY_OF_WEEK) - 1;
			}
		} catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
		return dayForWeek;
	}

	public static String phoneSubstring(String phone) {
		StringBuffer str = new StringBuffer();
		if (phone != null && !"".equals(phone) && phone.length() == 11) {
			str.append(phone.substring(0, 3)).append("****")
					.append(phone.substring(8, 11));
		} else {
			int num = phone.length() / 2;
			System.out.println(num);
			str.append(phone.substring(0, num - 2)).append("****")
					.append(phone.substring(num + 2));
		}

		return str.toString();
	}

	public static boolean isNumeric(String str) {
		try {
			Pattern pattern = Pattern.compile("[0-9.]*");
			return pattern.matcher(str).matches();
		} catch (Exception e) {
			return false;
		}
	}

	/**
	 * 
	 * @function:通过属性生成set方法名
	 * @param str
	 * @return
	 */
	public static String setMethodName(String str) {
		return "set" + firstToUpperCase(str);
	}

	/**
	 * 首字母大写
	 */
	public static String firstToUpperCase(String str) {
		return Character.toUpperCase(str.charAt(0)) + str.substring(1);
	}

	public static boolean isNotNull(String str) {
		if (str != null && !"".equals(str) && str.length() > 0) {
			return true;
		}
		return false;
	}
	
	 private static ObjectOutputStream getObjOutStream(
			 HttpURLConnection httpUrlConnection) throws IOException
			 {
			 OutputStream outStrm;// 得到HttpURLConnection的输出流
			 ObjectOutputStream objOutputStrm;// 对象输出流
			 // 此处getOutputStream会隐含的进行connect(即：如同调用上面的connect()方法，
			 // 所以在开发中不调用上述的connect()也可以)。
			 outStrm = httpUrlConnection.getOutputStream();

			   // 现在通过输出流对象构建对象输出流对象，以实现输出可序列化的对象。
			 // 使用JSON传值
			 objOutputStrm = new ObjectOutputStream(outStrm);
			 return objOutputStrm;
	}
}
