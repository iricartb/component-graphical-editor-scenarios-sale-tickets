package {
	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;
	import fl.controls.Label;
	import flash.text.TextField;
	import Estilos;
	import Variables;


	public class Coordenadas extends Sprite {
 		public var My_Var_In_Coord:Variables = new Variables();
		
		public function Coordenadas() { }
		
		public function Refrescar(Board_Dise:Object) {
			Eliminar_Duplicados(Board_Dise)
			return;
		}

		public function Eliminar_Duplicados(Board_Dise:Object) {
 			for (var i:int = 0; i<Board_Dise.numChildren; i++) {
				if (Board_Dise.getChildAt(i).name == "But"){
					for (var j:int=Board_Dise.numChildren-1; j>i; j--){
						if (Board_Dise.getChildAt(i).x == Board_Dise.getChildAt(j).x && Board_Dise.getChildAt(i).y == Board_Dise.getChildAt(j).y) {
							My_Var_In_Coord.getInstance().Butaca_Borrada = true;
							Board_Dise.removeChild(Board_Dise.getChildAt(j));
						}
					}
				}
			}
			return;
		}
	}
}