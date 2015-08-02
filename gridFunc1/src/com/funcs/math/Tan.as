package com.funcs.math
{
	import com.funcs.BasicFunc;
	
	public class Tan extends BasicFunc
	{
		public function Tan()
		{
			super();
		}
		
		override public function excute(...parameters):Object{
			return Math.tan(parameters[0]);
		}
	}
}