package com.funcs.texts
{
	import com.funcs.BasicFunc;
	
	public class Asc extends BasicFunc
	{
		public function Asc()
		{
			super();
		}
		
		override public function excute(...parameters):Object{
			var arg1:int = 0;
			if(parameters.length>=2){
				arg1 = parameters[1];
			}
			return parameters[0].charCodeAt(arg1);
		}
	}
}