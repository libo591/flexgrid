package com.grid.utils
{
	public class ArrayUtil
	{
		public function ArrayUtil()
		{
		}
		public static function switchItem(arr1:Array,index1:int,arr2:Array,index2:int):void{
			var tmp:* = arr1[index1];
			arr1[index1] = arr2[index2];
			arr2[index2] = tmp;
		}
		public static function moveItem(arr:Array,fromIndex:int,toIndex:int):Array{
			var result:Array = [];
			if(arr==null){
				return null;
			}
			var count:int = arr.length;
			if(fromIndex<toIndex){
				if(fromIndex==toIndex){
					return arr;
				}
				for(var i:int=0;i<count;i++){
					if(i<fromIndex||i>toIndex){
						result[i] = arr[i];
					}else if(i>=fromIndex&&i<toIndex){
						result[i] = arr[i+1];
					}else if(i==toIndex){
						result[i] = arr[fromIndex];
					}
				}
			}else{
				if(fromIndex==toIndex+1){
					return arr;
				}
				if(toIndex==-1){
					for(var j:int=0;j<count;j++){
						if(j==0){
							result[j] = arr[fromIndex];
						}else if(j<=fromIndex){
							result[j] = arr[j-1];
						}else{
							result[j] = arr[j];
						}
					}
				}else{
					for(var k:int=0;k<count;k++){
						if(k>fromIndex||k<=toIndex){
							result[k] = arr[k];
						}else if(k==toIndex+1){
							result[k] = arr[fromIndex];
						}else if(k>toIndex+1&&k<=fromIndex){
							result[k] = arr[k-1];
						}
					}
				}
			}
			return result;
		}
	}
}