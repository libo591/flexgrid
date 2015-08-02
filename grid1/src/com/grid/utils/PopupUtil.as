package com.grid.utils
{
	import com.common.platform.moduleInterfaces.IDataSetCreator;
	import com.common.platform.view.Calculator;
	import com.common.platform.view.ColHeaderFuncConfig;
	import com.common.platform.view.CommonPopUpContainer;
	import com.funcs.FunctionTip;
	
	import flash.display.DisplayObject;
	
	public class PopupUtil
	{
		public function PopupUtil()
		{
		}
		public static function popupDataSetCreator(w:Number,h:Number):void{
			/*var commonp:CommonPopUpContainer = new CommonPopUpContainer();
			var _moduleInfo:IModuleInfo = ModuleManager.getModule("DataSetCreatorM.swf");
			_moduleInfo.addEventListener(ModuleEvent.READY,function(e:ModuleEvent):void{
				e.stopPropagation();
				var datasetModule:IVisualElement = _moduleInfo.factory.create() as IVisualElement;
				commonp.addElement(datasetModule);
			});
			_moduleInfo.load(ApplicationDomain.currentDomain);
			commonp.title = "新建数据集";
			commonp.width = w;
			commonp.height = h;
			PopUpManager.addPopUp(commonp,FlexGlobals.topLevelApplication as DisplayObject,true);
			PopUpManager.centerPopUp(commonp);*/
		}
		public static function popupCalculator(callback:Function,initValue:Number):void{
			var commonp:CommonPopUpContainer = new CommonPopUpContainer();
			commonp.title.text = "计算器";
			commonp.width = 500;
			commonp.height = 400;
			
			var calc:Calculator = new Calculator();
			calc.x = 4;
			calc.y = 4;
			calc.initValue = initValue;
			calc.callBackFunc = callback;
			commonp.content.addChild(calc);
			commonp.popup(true);
		}
		public static function popupColFuncConfig(callback:Function,
												  colindex:int,rowindex:int,gridName:String):void{
			var commonp:CommonPopUpContainer = new CommonPopUpContainer();
			commonp.title.text = "列设置";
			commonp.width = 500;
			commonp.height = 400;
			
			var calc:ColHeaderFuncConfig = new ColHeaderFuncConfig();
			calc.callBackFunc = callback;
			calc.colindex = colindex;
			calc.rowindex = rowindex;
			calc.gridname = gridName;
			calc.x = 4;
			calc.y = 4;
			calc.width = 482;
			calc.height = 360;
			commonp.content.addChild(calc);
			commonp.popup(true);
		}
		public static function popupFunctionTip(funcName:String):void{
			var commonp:CommonPopUpContainer = new CommonPopUpContainer();
			commonp.title.text = "函数帮助";
			commonp.width = 600;
			commonp.height = 400;
			
			var calc:FunctionTip = new FunctionTip(funcName);
			calc.x = 4;
			calc.y = 4;
			calc.width = 582;
			calc.height = 360;
			commonp.content.addChild(calc);
			commonp.popup(true);
		}
		
	}
}