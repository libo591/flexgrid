package com.funcs.texts
{
	import com.funcs.BasicFunc;
	
	
	public class Lower extends BasicFunc
	{
		public function Lower()
		{
			super();
		}
		
		override public function excute(...parameters):Object{
			return (parameters[0] as String).toLowerCase();
		}
	}
}