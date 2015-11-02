/* 程序功能：输入验证 */
/* 函数名称： */
/* function CheckData(valname,val,valimode,limitlen) */
/* 功能说明：验证字符串数据 */
/* function CheckUserName(val,min,max) */
/* 功能说明：验证用户名 */
/* function CheckPassWord(val,min,max) */
/* 功能说明：验证密码 */
/* function IsSame(val1,val2) */
/* 验证密码匹配 */
/* function CheckEmail(val,mode) */
/* 功能说明：验证Email */
/* function CheckValHeight(val,min,max,mode) */
/* 功能说明：验证用户身高 */
/* function CheckValWeight(val,min,max,mode) */
/* 功能说明：验证用户体重 */
/* function CheckNumber(val,min,max,mode) */
/* 功能说明：验证数值 */
/* function CheckPositive(val,min,max,mode) */
/* 功能说明：验证正数值 */
/* function CheckNegative(val,min,max,mode) */
/* 功能说明：验证负数值 */
/* function CheckFloat(val,min,max,mode) */
/* 功能说明：验证浮点数值 */
/* function CheckPath(val,mode) */
/* 功能说明：验证文件路径 */
/* function CheckURL(val,mode) */
/* 功能说明：验证URL */
/* function CheckChinaIDCard_J(val,mode) */
/* 功能说明：验证身份证 */
/* function isInteger(sNum) */
/* 功能说明：验证整数 */
/* function CheckZip(val,slen,mode) */
/* 功能说明：验证Zip */
/* 输入参数：mode真&假(是否允许为空) */
/* val表单(被判断项)，va2表单(被判断项) */
/* max(最大值)，min(最小值) ...... */
/* */
/*$#################################################$*/


// 验证为空
function isblank(str) {
	
 	if( str != null && str != '' && str != 'undefind' && str.length > 0 ){
 		return false;
 	}
 	return true;
 }

// 验证长度
function istoolong(str, i) {
	var len = str.length;
	if (i == 0)
		return false;
	else {
		if (len > i)
			return true;
		else
			return false;
	}
}

// 验证用户名 
function CheckUserName(val, min, max) {
	var len = val.value.length;
	if (len < min || len > max) {
		alert("用户名长度不正确，应为" + min + "-" + max + "个英文字母、数字。");
		val.focus();
		val.select();
		return false;
	}
	for (i = 0; i < val.value.length; i++) {
		var ch = val.value.charAt(i);
		if ((ch < "0" || ch > "9") && (ch < "a" || ch > "z")) {
			alert("用户名必须由小写字母或数字组成。");
			val.focus();
			val.select();
			return false;
		}
	}
	var first = val.value.charAt(0)
	if (first < "a" || ch > "z") {
		alert("用户名必须由小写字母开头。");
		val.focus();
		val.select();
		return false;
	}

	return true;
}
//验证密码 
function CheckPassWord(val, min, max) {
	var len = val.value.length;
	if (len < min || len > max) {
		val.focus();
		val.select();
		return false;
	}
	for (i = 0; i < val.value.length; i++) {
		var ch = val.value.charAt(i);
		if ((ch < "0" || ch > "9") && (ch < "a" || ch > "z")) {
			val.focus();
			val.select();
			return false;
		}
	}
	return true;
}
//验证密码匹配 
function IsSame(val1, val2) {
	if (val1.value != val2.value) {
		val2.focus();
		val2.select();
		return false;
	} else
		return true;
}
//验证Email 
function CheckEmail(val, mode) {
	if ((mode == 0) && (val.value == "")) {
		return true;
	}

	var etext
	var elen
	var i
	var aa
	etext = val.value
	elen = etext.length
	if (elen < 5) {
		val.focus();
		val.select();
		return false;
	}
	i = etext.indexOf("@", 0)
	if (i == 0 || i == -1 || i == elen - 1) {
		val.focus();
		val.select();
		return false;
	} else {
		if (etext.indexOf("@", i + 1) != -1) {
			val.focus();
			val.select();
			return false;
		}
	}
	if (etext.indexOf("..", i + 1) != -1) {
		val.focus();
		val.select();
		return false;
	}
	i = etext.indexOf(".", 0)
	if (i == 0 || i == -1 || etext.charAt(elen - 1) == '.') {
		val.focus();
		val.select();
		return false;
	}
	if (etext.charAt(0) == '-' || etext.charAt(elen - 1) == '-') {
		val.focus();
		val.select();
		return false;
	}
	if (etext.charAt(0) == '_' || etext.charAt(elen - 1) == '_') {
		val.focus();
		val.select();
		return false;
	}
	for (i = 0; i <= elen - 1; i++) {
		aa = etext.charAt(i)
		if (!((aa == '.') || (aa == '@') || (aa == '-') || (aa == '_')
				|| (aa >= '0' && aa <= '9') || (aa >= 'a' && aa <= 'z') || (aa >= 'A' && aa <= 'Z'))) {
			val.focus();
			val.select();
			return false;
		}
	}
	return true;
}
//验证数值 
function CheckNumber(val, min, max, mode) {
	if ((mode == 0) && (val.value == "")) {
		return true;
	}

	var len = val.value.length;
	if (len < min || len > max) {
		val.focus();
		val.select();
		return false;
	}
	var val2 = val.value;
	for (i = 1; i < val2.length; i++) {
		var ch = val2.charAt(i);
		if ((ch < "0" || ch > "9")) {
			val.focus();
			val.select();
			return false;
		}
	}
	if (isNaN(val2)) {
		val.focus();
		val.select();
		return false;
	} else if (val2.indexOf('0') == 0 && len > 1) {
		val.focus();
		val.select();
		return false;
	} else if (val2.indexOf('-') == 0 && val2.indexOf('0') == 1) {
		val.focus();
		val.select();
		return false;
	}
	return true;
}
//验证正数值 
function CheckPositive(val, min, max, mode) {
	if ((mode == 0) && (val.value == "")) {
		return true;
	}

	if (!CheckNumber(val, min, max, mode)) {
		val.focus();
		val.select();
		return false;
	}
	if (parseInt(val.value) <= 0) {
		val.focus();
		val.select();
		return false;

	}

	return true;
}

