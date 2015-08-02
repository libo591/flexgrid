package com.funcs.cell
{
	import com.funcs.BasicFunc;
	
	
	public class Row extends BasicFunc
	{
		public function Row()
		{
			super();
		}
		override public function excute(...parameters):Object{
			return parameters[0];
		}
	}
}