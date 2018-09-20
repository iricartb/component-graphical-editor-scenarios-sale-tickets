package {
    import flash.net.*
	import flash.utils.*
    import flash.display.*;
	import flash.net.URLRequest;
	import flash.display.Loader;
	import flash.events.*;
	import PolygonTest;
	import PointTest;
	
	import flash.text.TextFormat;
	import flash.display.*;
	import flash.display.DisplayObject;
	import flash.events.*;
	import flash.ui.ContextMenu;
	import flash.ui.ContextMenuItem;
	import flash.ui.ContextMenuBuiltInItems;
	import flash.display.MovieClip;
	import flash.filters.*;
	import Variables;
	import flash.geom.*;
	import fl.events.SliderEvent;
	
	public class CargarImagen extends Sprite {
		private var Cambio_Posicion:Point= new Point(0,0);
		private var Mov_Pol:Point= new Point(0,0);
		private var Point_Estado:Boolean=true;
		private var My_Var_In_Imag:Variables=new Variables();
        private var _loader: Loader;
		private var url:String;
		private var Mover_Imagen:Boolean=false;
		private var Imagen:Bitmap; 
		public var fr:FileReference;
		public var Metodo_Move:Function;
		public var Point_Act:String;
		public var _Block:Block;
		public var My_Alpha_Form:Form_Imagen_Alpha;
		public var sombra:DropShadowFilter=new DropShadowFilter();
		public var Menu_Marco:ContextMenu = new ContextMenu;
		public var Menu_Marco_Elim:ContextMenuItem=new ContextMenuItem("Eliminar Imagen");
		public var Marco_Imagen:PolygonTest;
		public var Ini_AlphaImg:Number;
		
		public function CargarImagen(Recinto_Board:Sprite) {
			Ini_AlphaImg = 1.00;
			
         	fr = new FileReference();
	      	var Filter:FileFilter = new FileFilter("Images", "*.jpg;*.gif;*.png");
			fr.browse([Filter]);
			var metodo_Imagen:Function=function(e:Event){Imagen_Selec(e,Recinto_Board)};
			fr.addEventListener ( Event.SELECT,metodo_Imagen) ;

		}
		private function Imagen_Selec ( evt : Event, Recinto_Board:Sprite) : void{
			fr.load ( ) ;
            var metodo_Imagen:Function=function(e:Event){_onDataLoaded(e,Recinto_Board)};
 		    fr.addEventListener(Event.COMPLETE, metodo_Imagen);
		}
       private function _onDataLoaded ( evt : Event,Recinto_Board:Sprite) : void
		{
			var tempFileRef : FileReference = FileReference ( evt.target ) ;
			_loader = new Loader ( ) ;
			var metodo_Imagen:Function=function(e:Event){imagenCargada(e,Recinto_Board)};
			_loader.contentLoaderInfo.addEventListener ( Event.COMPLETE, metodo_Imagen ) ;
			_loader.loadBytes ( tempFileRef.data ) ;
		}

		public function disableContextMenu() { if (Marco_Imagen != null) Marco_Imagen.contextMenu = null; }
		public function enableContextMenu() { if (Marco_Imagen != null) Marco_Imagen.contextMenu = Menu_Marco; }
		
		private function imagenCargada(event:Event,Recinto_Board:Sprite):void {
			var difX:Number;
			var difY:Number;
			
			// Menu de Imagen
			var Metodo_Elim:Function=function(e:ContextMenuEvent){_Menu_Marco_Elim(e,Recinto_Board)};
			Menu_Marco_Elim.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT,Metodo_Elim);
			Menu_Marco.hideBuiltInItems();
			Menu_Marco.customItems.push(Menu_Marco_Elim);
			
			// Marco de Imagen
			var Marco_Vertex:Array=[];
			Marco_Vertex.push({x:150, y:150});
			Marco_Vertex.push({x:300, y:150});
			Marco_Vertex.push({x:300, y:300});
			Marco_Vertex.push({x:150, y:300});
			
			Marco_Imagen = new PolygonTest(Marco_Vertex, "Img", My_Var_In_Imag);
			Recinto_Board.addChild(Marco_Imagen);
			Marco_Imagen.contextMenu = Menu_Marco;
			
			Marco_Imagen.name="IMG-" + fr.name + getTimer();
			Marco_Imagen.getChildAt(Marco_Imagen.getChildIndex(Marco_Imagen.getChildByName("Etiqueta"))).visible=false;
			Marco_Imagen.doubleClickEnabled=true;
			Marco_Imagen.getChildAt(0).visible=false;
			var Metodo_Alpha:Function=function(e:MouseEvent){_Menu_Marco_Alpha(e,Recinto_Board,Imagen)};
			Marco_Imagen.addEventListener(MouseEvent.DOUBLE_CLICK,Metodo_Alpha);
			var Metodo_Imagen_Click:Function=function(e:MouseEvent){Marco_Imagen_Click(e,Recinto_Board)};
			Marco_Imagen.addEventListener(MouseEvent.CLICK, Metodo_Imagen_Click);
			var Metodo_Imagen_Move:Function=function(e:MouseEvent){Marco_Imagen_Down(e,Recinto_Board)};
			Marco_Imagen.addEventListener(MouseEvent.MOUSE_DOWN, Metodo_Imagen_Move);
			var Metodo_Imagen_Stop:Function=function(e:MouseEvent){Marco_Imagen_UP(e,Recinto_Board)};
			Marco_Imagen.addEventListener(MouseEvent.MOUSE_UP, Metodo_Imagen_Stop);
			var Metodo_Imagen_Over:Function=function(e:MouseEvent){Marco_Imagen_Over(e,Recinto_Board)};
			Marco_Imagen.addEventListener(MouseEvent.MOUSE_OVER, Metodo_Imagen_Over);
			
            Imagen=event.target.content as Bitmap;
			Imagen.smoothing = true;
			Marco_Imagen.addChild(Imagen);
			Marco_Imagen.getChildAt(1).name="P1";
			Marco_Imagen.getChildAt(2).name="P2";
			Marco_Imagen.getChildAt(3).name="P3";
			Marco_Imagen.getChildAt(4).name="P4";
			Marco_Imagen.getChildAt(1).visible=false;
			Marco_Imagen.getChildAt(2).visible=false;
			Marco_Imagen.getChildAt(3).visible=false;
			Marco_Imagen.getChildAt(4).visible=false;
			
			difX =  Recinto_Board.mouseX - Marco_Imagen.getChildAt(1).x;
			difY =  Recinto_Board.mouseY - Marco_Imagen.getChildAt(1).y;
			Marco_Imagen.getChildAt(1).x = Recinto_Board.mouseX;
			Marco_Imagen.getChildAt(1).y = Recinto_Board.mouseY;
			Marco_Imagen.getChildAt(2).x += difX;
			Marco_Imagen.getChildAt(2).y += difY;
			Marco_Imagen.getChildAt(3).x += difX;
			Marco_Imagen.getChildAt(3).y += difY;
			Marco_Imagen.getChildAt(4).x += difX;
			Marco_Imagen.getChildAt(4).y += difY;
			
            Imagen.x=Marco_Imagen.getChildAt(1).x;
            Imagen.y=Marco_Imagen.getChildAt(1).y;
			Imagen.width=Marco_Imagen.getChildAt(2).x-Marco_Imagen.getChildAt(1).x;
			Imagen.height=Marco_Imagen.getChildAt(4).y-Marco_Imagen.getChildAt(1).y;
			
			var Metodo_Act:Function=function(e:MouseEvent){_Point_Act(e,Marco_Imagen)};
			Marco_Imagen.getChildAt(1).addEventListener(MouseEvent.MOUSE_DOWN, Metodo_Act);
			Marco_Imagen.getChildAt(2).addEventListener(MouseEvent.MOUSE_DOWN, Metodo_Act);
			Marco_Imagen.getChildAt(3).addEventListener(MouseEvent.MOUSE_DOWN, Metodo_Act);
			Marco_Imagen.getChildAt(4).addEventListener(MouseEvent.MOUSE_DOWN, Metodo_Act);
			var Metodo_Des:Function=function(e:MouseEvent){_Point_Des(e,Marco_Imagen)};
			Marco_Imagen.getChildAt(1).addEventListener(MouseEvent.MOUSE_UP, Metodo_Des);
			Marco_Imagen.getChildAt(2).addEventListener(MouseEvent.MOUSE_UP, Metodo_Des);
			Marco_Imagen.getChildAt(3).addEventListener(MouseEvent.MOUSE_UP, Metodo_Des);
			Marco_Imagen.getChildAt(4).addEventListener(MouseEvent.MOUSE_UP, Metodo_Des);
			Metodo_Move=function(e:MouseEvent){Reajuste(e,Marco_Imagen,Imagen)};
		}
		
		private function _Point_Act(_Point:MouseEvent,Marco_Imagen:Sprite){
			Point_Act=_Point.target.name;
            Marco_Imagen.parent.addEventListener(MouseEvent.MOUSE_MOVE, Metodo_Move);
		}
		
		private function _Point_Des(_Point:MouseEvent,Marco_Imagen:Sprite){
			Marco_Imagen.parent.removeEventListener(MouseEvent.MOUSE_MOVE, Metodo_Move);
		}
		
		private function Reajuste(e:MouseEvent,Marco_Imagen:Sprite,Imagen:Bitmap){
			if (Point_Act==Marco_Imagen.getChildAt(1).name){
				Marco_Imagen.getChildAt(4).x=Marco_Imagen.getChildAt(1).x;
  	            Marco_Imagen.getChildAt(2).y=Marco_Imagen.getChildAt(1).y;
			}
			if (Point_Act==Marco_Imagen.getChildAt(2).name){
				Marco_Imagen.getChildAt(3).x=Marco_Imagen.getChildAt(2).x;
  	            Marco_Imagen.getChildAt(1).y=Marco_Imagen.getChildAt(2).y;
			}
			if (Point_Act==Marco_Imagen.getChildAt(3).name){
				Marco_Imagen.getChildAt(2).x=Marco_Imagen.getChildAt(3).x;
  	            Marco_Imagen.getChildAt(4).y=Marco_Imagen.getChildAt(3).y;
			}
			if (Point_Act==Marco_Imagen.getChildAt(4).name){
				Marco_Imagen.getChildAt(1).x=Marco_Imagen.getChildAt(4).x;
  	            Marco_Imagen.getChildAt(3).y=Marco_Imagen.getChildAt(4).y;
			}
			Imagen.x=Marco_Imagen.getChildAt(1).x;
            Imagen.y=Marco_Imagen.getChildAt(1).y;
			Imagen.width=Marco_Imagen.getChildAt(2).x-Marco_Imagen.getChildAt(1).x;
			Imagen.height=Marco_Imagen.getChildAt(4).y-Marco_Imagen.getChildAt(1).y;
		}

		private function _Menu_Marco_Alpha(event:MouseEvent,Recinto_Board:Sprite,Imagen:Bitmap){
			_Block= new Block();
			_Block.alpha = 0.9;
			Ini_AlphaImg = Imagen.alpha;
			Recinto_Board.parent.parent.parent.addChild(_Block);
		    My_Alpha_Form = new Form_Imagen_Alpha();
			
			My_Alpha_Form.Slider_TransImg.width = 150;
			My_Alpha_Form.Slider_TransImg.snapInterval = 0.01; 
			My_Alpha_Form.Slider_TransImg.maximum = 1;
			My_Alpha_Form.Slider_TransImg.value = Ini_AlphaImg;

			var myFormat:TextFormat = new TextFormat();
			myFormat.font = "Verdana";
			myFormat.color = 0xFFFFFF;
			myFormat.size = 11;
			
			My_Alpha_Form.Lbl_SliderText.setStyle("textFormat", myFormat);
			if (Ini_AlphaImg == 0) My_Alpha_Form.Lbl_SliderText.text = "0 %";
			else My_Alpha_Form.Lbl_SliderText.text = (Ini_AlphaImg * 100).toFixed(0).toString() + " %";
			My_Alpha_Form.Slider_TransImg.addEventListener(SliderEvent.THUMB_DRAG, changeHandler);
	
			Recinto_Board.parent.parent.parent.addChild(My_Alpha_Form);
			centrar_Alerta(My_Alpha_Form,Recinto_Board);
			var Metodo_Aceptar:Function=function(e:MouseEvent){My_Alpha_Form_Aceptar(e,Recinto_Board,Imagen)};
			My_Alpha_Form.Btn_Aceptar.addEventListener(MouseEvent.MOUSE_DOWN,Metodo_Aceptar);
			var Metodo_Cancelar:Function=function(e:MouseEvent){My_Alpha_Form_Cancelar(e,Recinto_Board)};
			My_Alpha_Form.Btn_Cancelar.addEventListener(MouseEvent.MOUSE_DOWN,Metodo_Cancelar);
		}

		function changeHandler(event:SliderEvent):void { 
           Imagen.alpha = event.value;
		   if (event.value == 0) My_Alpha_Form.Lbl_SliderText.text = "0 %";
		   else My_Alpha_Form.Lbl_SliderText.text = (event.value * 100).toFixed(0).toString() + " %";
		}

		private function My_Alpha_Form_Aceptar(e:MouseEvent,Recinto_Board:Sprite,Imagen:Bitmap){
			Recinto_Board.parent.parent.parent.removeChild(_Block);
			Recinto_Board.parent.parent.parent.removeChild(My_Alpha_Form);
			Imagen.alpha = My_Alpha_Form.Slider_TransImg.value;
		}
		
		private function My_Alpha_Form_Cancelar(e:MouseEvent,Recinto_Board:Sprite){
			Recinto_Board.parent.parent.parent.removeChild(_Block);
			Recinto_Board.parent.parent.parent.removeChild(My_Alpha_Form);
			Imagen.alpha = Ini_AlphaImg;
		}
		
		private function _Menu_Marco_Elim(event:ContextMenuEvent,Recinto_Board:Sprite){
			Eliminar_Imagen(event.contextMenuOwner,Recinto_Board);
		}
		
		private function Eliminar_Imagen(e:Object, Recinto_Board:Sprite){
			e.Polygon_Eliminado=true;
			Recinto_Board.removeChild(Recinto_Board.getChildByName(e.name));
		}
		
		private function Marco_Imagen_Click(e:MouseEvent,Recinto_Board:Sprite){
			if (My_Var_In_Imag.getInstance().Dibujando_Seccion==false && e.target.name.substr(0,1)!="P"){
			  if (e.target.getChildAt(1).visible==false){
			       e.target.getChildAt(1).visible=true;
			       e.target.getChildAt(2).visible=true;
			       e.target.getChildAt(3).visible=true;
			       e.target.getChildAt(4).visible=true;
			  } else {
			       e.target.getChildAt(1).visible=false;
			       e.target.getChildAt(2).visible=false;
			       e.target.getChildAt(3).visible=false;
			       e.target.getChildAt(4).visible=false;
			  }
			  var Mov_Pol:Point=new Point(Cambio_Posicion.x-e.target.x,Cambio_Posicion.y-e.target.y);
			  if (Mov_Pol.x!=0 || Mov_Pol.y!=0){
			    e.target.getChildAt(1).visible=Point_Estado;
			    e.target.getChildAt(2).visible=Point_Estado;
			    e.target.getChildAt(3).visible=Point_Estado;
	            e.target.getChildAt(4).visible=Point_Estado;
			    Cambio_Posicion.x=e.target.x;
			    Cambio_Posicion.y=e.target.y;
			  } else {
			    Point_Estado= e.target.getChildAt(1).visible;
			  }
			}
			
		}	
		private function Marco_Imagen_Down(e:MouseEvent,Recinto_Board:Sprite){
			Recinto_Board.addEventListener(MouseEvent.MOUSE_DOWN,Recinto_Board_Down)
			e.target.addEventListener(MouseEvent.MOUSE_MOVE, Imagen_Move);
		}
		private function Recinto_Board_Down(e:MouseEvent){
			e.target.stopDrag();
		}
		private function Imagen_Move(e:MouseEvent){
			e.target.startDrag();
		}
        private function Marco_Imagen_UP(e:MouseEvent,Recinto_Board:Sprite){
			    Recinto_Board.removeEventListener(MouseEvent.MOUSE_DOWN,Recinto_Board_Down)
				e.target.removeEventListener(MouseEvent.MOUSE_MOVE, Imagen_Move);
		}
		private function Marco_Imagen_Over(e:MouseEvent,Recinto_Board:Sprite){
			if (e.target.name=="IMG"){
			   Point_Estado= e.target.getChildAt(1).visible;
  			   Cambio_Posicion.x=e.target.x;
		       Cambio_Posicion.y=e.target.y;
			}
		}
		public function centrar_Alerta(e:Object,Recinto_Board:Sprite){
			e.x=(Recinto_Board.stage.stageWidth/2)-(e.width/2);
			e.y=(Recinto_Board.stage.stageHeight/2)-(e.height/2);
		}
	}
}




