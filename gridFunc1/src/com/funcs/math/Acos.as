package com.funcs.math
{
	import com.funcs.BasicFunc;
	
	public class Acos extends BasicFunc
	{
		public function Acos()
		{
			super();
		}
		
		override public function excute(...parameters):Object{
			return Math.acos(parameters[0]);
		}
	}
}