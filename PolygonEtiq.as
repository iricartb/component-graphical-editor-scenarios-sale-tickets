package {

	import flash.events.*;
	import fl.controls.Label;
	import flash.text.TextFormat;
	import Estilos;
	import Variables;
	
	public class PolygonEtiq extends Label {
		public var _Est:Estilos;
		public var Global_Variables:Variables;
		
		public function PolygonEtiq(Polygon_Vertex:Array, Etiqueta_text:String, Global_Vars:Variables, locked:Boolean=false) {
			_Est=new Estilos();
			text=Etiqueta_text;
			height=25;
			name="Etiqueta";
			setStyle("textFormat", _Est.Polygonos_St()[5]);
			width=Etiqueta_text.length*30;
			x=x-(width/2);
			y=y-(height/2);
			Global_Variables = Global_Vars;
			
			if (!locked) addEventListener(MouseEvent.MOUSE_DOWN, this.mouseDownHandler);
			return;
		}
		// Funciones de Eventos
		private function mouseUpHandler(event:MouseEvent):void {
			removeEventListener(Event.ENTER_FRAME, this.enterFrameHandler);
			stage.removeEventListener(MouseEvent.MOUSE_UP, this.mouseUpHandler);
			return;
		}// end function

		public function mouseDownHandler(event:MouseEvent):void {
			addEventListener(Event.ENTER_FRAME, this.enterFrameHandler);
			stage.addEventListener(MouseEvent.MOUSE_UP, this.mouseUpHandler);
			return;
		}// end function

		private function enterFrameHandler(event:Event):void {
			if (Global_Variables.getInstance().Dibujando_Seccion == false) {
				x = parent.mouseX - (width/8);
				y = parent.mouseY - (height/4);
			}
			return;
		}// end function
	}
}