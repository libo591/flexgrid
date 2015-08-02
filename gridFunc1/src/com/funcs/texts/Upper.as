package com.funcs.texts
{
	import com.funcs.BasicFunc;
	
	public class Upper extends BasicFunc
	{
		public function Upper()
		{
			super();
		}
		
		override public function excute(...parameters):Object{
			return (parameters[0] as String).toUpperCase();
		}
	}
}