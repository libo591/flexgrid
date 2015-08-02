package com.funcs.math
{
	import com.funcs.BasicFunc;
	
	public class Floor extends BasicFunc
	{
		public function Floor()
		{
			super();
		}
		
		override public function excute(...parameters):Object{
			return Math.floor(parameters[0]);
		}
	}
}