package com.funcs.math
{
	import com.funcs.BasicFunc;
	
	public class Abs extends BasicFunc
	{
		public function Abs()
		{
			super();
		}
		
		override public function excute(...parameters):Object{
			return Math.abs(parameters[0]);
		}
	}
}