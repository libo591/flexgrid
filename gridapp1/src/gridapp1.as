package
{
	import com.basic.cursor.CursorManager;
	import com.demonsters.debugger.MonsterDebugger;
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	import morn.core.handlers.Handler;
	
	public class gridapp1 extends Sprite
	{
		private var cursor:CursorManager;
		public function gridapp1()
		{
			this.addEventListener(Event.ADDED_TO_STAGE,add2Stage);
		}
		
		protected function add2Stage(event:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE,add2Stage);
			MonsterDebugger.initialize(this);
			App.init(this);
			App.loader.loadAssets(["assets/comp.swf"],new Handler(complete));
		}
		
		private function complete():void
		{
			var main:Main = new Main();
			main.width = stage.width;
			main.height = stage.height;
			addChild(main);
		}
	}
}