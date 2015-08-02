package com.grid.model
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;

	public class GridEventDispatcher
	{
		private static var _inst:GridEventDispatcher;
		private var eventDispatcher:IEventDispatcher;
		
		public function GridEventDispatcher(target:IEventDispatcher = null){
			eventDispatcher = new EventDispatcher(target);
		}
		
		/** 获取FastReportEventDispatcher类的唯一实例 */
		public static function getInstance():GridEventDispatcher{
			if(!_inst){
				_inst = new GridEventDispatcher();
			}
			return _inst;
		}
		
		/** 添加事件侦听器函数 */
		public function addEventListener(type:String,listener:Function,useCapture:Boolean=false,pririty:int=0,useWeakReference:Boolean=true):void{
			eventDispatcher.addEventListener(type,listener,useCapture,pririty,useWeakReference);
		}
		
		/** 删除事件监听器函数 */
		public function removeEventListener(type:String,listener:Function,useCapture:Boolean=false,priority:int=0,useWeakReference:Boolean=true):void{
			eventDispatcher.removeEventListener(type,listener,useCapture);
		}
		
		/** 事件派发函数 */
		public function dispatchEvent(event:GridEvent):Boolean{
			return eventDispatcher.dispatchEvent(event);
		}
		
		/** 检查是否已经存在事件侦听器 */
		public function hasEventListener(type:String):Boolean{
			return eventDispatcher.hasEventListener(type);
		}
		
		/** 检查eventDispatcher 对象或其他任何数组是否注册了指定类型的事件侦听器 */
		public function willTrigger(type:String):Boolean{
			return eventDispatcher.willTrigger(type);
		}
	}
}