package com.funcs.math
{
	import com.funcs.BasicFunc;
	
	public class Sign extends BasicFunc
	{
		public function Sign()
		{
			super();
		}
		
		override public function excute(...parameters):Object{
			return parameters[0]>0?1:(parameters[0]==0?0:-1);
		}
	}
}