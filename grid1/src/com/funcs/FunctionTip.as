package com.funcs
{
	import morn.core.components.TextArea;
	
	public class FunctionTip extends TextArea
	{
		private var _funcName:String;
		private var _closeFunc:Function;
		public function FunctionTip(functionName:String)
		{
			super();
			this._funcName = functionName;
			try{
				var funcObj:Object = FuncsLoader.getInst().funcObj(functionName);
				this.text = funcObj["desc"];
			}catch(e:Error){
				this.text = "不能找到此函数";
			}
			this.editable = false;
			
		}

		public function get funcName():String
		{
			return _funcName;
		}

		public function set funcName(value:String):void
		{
			_funcName = value;
		}

		public function get closeFunc():Function
		{
			return _closeFunc;
		}

		public function set closeFunc(value:Function):void
		{
			_closeFunc = value;
		}

		
	}
}