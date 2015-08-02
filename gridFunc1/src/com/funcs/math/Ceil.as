package com.funcs.math
{
	import com.funcs.BasicFunc;
	
	public class Ceil extends BasicFunc
	{
		public function Ceil()
		{
			super();
		}
		
		override public function excute(...parameters):Object{
			return Math.ceil(parameters[0]);
		}
	}
}