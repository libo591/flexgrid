package com.funcs.math
{
	import com.funcs.BasicFunc;
	
	public class Round extends BasicFunc
	{
		public function Round()
		{
			super();
		}
		
		override public function excute(...parameters):Object{
			return Math.round(parameters[0]);
		}
	}
}