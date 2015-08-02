package com.funcs.texts
{
	import com.funcs.BasicFunc;
	
	
	public class Like extends BasicFunc
	{
		public function Like()
		{
			super();
		}
		
		override public function excute(...parameters):Object{
			
			return parameters.length;
		}
	}
}