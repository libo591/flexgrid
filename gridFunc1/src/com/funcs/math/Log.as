package com.funcs.math
{
	import com.funcs.BasicFunc;
	
	public class Log extends BasicFunc
	{
		public function Log()
		{
			super();
		}
		
		override public function excute(...parameters):Object{
			return Math.log(parameters[0]);
		}
	}
}