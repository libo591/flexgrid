package com.funcs.datetime
{
	import com.funcs.BasicFunc;
	
	/**
	 * 求得2个日期的天数差
	 */
	public class Now extends BasicFunc
	{
		public function Now()
		{
		}
		
		override public function excute(...parameters):Object
		{
			return DateUtil.date2Str(new Date());
		}
	}
}