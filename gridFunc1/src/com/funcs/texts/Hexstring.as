package com.funcs.texts
{
	import com.funcs.BasicFunc;
	
	public class Hexstring extends BasicFunc
	{
		public function Hexstring()
		{
			super();
		}
		
		override public function excute(...parameters):Object{
			return int(parameters[0]).toString(16);
		}
	}
}