//验证负数值 
function CheckNegative(val, min, max, mode) {
	if ((mode == 0) && (val.value == "")) {
		return true;
	}

	if (!CheckNumber(val, min, max, mode)) {
		val.focus();
		val.select();
		return false;
	}
	if (parseInt(val.value) >= 0) {
		val.focus();
		val.select();
		return false;
	}

	return true;
}
//验证浮点数值 
function CheckFloat(val, min, max, mode) {
	if ((mode == 0) && (val.value == "")) {
		return true;
	}

	var len = val.value.length;
	if (len < min || len > max) {
		val.focus();
		val.select();
		return false;
	}
	var val2 = val.value;
	for (i = 1; i < val2.length; i++) {
		var ch = val2.charAt(i);
		if ((ch < "0" || ch > "9")) {
			if (ch != ".") {
				val.focus();
				val.select();
				return false;
			}
		}
	}
	if (isNaN(val2)) {
		val.focus();
		val.select();
		return false;
	} else if (val2.indexOf('0') == 0 && val2.indexOf('.') != 1) {
		val.focus();
		val.select();
		return false;
	} else if (val2.indexOf('-') == 0 && val2.indexOf('0') == 1
			&& val2.indexOf('.') != 2) {
		val.focus();
		val.select();
		return false;
	} else if (val2.indexOf('-') == 0 && val2.indexOf('.') == 1) {
		val.focus();
		val.select();
		return false;
	} else if (val2.indexOf('.') == 0) {
		val.focus();
		val.select();
		return false;
	}
	return true;
}
//验证文件路径 
function CheckPath(val, mode) {
	if ((mode == 0) && (val.value == "")) {
		return true;
	}

	var val2 = val.value;
	if (val2.indexOf(':\\') > 0) {
		var isNot = " !@#$^*()'`~|]}[{;.>,<?%&+=";
		if (val2.indexOf('\"') > 0) {
			val.focus();
			val.select();
			return false;
		} else {
			for ( var i = 0; i < val2.length; i++) {
				for ( var x = 1; x < isNot.length; x++) {
					if (val2.charAt(i) == isNot.charAt(x)) {
						val.focus();
						val.select();
						return false;
					}
				}
			}
		}
	} else {
		val.focus();
		val.select();
		return false;
	}
	return true;
}
//验证URL 
function CheckURL(val, mode) {
	if ((mode == 0) && (val.value == "")) {
		return true;
	}

	var val2 = val.value;
	if (val2.indexOf('://') > 0) {
		var isNot = " !@$^*()'`~|]}[{;.>,<";
		if (val2.indexOf('\"') > 0) {
			val.focus();
			val.select();
			return false;
		} else {
			for ( var i = 0; i < val2.length; i++) {
				for ( var x = 1; x < isNot.length; x++) {
					if (val2.charAt(i) == isNot.charAt(x)) {
						val.focus();
						val.select();
						return false;
					}
				}
			}
		}
	} else {
		val.focus();
		val.select();
		return false;
	}
	return true;
}
//验证身份证 
function CheckChinaIDCard_J(val, mode) {
	if ((mode == 0) && (val.value == "")) {
		return true;
	}

	sNo = val.value.toString()
	if (!isInteger(sNo)) {
		alert("请输入正确的身份证。");
		val.focus();
		val.select();
		return false
	}
	switch (sNo.length) {
	case 15:
		if (isValidDate(sNo.substr(6, 2), sNo.substr(8, 2), sNo.substr(10, 2))) {
			return true
		}
	case 17:
		if (isValidDate(sNo.substr(6, 4), sNo.substr(10, 2), sNo.substr(12, 2))) {
			return true
		}
	}
	alert("请输入正确的身份证。");
	val.focus();
	val.select();
	return false
}function isInteger(sNum) {
	var num
	num = new RegExp('[^0-9_]', '')
	if (isNaN(sNum)) {
		return false
	} else {
		if (sNum.search(num) >= 0) {
			return false
		} else {
			return true
		}
	}
}

