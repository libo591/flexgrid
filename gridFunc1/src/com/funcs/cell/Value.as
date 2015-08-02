package com.funcs.cell
{
	import com.funcs.BasicFunc;
	
	import r1.deval.D;
	
	public class Value extends BasicFunc
	{
		public function Value()
		{
			super();
		}
		override public function excute(...parameters):Object{
			return parameters[0];
		}
	}
}