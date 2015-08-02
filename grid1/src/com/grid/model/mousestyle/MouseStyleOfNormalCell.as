package com.grid.model.mousestyle
{
	import flash.display.Graphics;
	import flash.display.Sprite;
	
	
	public class MouseStyleOfNormalCell extends Sprite
	{
		public function MouseStyleOfNormalCell()
		{
			super();
			var g:Graphics = this.graphics;
			g.clear();
			g.lineStyle(2);
			var len:int = 10;
			var w:int = 4;
			g.moveTo(-len,-w);
			g.lineTo(-w,-w);
			g.lineTo(-w,-len);
			g.lineTo(w,-len);
			g.lineStyle(3);
			g.lineTo(w,-w);
			g.lineStyle(2);
			g.lineTo(len,-w);
			
			g.lineStyle(3);
			g.lineTo(len,w);
			g.lineStyle(2);
			g.lineTo(w,w);
			
			g.lineStyle(3);
			g.lineTo(w,len);
			g.lineTo(-w,len);
			g.lineStyle(2);
			g.lineTo(-w,w);
			g.lineTo(-len,w);
			g.lineTo(-len,-w);
			
			g.moveTo(-w,-w);
			g.lineTo(w,w);
			g.moveTo(w,-w);
			g.lineTo(-w,w);
		}
	}
}