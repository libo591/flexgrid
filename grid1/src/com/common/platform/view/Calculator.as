package com.common.platform.view
{
	
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.ui.Keyboard;
	
	import game.ui.CalculatorUI;
	
	import morn.core.components.Dialog;
	
	import r1.deval.D;
	
	
	public class Calculator extends CalculatorUI
	{
		private var _initValue:Number;
		private var _callBackFunc:Function;
		
		public function Calculator()
		{
			initEvent();
			helpDisp(null);
		}
		
		private function initEvent():void
		{
			helpLabel.addEventListener(MouseEvent.CLICK,helpDisp);
			this.addEventListener(KeyboardEvent.KEY_UP,keyboardUp);
			confirmLabel.addEventListener(MouseEvent.CLICK,confirmClick);
		}
		
		protected function confirmClick(event:MouseEvent):void
		{
			if(this.callBackFunc!=null){
				this.callBackFunc.call(null,this.textInput.text);
			}
			closeSelf();
		}
		
		protected function keyboardUp(event:KeyboardEvent):void
		{
			if(event.keyCode==Keyboard.ENTER){
				var result:Number = 0;
				try{
					result = D.evalToNumber(this.textInput.text);
					this.dispArea.text += this.textInput.text+"\n";
					this.dispArea.text +="====================\n";
					this.textInput.text = result+"";
				}catch(e:Error){
					this.dispArea.text +=
						"//********************************************//\n"+
						"计算过程中发生错误，请检查计算式。或者计算机不支持该运算\n"+
						"//********************************************//\n";
				}
				this.dispArea.scrollTo(this.dispArea.maxScrollV);
			}
		}
		
		protected function closeSelf(event:Event=null):void
		{
			App.dialog.close(this.parent.parent as Dialog);
		}		
		
		protected function helpDisp(event:MouseEvent):void
		{
			this.dispArea.text+=
				"//********************************************//\n"+
				"可以在最下面输入框中输入计算表达式,\n"+
				"按回车(Enter)后将对表达式进行计算,\n"+
				"并将计算过程显示在上方屏幕中,\n"+
				"计算结果显示在输入框中.\n"+
				"//********************************************//\n";
		}

		public function get callBackFunc():Function
		{
			return _callBackFunc;
		}

		public function set callBackFunc(value:Function):void
		{
			_callBackFunc = value;
		}

		public function get initValue():Number
		{
			return _initValue;
		}

		public function set initValue(value:Number):void
		{
			_initValue = value;
			this.textInput.text = value.toString();
		}


	}
}