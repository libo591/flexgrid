package com.funcs.math
{
	import com.funcs.BasicFunc;
	
	public class Rand extends BasicFunc
	{
		public function Rand()
		{
			super();
		}
		
		override public function excute(...parameters):Object{
			return Math.random();
		}
	}
}