package com.funcs.math
{
	import com.funcs.BasicFunc;
	
	public class Pi extends BasicFunc
	{
		public function Pi()
		{
			super();
		}
		
		override public function excute(...parameters):Object{
			var arg0:Number = 1;
			if(parameters.length>=1){
				arg0 = parameters[0];
			}
			return Math.PI*arg0;
		}
	}
}