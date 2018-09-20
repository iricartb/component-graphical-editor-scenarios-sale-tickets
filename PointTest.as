package {
	import flash.display.*;
	import flash.events.*;
	import Estilos;
	import Variables;


	public class PointTest extends Sprite {
        public var Polygon_Mod:Boolean=true;
		public var _Est:Estilos;
		public var My_Var_In_Pt:Variables= new Variables();
		public function PointTest() {
            _Est=new Estilos(); 
			graphics.beginFill(_Est.Polygonos_St()[3],1);
			graphics.drawCircle(0, 0, 2.5);
			graphics.endFill();
			addEventListener(MouseEvent.MOUSE_DOWN, this.mouseDownHandler);
			addEventListener(MouseEvent.CLICK, this.Enciende);
			return;
		}// end function

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
		
		public function Seccion_Move(e:MouseEvent){
		}
		private function enterFrameHandler(event:Event):void {
			event.target.parent.stopDrag();
			event.target.parent.parent.stopDrag();
			
			x = parent.mouseX;
			y = parent.mouseY;
			return;
		}// end function
		private function Enciende(e:MouseEvent){
			My_Var_In_Pt.getInstance().Editando_Pol=true;
		}
	}
}