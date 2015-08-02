package com.funcs.texts
{
	import com.funcs.BasicFunc;
	
	public class RmQuote extends BasicFunc
	{
		public function RmQuote()
		{
			super();
		}
		
		override public function excute(...parameters):Object{
			var arg0:String = parameters[0] as String;
			arg0 = arg0.replace(/\"/g,"");
			arg0 = arg0.replace(/\'/g,"");
			return arg0;
		}
	}
}