package com.funcs.texts
{
	import com.funcs.BasicFunc;
	
	
	public class Rplc extends BasicFunc
	{
		public function Rplc()
		{
			super();
		}
		
		override public function excute(...parameters):Object{
			return (parameters[0] as String).replace(parameters[1],parameters[2]);
		}
	}
}