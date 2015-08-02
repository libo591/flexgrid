package com.funcs.type
{
	import com.funcs.BasicFunc;
	import com.funcs.datetime.DateUtil;
	
	public class DateFunc extends BasicFunc
	{
		public function DateFunc()
		{
			super();
		}
		
		override public function excute(...parameters):Object{
			return DateUtil.str2Date(parameters[0]);
		}
	}
}