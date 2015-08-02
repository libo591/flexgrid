package com.funcs.cell
{
	import com.funcs.BasicFunc;
	
	import r1.deval.D;
	
	public class Text extends BasicFunc
	{
		public function Text()
		{
			super();
		}
		override public function excute(...parameters):Object{
			return parameters[0];
		}
	}
}