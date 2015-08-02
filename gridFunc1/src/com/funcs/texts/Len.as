package com.funcs.texts
{
	import com.funcs.BasicFunc;
	
	
	public class Len extends BasicFunc
	{
		public function Len()
		{
			super();
		}
		
		override public function excute(...parameters):Object{
			return parameters.length;
		}
	}
}