package {
   import flash.ui.ContextMenu;
   import flash.ui.ContextMenuItem;
   import flash.ui.ContextMenuBuiltInItems;
   
   public class Variables {
      public var Dibujando_Forma:Boolean = false;
      public var Dibujando_Seccion:Boolean = false;
      public var Dibujando_Forma_Tipo:String;
      public var Insertar_Label:Boolean = false;
      public var Label_Objeto_Seleccionado:Object;
      public var Escribir_Label:Boolean = false;
      public var Insertando_Grafico:Boolean = false; 
      public var Insertando_Grafico_Tipo:int = 0;
      public var Insertando_Grafico_Rotacion:int = 0;
      public var Insertando_Grafico_Anchura:int = 0;
      public var Insertando_Grafico_Altura:int = 0;
      public var Vista_Recinto:Boolean = true;
      public var Vista_Actual:Object;
      public var Mover_But:Boolean = false;
      public var Mover_Recinto:Boolean = false;
      public var Mover_Seccion:Boolean = false;
      public var Seccion_Edit:String = null;
      public var Editando_Pol:Boolean = false;
      public var Editando_Pol_Secc:Boolean = false;
      public var Editando_Pol_Index:int = -1;
      public var Marcar_Butaca:Boolean = false;
      public var Butaca_Borrada:Boolean = false;
      public var Butacas_Marcadas:int = 0;
      public var Moviendo_Objeto:Boolean = false;
      public var Creando_Objeto:Boolean = false;
      public var ControlKey_Pressed:Boolean = false;
      public var Ultima_Butaca_Marcada:Object = null;
      public var Numero_MaxElem_Propiedades_Fila:int = 100;
      public var Numero_MaxElem_Propiedades_Columna:int = 100;
      public var lockedRecinto:int = 0;
      public var HTTP_SEditor = "http://127.0.0.1/sEditor/";
      
      public static var DIBUJAR_TIPO_RECTANGULO:String = "rectangulo";
      public static var DIBUJAR_TIPO_LIBRE:String = "libre";
      public static var DISTANCIA_VERTICES_MIN_POLIGONOS = 5;
      
      public static var LABEL_MAX_CHARACTERS:int = 30;
      public static var DEFAULT_LABEL_FONT:String = "Verdana";
      public static var DEFAULT_LABEL_SIZE:int = 18;
      public static var DEFAULT_LABEL_BOLD:Boolean = false;
      public static var DEFAULT_LABEL_ITALIC:Boolean = false;
      public static var DEFAULT_LABEL_COLOR:uint = 0x000000;

      public static var DEFAULT_GRAFICO_ALTO:int = 24;
      public static var DEFAULT_GRAFICO_ANCHO:int = 24;
      
      private static var instance:Variables;
      private static var creatingSingleton:Boolean=false;
      public function Variables() { }
      
      public function getInstance():Variables {
         if (!instance) {
            creatingSingleton=true;
            instance = new Variables();
            creatingSingleton=false;
         }
         return instance;
      }
   }
}