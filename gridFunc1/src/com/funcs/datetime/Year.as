package com.funcs.datetime
{
	import com.funcs.BasicFunc;
	
	/**
	 * 求得2个日期的天数差
	 */
	public class Year extends BasicFunc
	{
		public function Year()
		{
		}
		
		override public function excute(...parameters):Object
		{
			var d1:Date = DateUtil.str2Date(parameters[0]);
			var result:int = 0;
			if(d1!=null){
				result = d1.fullYear;
			}
			return result;
		}
	}
}