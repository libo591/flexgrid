package com.funcs.type
{
	import com.funcs.BasicFunc;
	
	public class IntFunc extends BasicFunc
	{
		public function IntFunc()
		{
			super();
		}
		
		override public function excute(...parameters):Object{
			return int(parameters[0]);
		}
	}
}