//验证Zip 
function CheckZip(val,slen,mode){ 
if((mode==0) && (val.value=="")){ 
return true; 
} 

if(val.value.length!=slen){ 
alert('请输入正确的邮政编码!!'); 
val.focus(); 
val.select(); 
return false 
} 
var r1 
r1 = new RegExp('[^0-9]',''); 
if ( val.value.search(r1) >= 0 ) { 
alert('请输入正确的邮政编码!!'); 
val.focus(); 
val.select(); 
return false 
} 
else 
return true; 
} 




//函数名：chksafe
//功能介绍：检查是否含有"'",'\\',"/"
//参数说明：要检查的字符串
//返回值：0：是 1：不是

function chksafe(a)
{ 
return 1;
/* fibdn = new Array ("'" ,"\\", "、", ",", ";", "/");
i=fibdn.length;
j=a.length;
for (ii=0;ii { for (jj=0;jj { temp1=a.charAt(jj);
temp2=fibdn[ii];
if (temp1==temp2)
{ return 0; }
}
}
return 1;
*/ 
} 

//函数名：chkspc
//功能介绍：检查是否含有空格
//参数说明：要检查的字符串
//返回值：0：是 1：不是

function chkspc(a)
{
	var i=a.length;
	var j = 0;
	var k = 0;
	while(k){
		if (a.charAt(k) != " ")
			j = j+1;
			k = k+1;
	}
	if (j==0)
	{
		return 0;
	}

	if (i!=j)
	{ 
		return 2; 
	}
	else
	{
		return 1;
	}
}

//函数名：chkemail
//功能介绍：检查是否为Email Address
//参数说明：要检查的字符串
//返回值：0：不是 1：是 

function chkemail(a)
{ 
	var i=a.length;
	var temp = a.indexOf('@');
	var tempd = a.indexOf('.');
	if (temp > 1) {
		
		if ((i-temp) > 3){
			if ((i-tempd)>0){
				return 1;
			}
		}
	}
	return 0;
}
//opt1 小数 opt2 负数
//当opt2为1时检查num是否是负数
//当opt1为1时检查num是否是小数
//返回1是正确的，0是错误的
function chknbr(num,opt1,opt2)
{
	var i=num.length;
	var staus;
	//staus用于记录.的个数
	status=0;
	if ((opt2!=1) && (num.charAt(0)=='-'))
	{
		//alert("You have enter a invalid number.");
		return 0;
	}
	//当最后一位为.时出错
	if (num.charAt(i-1)=='.')
	{
		//alert("You have enter a invalid number.");
		return 0;
	}

	for(j=0;j< num.length ; j++){
		if (num.charAt(j)=='.')
		{
			status++;
		}
		if (status>1) 
		{
			//alert("You have enter a invalid number.");
			return 0; 
		}
		if (num.charAt(j)<'0' || num.charAt(j)>'9' )
		{
			if (((opt1==0) || (num.charAt(j)!='.')) && (j!=0)) 
			{
				//alert("You have enter a invalid number.");
				return 0;
			}
		}
	}
	return 1;
}
//函数名：chkdate
//功能介绍：检查是否为日期
//参数说明：要检查的字符串
//返回值：0：不是日期 1：是日期


