package com.grid.model.celltype
{
	import com.grid.consts.CellConst;
	
	import flash.text.TextFormatAlign;
	
	import morn.core.components.Label;
	
	
	
	public class TextType extends NONEType
	{
		private var _label:Label;
		public function TextType()
		{
		}
		
		override public function display():void
		{
			if(cell.extendProp.dataVisiable){
				if(_label==null){
					_label = new Label();
					p.addChild(_label);
				}
				_label.width = cw;
				_label.text = cell.extendProp.text;
				//显示格式
				//前景色
				_label.color = cell.style.forecolor;
				//缩进
				_label.indent = cell.style.indentation;
				_label.size = cell.style.fontsize;
				_label.font = cell.style.typeface;
				_label.bold = cell.style.bold;
				_label.format.italic = cell.style.italic; 
				_label.underline = cell.style.underline;
				//水平对齐
				if(cell.style.horizontalAligh==CellConst.HORIZONTALALIGH_LEFT){
					_label.align = TextFormatAlign.LEFT;
				}else if(cell.style.horizontalAligh==CellConst.HORIZONTALALIGH_RIGHT){
					_label.align = TextFormatAlign.RIGHT;
				}else{
					_label.align = TextFormatAlign.CENTER;
				}
				//尺寸调整方式
				//自动换行
				//纵向对齐
				_label.height = ch;
				/*_label.height = _label.textField.height+2;
				if(cell.style.verticalAlign==CellConst.VERTICALALIGN_MIDDLE){
					_label.y = ch/2-_label.height/2;
				}else if(cell.style.verticalAlign==CellConst.VERTICALALIGN_BOTTOM){
					_label.y = ch-_label.height;
				}*/
			}else{
				_label.visible = false;
			}
		}
	}
}