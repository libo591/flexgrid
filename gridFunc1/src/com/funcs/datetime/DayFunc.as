package com.funcs.datetime
{
	import com.funcs.BasicFunc;
	
	import mx.formatters.DateFormatter;
	
	import spark.formatters.DateTimeFormatter;

	/**
	 * 求得日期中的天，返回1-31
	 */
	public class DayFunc extends BasicFunc
	{
		public function DayFunc()
		{
		}
		
		/**
		 * 
		 * @param parameters
		 * @return 
		 * 
		 */
		override public function excute(...parameters):Object
		{
			var result:int = -1;
			var pm0:Object = parameters[0];
			if(pm0!=null){
				var d:Date = DateUtil.str2Date(pm0);
				result = d.date;
			}
			return result;
		}
		
	}
}