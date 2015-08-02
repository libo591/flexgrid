package com.funcs.math
{
	import com.funcs.BasicFunc;
	
	public class Pow extends BasicFunc
	{
		public function Pow()
		{
			super();
		}
		
		override public function excute(...parameters):Object{
			return Math.pow(parameters[0],parameters[1]);
		}
	}
}