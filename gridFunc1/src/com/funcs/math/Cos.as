package com.funcs.math
{
	import com.funcs.BasicFunc;
	
	public class Cos extends BasicFunc
	{
		public function Cos()
		{
			super();
		}
		
		override public function excute(...parameters):Object{
			return Math.cos(parameters[0]);
		}
	}
}