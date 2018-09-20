package {
	import flash.display.*;
	import flash.events.*;
	import flash.ui.*;
	import flash.net.*;
	import flash.xml.*;
	import flash.filters.*;
	import flash.geom.*;
	import flash.system.*;
	import flash.text.*;
	import flash.utils.*;
	import fl.controls.*;
	import fl.transitions.*;
	import fl.accessibility.*;
	import fl.events.*;
	import fl.containers.*;
	import Estilos;
	import Variables;
	
	public class Herramientas extends Sprite {
		public var _Est:Estilos;

		public var Herramienas_Color:uint=0xCC6633;
		public var Herramienas_Color_Estado:uint=0xCC6633;

		public var img_Nuevo:UILoader;
		public var img_Imagen:UILoader;
		public var img_Formas:UILoader;
		public var img_Mover:UILoader;
		public var img_Salvar:UILoader;
		public var img_Texto:UILoader;
		public var img_Grafico:UILoader;
		
		public var btn_Nuevo:Button;
		public var btn_Formas:Button;
		public var btn_Imagen:Button;
		public var btn_Mover:Button;
		public var btn_Salvar:Button;
		public var btn_Texto:Button;
		public var btn_Grafico:Button;
		
		public function Herramientas(Ancho:Number, Alto:Number, Global_Vars:Variables):void {
			
			_Est=new Estilos();
			
			graphics.beginFill(0xFFFFFF, 1.0);
			graphics.drawRect(0, 0, 160, Alto);
			graphics.endFill();
			
			graphics.beginFill(0xD6D6D6, 1.0);
			graphics.drawRect(160, 0, 1, Alto);
			graphics.endFill();
			
			graphics.beginFill(_Est.Herramientas_MPpal_St()[0],_Est.Herramientas_MPpal_St()[1]);
			graphics.drawRect(0, 0, Ancho, 39);
			graphics.endFill();
			
         	img_Nuevo = new UILoader();
			img_Nuevo.scaleContent = false;
			img_Nuevo.source = Global_Vars.getInstance().HTTP_SEditor + "images/mtools_new.png";
			img_Nuevo.move(5, 9);
			addChild(img_Nuevo);

			btn_Nuevo = new Button;
			btn_Nuevo.width =_Est.Herramientas_MPpal_St()[5]*1.2;
			btn_Nuevo.height =_Est.Herramientas_MPpal_St()[6];
			btn_Nuevo.x = 34;
			btn_Nuevo.y = 7;
			btn_Nuevo.label = "Nueva Sec.";
			btn_Nuevo.setStyle("textFormat", _Est.Herramientas_MPpal_St()[4]);
			this.addChild(btn_Nuevo);
			
         img_Imagen = new UILoader();
			img_Imagen.scaleContent = false;
			img_Imagen.source = Global_Vars.getInstance().HTTP_SEditor + "images/mtools_image.png";
			img_Imagen.move(btn_Nuevo.x + btn_Nuevo.width + 20, 8);
			addChild(img_Imagen);

			btn_Imagen = new Button;
			btn_Imagen.width =_Est.Herramientas_MPpal_St()[5];
			btn_Imagen.height =_Est.Herramientas_MPpal_St()[6];
			btn_Imagen.x = btn_Nuevo.x + btn_Nuevo.width + 52;
			btn_Imagen.y = 7;
			btn_Imagen.label = "Imagen";
			btn_Imagen.setStyle("textFormat", _Est.Herramientas_MPpal_St()[4]);
			this.addChild(btn_Imagen);

         img_Mover = new UILoader();
			img_Mover.scaleContent = false;
			img_Mover.source = Global_Vars.getInstance().HTTP_SEditor + "images/mtools_lockon.png";
			img_Mover.move(btn_Imagen.x + btn_Imagen.width + 20, 8);
			addChild(img_Mover);

			btn_Mover = new Button;
			btn_Mover.width =_Est.Herramientas_MPpal_St()[5];
			btn_Mover.height =_Est.Herramientas_MPpal_St()[6];
			btn_Mover.x = btn_Imagen.x + btn_Imagen.width + 49;
			btn_Mover.y = 7;
			btn_Mover.label = "Mover";
			btn_Mover.setStyle("textFormat", _Est.Herramientas_MPpal_St()[4]);
			this.addChild(btn_Mover);
			
         img_Salvar = new UILoader();
			img_Salvar.scaleContent = false;
			img_Salvar.source = Global_Vars.getInstance().HTTP_SEditor + "images/mtools_save.png";
			img_Salvar.move(btn_Mover.x + btn_Mover.width + 20, 8);
			addChild(img_Salvar);

			btn_Salvar = new Button;
			btn_Salvar.width =_Est.Herramientas_MPpal_St()[5];
			btn_Salvar.height =_Est.Herramientas_MPpal_St()[6];
			btn_Salvar.x = btn_Mover.x + btn_Mover.width + 49;
			btn_Salvar.y = 7;
			btn_Salvar.label = "Salvar";
			btn_Salvar.setStyle("textFormat", _Est.Herramientas_MPpal_St()[4]);
			this.addChild(btn_Salvar);

			/* Botones laterales Leyenda */
         img_Formas = new UILoader();
			img_Formas.scaleContent = false;
			img_Formas.source = Global_Vars.getInstance().HTTP_SEditor + "images/mtools_shapes.png";
			img_Formas.move(12, 283);
			addChild(img_Formas);
			
			btn_Formas = new Button;
			btn_Formas.width = _Est.Herramientas_MPpal_St()[9];
			btn_Formas.height = _Est.Herramientas_MPpal_St()[10];
			btn_Formas.x = 40;
			btn_Formas.y = 280;
			btn_Formas.label = "Figura";
			btn_Formas.setStyle("textFormat", _Est.Herramientas_MPpal_St()[8]);
			this.addChild(btn_Formas);
			
			img_Texto = new UILoader();
			img_Texto.scaleContent = false;
			img_Texto.source = Global_Vars.getInstance().HTTP_SEditor + "images/mtools_labels.png";
			img_Texto.move(12, img_Formas.y + img_Formas.height + _Est.Herramientas_MPpal_St()[10] + 2);
			addChild(img_Texto);
			
			btn_Texto = new Button;
			btn_Texto.width = _Est.Herramientas_MPpal_St()[9];
			btn_Texto.height = _Est.Herramientas_MPpal_St()[10];
			btn_Texto.x = 40;
			btn_Texto.y = img_Texto.y - 3;
			btn_Texto.label = "Etiqueta";
			btn_Texto.setStyle("textFormat", _Est.Herramientas_MPpal_St()[8]);
			this.addChild(btn_Texto);
		
			img_Grafico = new UILoader();
			img_Grafico.scaleContent = false;
			img_Grafico.source = Global_Vars.getInstance().HTTP_SEditor + "images/mtools_graphic.png";
			img_Grafico.move(12, img_Texto.y + img_Texto.height + _Est.Herramientas_MPpal_St()[10] + 2);
			addChild(img_Grafico);
			
			btn_Grafico = new Button;
			btn_Grafico.width = _Est.Herramientas_MPpal_St()[9];
			btn_Grafico.height = _Est.Herramientas_MPpal_St()[10];
			btn_Grafico.x = 40;
			btn_Grafico.y = img_Grafico.y - 3;
			btn_Grafico.label = "Gráfico";
			btn_Grafico.setStyle("textFormat", _Est.Herramientas_MPpal_St()[8]);
			this.addChild(btn_Grafico);
			
			this.addEventListener(MouseEvent.MOUSE_OVER, Herramientas_Over);

			return;
		}

		public function Herramientas_Over(event:MouseEvent) { if (Mouse.cursor != MouseCursor.BUTTON) Mouse.cursor = MouseCursor.ARROW; }
		
		public function desplazarVistaImagen(permit:Boolean, Global_Vars:Variables):void {
			if (permit) img_Mover.source = Global_Vars.getInstance().HTTP_SEditor + "images/mtools_lockoff.png";
			else img_Mover.source = Global_Vars.getInstance().HTTP_SEditor + "images/mtools_lockon.png"; 
		}
	}
}