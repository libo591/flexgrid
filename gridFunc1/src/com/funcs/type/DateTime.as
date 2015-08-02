package com.funcs.type
{
	import com.funcs.BasicFunc;
	import com.funcs.datetime.DateUtil;
	
	public class DateTime extends BasicFunc
	{
		public function DateTime()
		{
			super();
		}
		
		override public function excute(...parameters):Object{
			return DateUtil.str2Date(parameters[0]);
		}
	}
}