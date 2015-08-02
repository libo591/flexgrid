package com.funcs.math
{
	import com.funcs.BasicFunc;
	
	public class Exp extends BasicFunc
	{
		public function Exp()
		{
			super();
		}
		
		override public function excute(...parameters):Object{
			return Math.exp(parameters[0]);
		}
	}
}