package com.funcs.texts
{
	import com.funcs.BasicFunc;
	
	public class Char extends BasicFunc
	{
		public function Char()
		{
			super();
		}
		
		override public function excute(...parameters):Object{
			return String.fromCharCode(parameters[0]);
		}
	}
}