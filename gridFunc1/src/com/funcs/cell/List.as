package com.funcs.cell
{
	import com.funcs.BasicFunc;
	
	
	public class List extends BasicFunc
	{
		public function List()
		{
			super();
		}
		override public function excute(...parameters):Object{
			var count:int = parameters.length;
			var arr:Array = [];
			for(var i:int=0;i<count;i++){
				var result:Object = parameters[i];
				if(result is Array){
					var count2:int = (result as Array).length;
					for(var j:int=0;j<count2;j++){
						arr.push(result[j]);	
					}
				}else{
					arr.push(result);
				}
			}
			return arr;
		}
	}
}