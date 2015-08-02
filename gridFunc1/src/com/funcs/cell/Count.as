package com.funcs.cell
{
	import com.funcs.BasicFunc;
	
	import r1.deval.D;
	
	public class Count extends BasicFunc
	{
		public function Count()
		{
			super();
		}
		override public function excute(...parameters):Object{
			return parameters[0];
		}
	}
}