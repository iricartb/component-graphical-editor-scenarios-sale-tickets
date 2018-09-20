package {
   import flash.display.Sprite;
   import flash.display.Shape;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   import flash.events.MouseEvent;

   import Sombra;
   import Delay;

   public class ToolTip extends Sprite {
      private var _ruta:Sprite;
      private var _boton:Object;
      private var _clip:Sprite;
      private var _fondo:Shape;
      private var _texto:TextField;
      private var _formato:TextFormat;
      private var _sombra:Sombra;
      private var _delay:Delay;

      public function ToolTip(boton:Object, texto:String) {
         _ruta = boton.parent;
         _boton = boton;
         _clip = new Sprite();
         _clip.x = _boton.x;
         _clip.y = _boton.y;
         _clip.visible = false;
         _ruta.addChild(_clip);

         iniFondo();
         iniTexto();
         iniEvents();

         setTexto(texto);
      }

      private function iniFondo():void {
         _fondo = new Shape();
         _fondo.x = _fondo.y = 0;
         _sombra = new Sombra(_fondo);
         _clip.addChild(_fondo);
      }

      private function iniTexto():void {
         _texto = new TextField();
         _texto.autoSize = TextFieldAutoSize.LEFT;
         _texto.background = false;
         _texto.border = false;
         _texto.multiline = false;
         _formato = new TextFormat();
         _formato.font = "Verdana";
         _formato.color = 0x000000;
         _formato.size = 10;
         _formato.underline = false;
         _texto.defaultTextFormat = _formato;
         _texto.x = 5;
         _texto.y = 0;
         _clip.addChild(_texto);
      }

      public function setTexto(texto:String):void {
         _texto.text = texto;
         updateFondo(_texto.textWidth+15,_texto.textHeight+5);
      }

      private function updateFondo(qWidth:int,qHeight:int):void {
         _fondo.graphics.clear();
         _fondo.graphics.beginFill(0xFFFFCC);
         _fondo.graphics.lineStyle(1, 0x999999);
         _fondo.graphics.drawRect(0, 0, qWidth, qHeight);
         _fondo.graphics.endFill();
      }

      private function iniEvents() {
         _boton.addEventListener(MouseEvent.MOUSE_OVER, mouse_over);
         _boton.addEventListener(MouseEvent.MOUSE_MOVE, mouse_move);
         _boton.addEventListener(MouseEvent.MOUSE_OUT, mouse_out);
      }

      private function mouse_over(event:MouseEvent):void {
         Delay.action(1,true,this,"mouse_over2");
      }
      
      public function mouse_over2():void {
         _clip.visible = true;
      }
      
      private function mouse_move(event:MouseEvent):void {
         _clip.x = mouseX ;
         _clip.y = mouseY + 20;
      }
      
      private function mouse_out(event:MouseEvent):void {
         _clip.visible = false;
         Delay.reset();
      }
   }
}