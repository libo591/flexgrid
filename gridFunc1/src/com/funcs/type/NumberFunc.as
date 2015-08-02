package com.funcs.type
{
	import com.funcs.BasicFunc;
	
	public class NumberFunc extends BasicFunc
	{
		public function NumberFunc()
		{
			super();
		}
		
		override public function excute(...parameters):Object{
			return Number(parameters[0]);
		}
	}
}