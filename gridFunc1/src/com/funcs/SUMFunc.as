package com.funcs
{
	public class SUMFunc implements IFunc
	{
		public function SUMFunc()
		{
			
		}
		
		public function excute(...params):Object
		{
			var len:int = params.length;
			var result:Number = 0;
			for(var i:int=0;i<len;i++){
				result +=parseInt(params[i],10);
			}
			return result;
		}
	}
}