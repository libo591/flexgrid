package com.funcs.math
{
	import com.funcs.BasicFunc;
	
	public class Sin extends BasicFunc
	{
		public function Sin()
		{
			super();
		}
		
		override public function excute(...parameters):Object{
			return Math.sin(parameters[0]);
		}
	}
}