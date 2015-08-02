package com.funcs.datetime
{
	import com.funcs.BasicFunc;
	
	/**
	 * 求得2个日期的天数差
	 */
	public class Days360Func extends BasicFunc
	{
		public function Days360Func()
		{
		}
		
		override public function excute(...parameters):Object
		{
			var d1:Date = DateUtil.str2Date(parameters[0]);
			var d2:Date = DateUtil.str2Date(parameters[1]);
			var result:int = 0;
			if(d1!=null&&d2!=null){
				var dt1:Number = d1.getTime();
				var dt2:Number = d2.getTime();
				var dtdes:Number = Math.abs(dt2-dt1);
				var oneDay:Number = 24*60*60*1000;
				result = dtdes/oneDay+(dtdes%oneDay>0?1:0); 
			}
			return result;
		}
	}
}