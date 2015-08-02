package com.grid.model.celltype
{
	import com.grid.consts.CellConst;
	import com.grid.interfaces.ICellType;

	public class CellTypeFactory
	{
		private static var _inst:CellTypeFactory = new CellTypeFactory();
		public function CellTypeFactory()
		{
		}
		
		public static function getInst():CellTypeFactory{
			return _inst;
		}
		
		public function getCellTypeData(type:int):ICellType{
			if(type==CellConst.CELLTYPE_NONE){
				return new NONEType();
			}else if(type==CellConst.CELLTYPE_TEXT){
				return new TextType();
			}else if(type==CellConst.CELLTYPE_IMAGE){
				return new ImageType();
			}else if(type==CellConst.CELLTYPE_BUTTON){
				return new ButtonType();
			}else if(type==CellConst.CELLTYPE_CALCULATOR){
				return new CalculatorType();
			}else if(type==CellConst.CELLTYPE_CHECKBOX){
				return new CheckBoxType();
			}else if(type==CellConst.CELLTYPE_COLORPICKER){
				return new ColorPickerType();
			}else if(type==CellConst.CELLTYPE_COMBOBOX){
				return new ComboBoxType();
			}else if(type==CellConst.CELLTYPE_DATE){
				return new DateTimeType();
			}else if(type==CellConst.CELLTYPE_DATETIME){
				return new DateTimeType();
			}else if(type==CellConst.CELLTYPE_LINK){
				return new LinkType();
			}else if(type==CellConst.CELLTYPE_NUMERIC){
				return new NumericType();
			}else if(type==CellConst.CELLTYPE_PROCESSER){
				return new ProcesserType();
			}else if(type==CellConst.CELLTYPE_RADIO){
				return new RadioType();
			}else if(type==CellConst.CELLTYPE_RICHTEXT){
				return new RichTextType();
			}else if(type==CellConst.CELLTYPE_SLIDER){
				return new SliderType();
			}else if(type==CellConst.CELLTYPE_TIME){
				return new DateTimeType();
			}else if(type==CellConst.CELLTYPE_GROUPNODE){
				return new GroupNodeType();
			}
			return new NONEType();
		}
	}
}