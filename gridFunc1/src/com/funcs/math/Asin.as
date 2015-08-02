package com.funcs.math
{
	import com.funcs.BasicFunc;
	
	public class Asin extends BasicFunc
	{
		public function Asin()
		{
			super();
		}
		
		override public function excute(...parameters):Object{
			return Math.asin(parameters[0]);
		}
	}
}