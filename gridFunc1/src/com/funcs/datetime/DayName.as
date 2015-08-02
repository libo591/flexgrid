package com.funcs.datetime
{
	import com.funcs.BasicFunc;
	
	/**
	 * 求得2个日期的天数差
	 */
	public class DayName extends BasicFunc
	{
		public function DayName()
		{
		}
		
		override public function excute(...parameters):Object
		{
			var d1:Date = DateUtil.str2Date(parameters[0]);
			var result:String = null;
			if(d1!=null){
				switch(d1.day){
					case 0:
						result = "星期日";
						break;
					case 1:
						result = "星期一";
						break;
					case 2:
						result = "星期二";
						break;
					case 3:
						result = "星期三";
						break;
					case 4:
						result = "星期四";
						break;
					case 5:
						result = "星期五";
						break;
					case 6:
						result = "星期六";
						break;
					default:
						result = "星期日";
						break;
				}
			}
			return result;
		}
	}
}