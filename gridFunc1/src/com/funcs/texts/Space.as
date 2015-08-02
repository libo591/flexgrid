package com.funcs.texts
{
	import com.funcs.BasicFunc;
	
	
	public class Space extends BasicFunc
	{
		public function Space()
		{
			super();
		}
		
		override public function excute(...parameters):Object{
			var result:String = " ";
			var count:int = parameters[0];
			var arr:Array = [];
			for(var i:int=0;i<count;i++){
				arr.push(result);
			}
			return arr.join("");
		}
	}
}