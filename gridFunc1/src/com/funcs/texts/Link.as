package com.funcs.texts
{
	import com.funcs.BasicFunc;
	
	public class Link extends BasicFunc
	{
		public function Link()
		{
			super();
		}
		
		override public function excute(...parameters):Object{
			var arg0:String = parameters[0];
			var arg1:Array = [];
			var arg2:Array = [];
			if(parameters.length>=2){
				arg1 = parameters[1];
				arg2 = parameters[2];
			}
			if(arg1.length>0){
				arg0 = arg0+"?";
				var params:String = "";
				var seq:String = "";
				for(var i:int=0;i<arg1.length;i++){
					params += seq+arg1+"="+arg2;
					seq = "&";
				}
				arg0 = arg0+params;
			}
			return arg0;
		}
	}
}