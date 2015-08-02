package com.funcs.cell
{
	import com.funcs.BasicFunc;
	
	
	
	public class Rgb extends BasicFunc
	{
		public function Rgb()
		{
			super();
		}
		
		override public function excute(...parameters):Object{
			var arg0:Number = parameters[0];
			var arg1:Number = parameters[1];
			var arg2:Number = parameters[2];
			return parseInt(("0x"+arg0.toString(16)+arg1.toString(16)+arg2.toString(16)),16);
		}
	}
}