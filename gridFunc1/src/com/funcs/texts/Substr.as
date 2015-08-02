package com.funcs.texts
{
	import com.funcs.BasicFunc;
	
	public class Substr extends BasicFunc
	{
		public function Substr()
		{
			super();
		}
		
		override public function excute(...parameters):Object{
			return (parameters[0] as String).substring(parameters[1],parameters[2]);
		}
	}
}