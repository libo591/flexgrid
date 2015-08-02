package com.funcs.type
{
	import com.funcs.BasicFunc;
	
	public class Str extends BasicFunc
	{
		public function Str()
		{
			super();
		}
		
		override public function excute(...parameters):Object{
			return Number(parameters[0]);
		}
	}
}