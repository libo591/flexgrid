package com.funcs.cell
{
	import com.funcs.BasicFunc;
	
	public class Sum extends BasicFunc
	{
		public function Sum()
		{
			super();
		}
		
		override public function excute(...parameters):Object{
			var len:int = parameters.length;
			var result:Number = 0;
			for(var i:int=0;i<len;i++){
				result +=parseInt(parameters[i],10);
			}
			return result;
		}
	}
}