function chkdate(datestr)
{
	var lthdatestr
	if (datestr != "")
		lthdatestr= datestr.length ;
	else
		lthdatestr=0;
	
	var tmpy="";
	var tmpm="";
	var tmpd="";
	//var datestr;
	var status;
		status=0;
	if ( lthdatestr== 0)
		return 0;

	for (i=0;i< datestr.length ; i++)
	{ 
		if (datestr.charAt(i)== '-')
		{
			status++;
		}
		if (status>2)
		{
			//alert("Invalid format of date!");
			return 0;
		}
		if ((status==0) && (datestr.charAt(i)!='-'))
		{
			tmpy=tmpy+datestr.charAt(i)
		}
		if ((status==1) && (datestr.charAt(i)!='-'))
		{
			tmpm=tmpm+datestr.charAt(i)
		}
		if ((status==2) && (datestr.charAt(i)!='-'))
		{
			tmpd=tmpd+datestr.charAt(i)
		}
	}
	year=new String (tmpy);
	month=new String (tmpm);
	day=new String (tmpd)
	//tempdate= new String (year+month+day);
	//alert(tempdate);
	if ((tmpy.length!=4) || (tmpm.length>2) || (tmpd.length>2))
	{
		//alert("Invalid format of date!");
		return 0;
	}
	if (!((1<=month) && (12>=month) && (31>=day) && (1<=day)) )
	{
		//alert ("Invalid month or day!");
		return 0;
	}
	if (!((year % 4)==0) && (month==2) && (day==29))
	{
		//alert ("This is not a leap year!");
		return 0;
	}
	if ((month<=7) && ((month % 2)==0) && (day>=31))
	{
		//alert ("This month is a small month!");
		return 0;
	
	}
	if ((month>=8) && ((month % 2)==1) && (day>=31))
	{
		//alert ("This month is a small month!");
		return 0;
	}
	if ((month==2) && (day==30))
	{
		//alert("The Febryary never has this day!");
		return 0;
	}
	
	return 1;
}
//函数名：fucPWDchk
//功能介绍：检查是否含有非数字或字母
//参数说明：要检查的字符串
//返回值：0：含有 1：全部为数字或字母 


function fucPWDchk(str)
{
	var strSource ="0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
	var ch;
	var i;
	var temp;

	for (i=0;i<=(str.length-1);i++)
	{
		ch = str.charAt(i);
		temp = strSource.indexOf(ch);
		if (temp==-1) 
		{
			return 0;
		}
	}
if (strSource.indexOf(ch)==-1)
{
return 0;
}
else
{
return 1;
} 
}

function jtrim(str)
{ 
	while (str.charAt(0)==" ")
	{
		str=str.substr(1);
	} 
	while (str.charAt(str.length-1)==" ")
	{
		str=str.substr(0,str.length-1);
	}
	return(str);
}

//函数名：fucCheckTEL
//功能介绍：检查是否为电话号码
//参数说明：要检查的字符串
//返回值：1为是合法，0为不合法

function fucCheckTEL(TEL)
{
	var i,j,strTemp;
	strTemp="0123456789-()# ";
	for (i=0;i<strTemp.length;i++) 
	{
		j=strTemp.indexOf(TEL.charAt(i)); 
		if (j==-1)
		{
			//说明有字符不合法
			return 0;
		}
	}
	//说明合法
	return 1;
}

//函数名：fucCheckLength
//功能介绍：检查字符串的长度
//参数说明：要检查的字符串
//返回值：长度值

function fucCheckLength(strTemp)
{
	var i,sum;
	sum=0;
	for(i=0;i<strTemp.length;i++) {
		if ((strTemp.charCodeAt(i)>=0) && (strTemp.charCodeAt(i)<=255))
			sum=sum+1;
		else
			sum=sum+2;
	}
	return sum;
}
