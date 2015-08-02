package com.funcs.texts
{
	import com.funcs.BasicFunc;
	
	public class Fill extends BasicFunc
	{
		public function Fill()
		{
			super();
		}
		
		override public function excute(...parameters):Object{
			var result:String = null;
			var arr:Array = []; 
			for(var i:int=0;i<parameters[1];i++){
				arr.push(parameters[0]);
			}
			return arr.join("");
		}
	}
}