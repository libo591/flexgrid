package com.grid.consts
{
	public class CellConst
	{
		public static const HORIZONTALALIGH_LEFT	:int = 0;
		public static const HORIZONTALALIGH_CENTER	:int = 1;
		public static const HORIZONTALALIGH_RIGHT	:int = 2;
		
		public static const VERTICALALIGN_TOP		:int = 0;
		public static const VERTICALALIGN_MIDDLE	:int = 1;
		public static const VERTICALALIGN_BOTTOM	:int = 2;
		
		public static const TEXTRESIZE_FIXCELL		:int = 0;
		public static const TEXTRESIZE_NOCHANGE		:int = 1;
		
		public static const CELLTYPE_NONE			:int = 0;
		public static const CELLTYPE_TEXT			:int = 1;
		public static const CELLTYPE_IMAGE			:int = 2;
		public static const CELLTYPE_CALCULATOR		:int = 3;//弹出计算器
		public static const CELLTYPE_NUMERIC		:int = 4;//通过步长设置，点击上下按钮改变数
		public static const CELLTYPE_DATE			:int = 5;//日期
		public static const CELLTYPE_TIME			:int = 6;//时间
		public static const CELLTYPE_DATETIME		:int = 7;//日期时间
		public static const CELLTYPE_BUTTON			:int = 8;//按钮
		public static const CELLTYPE_CHECKBOX		:int = 9;//复选框
		public static const CELLTYPE_COMBOBOX		:int = 10;//下拉
		public static const CELLTYPE_LIST			:int = 11;//
		public static const CELLTYPE_LINK			:int = 12;//
		public static const CELLTYPE_RADIO			:int = 13;//
		public static const CELLTYPE_COLORPICKER	:int = 15;//
		public static const CELLTYPE_PROCESSER		:int = 16;//
		public static const CELLTYPE_SLIDER			:int = 17;//
		public static const CELLTYPE_RICHTEXT		:int = 18;//
		public static const CELLTYPE_GROUPNODE		:int = 19;//
		
		public function CellConst()
		{
		}
	}
}