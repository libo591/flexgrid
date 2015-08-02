package com.funcs.math
{
	import com.funcs.BasicFunc;
	
	public class Atan extends BasicFunc
	{
		public function Atan()
		{
			super();
		}
		
		override public function excute(...parameters):Object{
			return Math.atan(parameters[0]);
		}
	}
}