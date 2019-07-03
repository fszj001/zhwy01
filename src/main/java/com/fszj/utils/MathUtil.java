package com.fszj.utils;

import java.math.BigDecimal;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Random;
import java.util.UUID;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import com.sun.org.apache.bcel.internal.generic.NEW;



public class MathUtil {

	//日期加月数
	public static String DateAddNum(String dateStr,int num){
		SimpleDateFormat simpleDateFormat=new SimpleDateFormat("yyyy-MM-dd");
		Date d = null;
		try {
			d = simpleDateFormat.parse(dateStr);
			d.setMonth(d.getMonth()+(num));
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return simpleDateFormat.format(d);
	}
	
	
	public static String getUUID(){
	  return UUID.randomUUID().toString().replaceAll("-", "");
	}

	//日期减
	public static String DateDevNum(String dateStr, int num) {
		SimpleDateFormat simpleDateFormat=new SimpleDateFormat("yyyy-MM-dd");
		Date d = null;
		try {
			d = simpleDateFormat.parse(dateStr);
			d.setMonth(d.getMonth()-(num));
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return simpleDateFormat.format(d);
	}
	
	//获取当前日期加上4位随机数
	public static  String getRandom(){
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
		String s = sdf.format(date);
		Random random = new Random();
		for(int i=0;i<4;i++){
			s+=random.nextInt(10);
		}
		return s;
	}
	
	private static Calendar startDate = Calendar.getInstance();
	private static Calendar endDate = Calendar.getInstance();
	private static DateFormat df = DateFormat.getDateInstance();
	private static SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	

	
	public static int yearsBetween(Calendar c1, Calendar c2) throws ParseException {
		return (endDate.get(Calendar.YEAR) - startDate.get(Calendar.YEAR));
	}
	
	public static String getTimeNow(){
		Date dt = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		return sdf.format(dt);
	}
	
	public static String getTimeNowss(){
		Date dt = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		return sdf.format(dt);
	}
	
	public static String getPreMonth(){
		Calendar calendar =Calendar.getInstance();
		Date dt = new Date();
		calendar.setTime(dt);
		calendar.add(Calendar.MONTH, -1);
		dt = calendar.getTime();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		return sdf.format(dt);
	}
	


      public MathUtil() {

    }
    
	

	

	
	
	// @描述：是否是2003的excel，返回true是2003 
    public static boolean isExcel2003(String filePath)  {  
         return filePath.matches("^.+\\.(?i)(xls)$");  
     }  
   
    //@描述：是否是2007的excel，返回true是2007 
    public static boolean isExcel2007(String filePath)  {  
         return filePath.matches("^.+\\.(?i)(xlsx)$");  
     }  
    
    
    //字符串转换成日期
    public  static Date strToDate(String str){
    	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    	try {
			return sdf.parse(str);
		} catch (ParseException e) {
			e.printStackTrace();
			return null;
		}
    }
    
     

    
 
	public static void main(String[] args) throws Exception {

	}
	
	
	
}
