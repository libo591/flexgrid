package com.funcs.math
{
	import com.funcs.BasicFunc;
	
	public class Log10 extends BasicFunc
	{
		public function Log10()
		{
			super();
		}
		
		override public function excute(...parameters):Object{
			return Math.log(parameters[0])*Math.LOG10E;
		}
	}
}