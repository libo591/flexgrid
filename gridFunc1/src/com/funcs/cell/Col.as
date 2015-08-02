package com.funcs.cell
{
	import com.funcs.BasicFunc;
	
	import r1.deval.D;
	
	public class Col extends BasicFunc
	{
		public function Col()
		{
			super();
		}
		override public function excute(...parameters):Object{
			return parameters[0];
		}
	}
}