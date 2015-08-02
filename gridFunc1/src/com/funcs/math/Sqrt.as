package com.funcs.math
{
	import com.funcs.BasicFunc;
	
	public class Sqrt extends BasicFunc
	{
		public function Sqrt()
		{
			super();
		}
		
		override public function excute(...parameters):Object{
			return Math.sqrt(parameters[0]);
		}
	}
}