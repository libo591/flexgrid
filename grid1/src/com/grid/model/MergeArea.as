package com.grid.model
{
	public class MergeArea
	{
		private var _sr:int;
		private var _er:int;
		private var _sc:int;
		private var _ec:int;
		
		public function MergeArea(a:int=-1,b:int=-1,c:int=-1,d:int=-1)
		{
			this.sr = a;
			this.er = b;
			this.sc = c;
			this.ec = d;
		}

		public function get sr():int
		{
			return _sr;
		}

		public function set sr(value:int):void
		{
			_sr = value;
		}

		public function get er():int
		{
			return _er;
		}

		public function set er(value:int):void
		{
			_er = value;
		}

		public function get sc():int
		{
			return _sc;
		}

		public function set sc(value:int):void
		{
			_sc = value;
		}

		public function get ec():int
		{
			return _ec;
		}

		public function set ec(value:int):void
		{
			_ec = value;
		}
		public function config(arr:Array):void
		{
			this.sr = arr[0];
			this.er = arr[1];
			this.sc = arr[2];
			this.ec = arr[3];
		}
		public function clear():void
		{
			this.sr = -1;
			this.er = -1;
			this.sc = -1;
			this.ec = -1;
		}
	}
}