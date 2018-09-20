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
   
   import PolygonTest;
   import PointTest;
   import Grid;
   import Herramientas;
   import ToolTip;
   import gs.TweenLite;
   import gs.easing.*;
   import Estilos;
   import Variables;
   import CargarImagen;
   import AccionesButacas;
   import Coordenadas;
   import db.XML_Edit;
   
   public class sEditor extends MovieClip {
      public var But_Array:Array=[];
      public var arrayGraficos:Array=[];
      public var But_Acciones:AccionesButacas;
      public var Estado_But:String;
      public var Invertir_Numeracion:Boolean;
      public var Fila_Valor:String;
      public var Columna_Valor:String;
      public var Calidad_Valor:String;
      public var Fila_Pasos_Valor:String;
      public var Columna_Pasos_Valor:String;
      public var Angulo_Valor:int;
      public var My_Coord:Coordenadas;
      public var But_C_M_Form:Form_But_C_M;
      
      /* Mis variables Globales */
      public var My_Var_In_sEditor:Variables = new Variables();
      
      /* Mis Alertas */
      public var Alerta_RecintoBloq:Alerta_RecintoBloqueado;
      public var Alerta_Renomb:Renombrar;
      public var errorUpdate:Alerta_ErrorUpdate;
      public var myXML:XML;
      public var My_Imagen:CargarImagen;
      public var Recinto_Array_Cargar:Array=[];
      public var Recinto_Array_Cargar_Figuras:Array=[];
      public var vertex_Array_Cargar_Figuras:Array=[];
      public var Recinto_Array_Cargar_Figuras_Dise:Array;
      public var vertex_Array_Cargar_Figuras_Dise:Array;
      public var Cargar_Labels_Dise:Array;
      public var Cargar_Graficos_Dise:Array;
      public var Cargar_Labels:Array=[];
      public var Cargar_Graficos:Array=[];
      public var vertex_Array_Cargar:Array=[];
      public var Butacas_Array_Cargar:Array=[];

      /* Recinto */
      public var _Block:Block;
      public var Cliente_Array:Array=[];
      
      /* Herramientas */
      public var My_Xml:XML_Edit;
      public var Herramientas_Ppal:Herramientas;
      public var LegendColors:MovieClip;
      public var But_Inf_Globo:But_Inf;
      public var Seccion_Inf_Globo:Seccion_Inf;

      /* Layer principal */
      public var Board:Main_Board;
      public var Board_fondo:uint=0xFFFFFF;
      public var Board_Alpha:int=1;
      public var Board_Zoom_Point:Sprite;

      /* Layer Vista diseño */
      public var Board_Dise:MovieClip;
      public var Board_Dise_Zoom_Point:Sprite;
      public var Board_Dise_Array:Array=[];
      public var Board_Mini:MiniMap;
      public var thumb:Bitmap;
      public var _Est:Estilos;
      public var grid:Grid = null;
      public var m_grid:Grid = null;
      
      /* Variables para el Poligono */
      public var Polygon_Crear:Boolean=false;
      public var Polygon_Vertex:Array=[];
      public var Polygon_Vertex_Actual:Array=[];
      public var Polygon_Vertex_Eval:Array=[];
      public var Polygon_Objeto:*;
      public var Polygon_Marcado:*;
      public var Polygon_Crear_Temp:Sprite;
      public var Polygon_Crear_Temp_Color:uint=0xFF0000;
      public var Polygon_Crear_Temp_Alpha:int=1;
      public var Polygon_Crear_Temp_Ancho:int=1;
      public var Polygon_Crear_Temp_Point0:Boolean=false;
      public var Polygon_Move:Boolean=false;
      public var Polygon_Out:Boolean=false;
      public var Polygon_Renomb:Boolean=false;
      public var Polygon_Arreglo:Array=[];
      public var Polygon_Arreglo_Formas:Array=[];
      public var Polygon_Arreglo_Formas_Dise:Array;
      public var Label_Arreglo_Dise:Array;
      public var Graphic_Arreglo_Dise:Array;
      public var Label_Arreglo:Array=[];
      public var Graphic_Arreglo:Array=[];
      public var Polygon_Secciones:Array=[];
      public var Vertices_Array:Array=[];
      public var Butacas_Array:Array=[];
      public var Polygon_Marco:Sprite;
      public var metodo:Function;
      public var metodo1:Function;
      public var metodo2:Function;
      
      /* Butacas */
      public var N_Filas:int=10;
      public var N_Columnas:int=10;
      public var Angulo:int=0;
      public var Butacas_Arreglo:Array=[];
      public var Carrito:Sprite;
      public var Matriz:String="F";

      /* Variable Base de Datos */
      public var sEditor_DB:Array=[];
      public var Recinto_DB_Temp:SharedObject;
      public var Recinto_Inf:Array=[];
      
      /* Variables del Menu Contextual Polygono */
      public var Menu_Pol:ContextMenu = new ContextMenu;
      public var Menu_Pol_Renom:ContextMenuItem = new ContextMenuItem("Renombrar Sección");
      public var Menu_Pol_Editar:ContextMenuItem = new ContextMenuItem("Vértices Sección");
      public var Menu_Pol_Precio:ContextMenuItem = new ContextMenuItem("Precio Sección");
      public var Menu_Pol_Elim:ContextMenuItem = new ContextMenuItem("Eliminar Sección");
      
      /* Variables del Menu Contextual Forma */
      public var Menu_Pol_Formas:ContextMenu = new ContextMenu;
      public var Menu_Pol_Formas_Editar:ContextMenuItem = new ContextMenuItem("Vértices Objeto");
      public var Menu_Pol_Formas_Elim:ContextMenuItem = new ContextMenuItem("Eliminar Objeto");

      /* Variables del Menu Contextual Labels */
      public var Menu_Pol_Labels:ContextMenu = new ContextMenu;
      public var Menu_Pol_Labels_Elim:ContextMenuItem = new ContextMenuItem("Eliminar Objeto");
      
      /* Variables del Menu Contextual Graficos */
      public var Menu_Pol_Graphics:ContextMenu = new ContextMenu;
      public var Menu_Pol_Graphics_Elim:ContextMenuItem = new ContextMenuItem("Eliminar Objeto");
      
      /* Variables del Menu Contextual Board Dise */
      public var Menu_Board_Dise:ContextMenu;
      public var Menu_Board_Dise_Marcar_Todas:ContextMenuItem = new ContextMenuItem("Marcar Todas las Butacas");
      public var Menu_Board_Dise_Desmarcar:ContextMenuItem = new ContextMenuItem("Desmarcar Todas las Butacas");
      public var Menu_Board_Dise_Eliminar:ContextMenuItem = new ContextMenuItem("Eliminar Butacas Marcadas");
      public var Menu_Board_Dise_Propiedades:ContextMenuItem = new ContextMenuItem("Propiedades Butacas Marcadas");
      public var Metodo_But_Propiedades_no_dc:Function;
      public var Metodo_But_Propiedades_dc:Function;
      public var Metodo_But_Propiedades:Function;
      public var Eliminar_Butacas:Function;
      public var Metodo_Menu_Board_Dise_Desmarcar:Function;
      public var Metodo_Menu_Board_Dise_Marcar_Todas:Function;

      /* Información adicional de los botones de la barra principal */
      public var tooltip1:ToolTip;
      public var tooltip2:ToolTip;
      public var tooltip3:ToolTip;
      public var tooltip4:ToolTip;
      public var tooltip5:ToolTip;
      public var tooltip6:ToolTip;
      public var tooltip7:ToolTip;
      
      public var inputVarId:int;
      public var inputVarLocked:Boolean;
      public var inputVarTemplate:Boolean;
      public var inputVarBasePath:String;
      public var bloqueadoDesplazamientoVista:Boolean = true;
      public var bloqueadoDesplazamientoVistaDiseño:Boolean = true;
      public var recintoSalvado:Alerta_SalvarRecinto;
      public var errRecintoSalvarPrecio:Alerta_ErrorSalvarRecintoPrecio;
      public var errRecintoSalvar:Alerta_ErrorSalvarRecinto;
      public var seccionSalvada:Alerta_SalvarSeccion;
      public var errSeccionSalvarButacasFC:Alerta_ErrorSalvarSeccionButacasFC;
      public var errorPropiedades:Alerta_ErrorPropiedades;
      public var mouseIconPencil:Mouse_IconoLapiz = new Mouse_IconoLapiz();
      public var mouseIconText:Mouse_IconoTexto = new Mouse_IconoTexto();
      public var dadesDetallGuardades:Boolean = false;
      public var img_Mover:UILoader;
      public var btn_seccionVolver:Button;
      public var btn_seccionButaca:Button;
      public var btn_seccionButacas:Button;
      public var btn_seccionFormas:Button;
      public var btn_seccionTexto:Button;
      public var btn_seccionGrafico:Button;
      public var btn_seccionNumeracion:CheckBox;
      public var btn_seccionSalvar:Button;
      public var btn_seccionMover:Button;
      public var _Form_But_Propiedades:Form_But_Propiedades;
      public var _Block_But_Propiedades:Block;
      public var preciosDesc:Array;
      public var polygon_mouseOver:Boolean = false;
      public var mainInformation:Main_InformationBox;
      public var messageLimited:Boolean = true;
      public var formNewShape:Form_NewShape;
      public var formNewGraphic:Form_NewGraphic;
      public var formNewShape_rbgroup:RadioButtonGroup;
      public var Polygon_Count:int;
      public var Polygon_Count_Formas:int;
      public var Polygon_Count_Formas_Dise:int;
      public var Label_Count_Dise:int;
      public var Graphic_Count_Dise:int;
      public var Label_Count:int;
      public var Graphic_Count:int;
      public var formAtributosTexto:Form_Atributos_Texto;

      public function sEditor() {
         /* Parámetros de entrada -> Flash */ 
           var paramObj:Object = LoaderInfo(this.root.loaderInfo).parameters;
         inputVarId = paramObj["id"];
         
         if (inputVarId < 0) inputVarId = 0;
         
         if (paramObj["locked"] != 1) { inputVarLocked = false; My_Var_In_sEditor.getInstance().lockedRecinto = 0; }
         else { inputVarLocked = true; My_Var_In_sEditor.getInstance().lockedRecinto = 1; } 
         
         if (paramObj["template"] != 1) inputVarTemplate = false;
         else inputVarTemplate = true;
         
         inputVarBasePath = paramObj["base"];
         if (inputVarBasePath != null) {
              inputVarBasePath = paramObj["base"].toString();
            if (inputVarBasePath.length > 0) My_Var_In_sEditor.getInstance().HTTP_SEditor = inputVarBasePath + "sEditor/"
         }
         
         /* Ocultamos la barra de herramientas superior y los menus por defectos */
         fscommand("showmenu", "false");
         stage.showDefaultContextMenu = false;

         /* Información emergente de la sección */
         Seccion_Inf_Globo = new Seccion_Inf();
         addChild(Seccion_Inf_Globo);
         Seccion_Inf_Globo.visible = false;
         
         My_Coord= new Coordenadas();   
         myXML = new XML();

         _Block= new Block();
         _Block.name="Bloqueo";

         My_Xml=new XML_Edit(this);
         _Est=new Estilos();

         /* Creación del area de trabajo principal */
         Board=new Main_Board();
         Board.name="_Board";
         addChildAt(Board,0);
         Board.doubleClickEnabled=true;

         /* Creacion de la vista de detalle de una sección */
         Board_Dise = new MovieClip();
         Board_Dise.graphics.beginFill(Board_fondo, Board_Alpha);
         Board_Dise.graphics.drawRect(0,0,stage.stageWidth,stage.stageHeight);
         Board_Dise.name="Board_Diseño";
         Board_Dise.visible = false;
         addChild(Board_Dise);

         Board_Dise_Zoom_Point=new SpriteRegPoint("C");
         Board_Dise_Zoom_Point.addChild(Board_Dise);
         addChild(Board_Dise_Zoom_Point);
         Board_Dise_Zoom_Point.alpha = 0;

         var swfStage:Stage=Board.stage;
         swfStage.scaleMode=StageScaleMode.NO_SCALE;
         swfStage.align=StageAlign.TOP_LEFT;

         Herramientas_Ppal = new Herramientas(stage.stageWidth, stage.stageHeight, My_Var_In_sEditor);
         addChild(Herramientas_Ppal);
         Herramientas_Ppal.name="H";
         
         /* Preview Mapa */
         Board_Mini = new MiniMap();
         addChild(Board_Mini);
         Board_Mini.x = stage.stageWidth - Board_Mini.width - 7;
         Board_Mini.y = 7;
         Board_Mini.Mini_Pan.alpha = _Est.Herramientas_Mmapa_St()[1];
         
           Herramientas_Ppal.btn_Nuevo.addEventListener(MouseEvent.MOUSE_DOWN, New_Seccion);
         Herramientas_Ppal.btn_Formas.addEventListener(MouseEvent.MOUSE_DOWN, New_Shapes);
         Herramientas_Ppal.btn_Imagen.addEventListener(MouseEvent.MOUSE_DOWN, Recinto_Imagen);
         Herramientas_Ppal.btn_Salvar.addEventListener(MouseEvent.MOUSE_DOWN, Recinto_Salvar_XML);
         Herramientas_Ppal.btn_Mover.addEventListener(MouseEvent.MOUSE_DOWN, Recinto_Mover);
         Herramientas_Ppal.btn_Texto.addEventListener(MouseEvent.MOUSE_DOWN, New_Label);
         Herramientas_Ppal.btn_Grafico.addEventListener(MouseEvent.MOUSE_DOWN, New_Graphic);
         
         Herramientas_Ppal.btn_Nuevo.addEventListener(MouseEvent.MOUSE_OVER, Main_Buttons_Over);
         Herramientas_Ppal.btn_Nuevo.addEventListener(MouseEvent.MOUSE_OUT, Main_Buttons_Out);
         Herramientas_Ppal.btn_Imagen.addEventListener(MouseEvent.MOUSE_OVER, Main_Buttons_Over);
         Herramientas_Ppal.btn_Imagen.addEventListener(MouseEvent.MOUSE_OUT, Main_Buttons_Out);
         Herramientas_Ppal.btn_Salvar.addEventListener(MouseEvent.MOUSE_OVER, Main_Buttons_Over);
         Herramientas_Ppal.btn_Salvar.addEventListener(MouseEvent.MOUSE_OUT, Main_Buttons_Out);
         Herramientas_Ppal.btn_Mover.addEventListener(MouseEvent.MOUSE_OVER, Main_Buttons_Over);
         Herramientas_Ppal.btn_Mover.addEventListener(MouseEvent.MOUSE_OUT, Main_Buttons_Out);
         Herramientas_Ppal.btn_Formas.addEventListener(MouseEvent.MOUSE_OVER, Main_Buttons_Over);
         Herramientas_Ppal.btn_Formas.addEventListener(MouseEvent.MOUSE_OUT, Main_Buttons_Out);
         Herramientas_Ppal.btn_Texto.addEventListener(MouseEvent.MOUSE_OVER, Main_Buttons_Over);
         Herramientas_Ppal.btn_Texto.addEventListener(MouseEvent.MOUSE_OUT, Main_Buttons_Out);
         Herramientas_Ppal.btn_Grafico.addEventListener(MouseEvent.MOUSE_OVER, Main_Buttons_Over);
         Herramientas_Ppal.btn_Grafico.addEventListener(MouseEvent.MOUSE_OUT, Main_Buttons_Out);
         
         tooltip1 = new ToolTip(Herramientas_Ppal.btn_Nuevo, "Nueva Sección");
         tooltip2 = new ToolTip(Herramientas_Ppal.btn_Imagen, "Insertar Imagen");
         tooltip3 = new ToolTip(Herramientas_Ppal.btn_Mover, "Mover Recinto");
         tooltip4 = new ToolTip(Herramientas_Ppal.btn_Salvar, "Salvar Recinto");
         tooltip5 = new ToolTip(Herramientas_Ppal.btn_Formas, "Insertar Figura");
         tooltip6 = new ToolTip(Herramientas_Ppal.btn_Texto, "Insertar Etiqueta");
         tooltip7 = new ToolTip(Herramientas_Ppal.btn_Grafico, "Insertar Gráfico");

         /* Creación del menu contextual del polígono */
         Menu_Pol_Renom.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, Polygon_Renombrar);
         Menu_Pol_Editar.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, Polygon_Mostrar_Puntos);
         Menu_Pol_Precio.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, Polygon_Precio);
         Menu_Pol_Elim.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, Polygon_Eliminar);
         Menu_Pol.hideBuiltInItems();
         
         /* Creación del menu contextual de las formas */
         Menu_Pol_Formas_Editar.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, Polygon_Mostrar_Puntos);
         Menu_Pol_Formas_Elim.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, Polygon_Eliminar_Forma);
         Menu_Pol_Formas.hideBuiltInItems();
         
         /* Creación del menu contextual de los labels */
         var _Eliminar_Label:Function =  function(e:ContextMenuEvent) { Eliminar_Label(e, My_Var_In_sEditor.getInstance().Vista_Recinto); }
         Menu_Pol_Labels_Elim.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, _Eliminar_Label);
         Menu_Pol_Labels.hideBuiltInItems();
         
         /* Creación del menu contextual de los graficos */
         var _Eliminar_Grafico:Function =  function(e:ContextMenuEvent) { Eliminar_Grafico(e, My_Var_In_sEditor.getInstance().Vista_Recinto); }
         Menu_Pol_Graphics_Elim.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, _Eliminar_Grafico);
         Menu_Pol_Graphics.hideBuiltInItems();
         
         Menu_Pol.customItems.push(Menu_Pol_Renom);
         Menu_Pol.customItems.push(Menu_Pol_Editar);
         if (!inputVarTemplate) Menu_Pol.customItems.push(Menu_Pol_Precio);
         Menu_Pol.customItems.push(Menu_Pol_Elim);
         
         Menu_Pol_Formas.customItems.push(Menu_Pol_Formas_Editar);
         Menu_Pol_Formas.customItems.push(Menu_Pol_Formas_Elim);
         
         Menu_Pol_Labels.customItems.push(Menu_Pol_Labels_Elim);
         
         Menu_Pol_Graphics.customItems.push(Menu_Pol_Graphics_Elim);
         
         var Handle_keyboard_Down:Function =  function(e:KeyboardEvent) { Handle_keyboard(e, true); }
         var Handle_keyboard_Up:Function =  function(e:KeyboardEvent) { Handle_keyboard(e, false); }
         stage.addEventListener(KeyboardEvent.KEY_DOWN, Handle_keyboard_Down);
         stage.addEventListener(KeyboardEvent.KEY_UP, Handle_keyboard_Up);

         if (inputVarLocked) {
               Herramientas_Ppal.btn_Nuevo.visible = false;
            Herramientas_Ppal.btn_Formas.visible = false;
            Herramientas_Ppal.btn_Imagen.visible = false;
            //Herramientas_Ppal.btn_Salvar.visible = false;
            Herramientas_Ppal.btn_Texto.visible = false;
            Herramientas_Ppal.btn_Grafico.visible = false;
            Herramientas_Ppal.img_Nuevo.visible = false;
            Herramientas_Ppal.img_Formas.visible = false;
            Herramientas_Ppal.img_Imagen.visible = false;
            //Herramientas_Ppal.img_Salvar.visible = false;
            Herramientas_Ppal.img_Texto.visible = false;
            Herramientas_Ppal.img_Grafico.visible = false;
            
            Herramientas_Ppal.img_Mover.move(5, 8);
            Herramientas_Ppal.btn_Mover.x = 34;
            Herramientas_Ppal.btn_Salvar.move(34 + Herramientas_Ppal.btn_Mover.width + 52, 8);
            Herramientas_Ppal.img_Salvar.x = 34 + Herramientas_Ppal.btn_Mover.width + 20;
         }

         
         crearFormAtributosTexto(stage.stageWidth);
         formAtributosTexto.visible = false;
         crearEventosPropiedadesTexto(formAtributosTexto);
         
         /* Ejecutamos la función de php: entrada -> id, salida -> xml */
         loadXmlFromPhp(My_Var_In_sEditor.getInstance().HTTP_SEditor + "flash_loadXML.php", inputVarId);            
      }
      
      private function Handle_keyboard(e:KeyboardEvent, pressed:Boolean):void {   
         if (((e.ctrlKey == true) && (My_Var_In_sEditor.getInstance().ControlKey_Pressed == false)) || ((e.ctrlKey == false) && (My_Var_In_sEditor.getInstance().ControlKey_Pressed))) {
            if ((e.ctrlKey == true) && (My_Var_In_sEditor.getInstance().ControlKey_Pressed == false)) {
               My_Var_In_sEditor.getInstance().ControlKey_Pressed = true;
               if (((My_Var_In_sEditor.getInstance().Dibujando_Seccion == true) || (My_Var_In_sEditor.getInstance().Dibujando_Forma == true)) && (My_Var_In_sEditor.getInstance().Dibujando_Forma_Tipo == Variables.DIBUJAR_TIPO_LIBRE) && (Polygon_Vertex.length > 0)) {
                  crearLiniaRectaSecc(false, My_Var_In_sEditor.getInstance().Vista_Actual);
               }
               else if (((My_Var_In_sEditor.getInstance().Dibujando_Seccion == true) || (My_Var_In_sEditor.getInstance().Dibujando_Forma == true)) && (My_Var_In_sEditor.getInstance().Dibujando_Forma_Tipo == Variables.DIBUJAR_TIPO_RECTANGULO) && (Polygon_Vertex.length > 0)) {
                  crearRectanguloSecc(My_Var_In_sEditor.getInstance().Vista_Actual);
               }
            }
            else {
               My_Var_In_sEditor.getInstance().ControlKey_Pressed = false;
               if (((My_Var_In_sEditor.getInstance().Dibujando_Seccion == true) || (My_Var_In_sEditor.getInstance().Dibujando_Forma == true)) && (My_Var_In_sEditor.getInstance().Dibujando_Forma_Tipo == Variables.DIBUJAR_TIPO_LIBRE) && (Polygon_Vertex.length > 0)) {
                  crearLiniaRectaSecc(false, My_Var_In_sEditor.getInstance().Vista_Actual);
               }
               else if (((My_Var_In_sEditor.getInstance().Dibujando_Seccion == true) || (My_Var_In_sEditor.getInstance().Dibujando_Forma == true)) && (My_Var_In_sEditor.getInstance().Dibujando_Forma_Tipo == Variables.DIBUJAR_TIPO_RECTANGULO) && (Polygon_Vertex.length > 0)) {
                  crearRectanguloSecc(My_Var_In_sEditor.getInstance().Vista_Actual);
               }
            }
         }
         
         if (e.ctrlKey == true) My_Var_In_sEditor.getInstance().ControlKey_Pressed = true;
         else My_Var_In_sEditor.getInstance().ControlKey_Pressed = false;


         if (pressed) {
            if (My_Var_In_sEditor.getInstance().Escribir_Label) {
               if ((((My_Var_In_sEditor.getInstance().Label_Objeto_Seleccionado.parent.name != "_Board") || ((My_Var_In_sEditor.getInstance().Label_Objeto_Seleccionado.parent.name == "_Board") && (!(stage.focus is TextField)))) && (My_Var_In_sEditor.getInstance().Vista_Recinto)) ||
                   (((My_Var_In_sEditor.getInstance().Label_Objeto_Seleccionado.parent.name != "_Board_Dise") || ((My_Var_In_sEditor.getInstance().Label_Objeto_Seleccionado.parent.name == "_Board_Dise") && (!(stage.focus is TextField)))) && (My_Var_In_sEditor.getInstance().Vista_Recinto == false))) {
               
                 /* Máximo de carácteres */
                 if ((My_Var_In_sEditor.getInstance().Label_Objeto_Seleccionado.Objeto.text.length < Variables.LABEL_MAX_CHARACTERS) || ((My_Var_In_sEditor.getInstance().Label_Objeto_Seleccionado.Objeto.text.length == Variables.LABEL_MAX_CHARACTERS) && (e.keyCode == 8))) {
                    /* Aceptamos solo [ 0-9a-zA-Z ], [ backspace ], [ espacio ], [ -_ ] */ 
                    if (e.altKey == false) {
                       if ((e.keyCode == 8) || (e.keyCode == 32) || (e.keyCode == 45) || (e.keyCode == 95) || ((e.keyCode >= 65) && (e.keyCode <= 90)) || ((e.keyCode >= 97) && (e.keyCode <= 122)) || ((e.keyCode >= 48) && (e.keyCode <= 57))) {
                         /* No aceptamos los números con shift */
                         if ((e.shiftKey == false) || ((e.shiftKey == true) && ((e.keyCode < 48) || (e.keyCode > 57)))) {
                            if (e.keyCode != 8) {
                              if ((My_Var_In_sEditor.getInstance().Label_Objeto_Seleccionado.Objeto.text.length == 1) && (My_Var_In_sEditor.getInstance().Label_Objeto_Seleccionado.Objeto.text == " ")) {
                                 My_Var_In_sEditor.getInstance().Label_Objeto_Seleccionado.Objeto.text = String.fromCharCode(e.charCode);
                              }
                              else My_Var_In_sEditor.getInstance().Label_Objeto_Seleccionado.Objeto.text += String.fromCharCode(e.charCode); 
                            }
                            else {
                              My_Var_In_sEditor.getInstance().Label_Objeto_Seleccionado.Objeto.text = My_Var_In_sEditor.getInstance().Label_Objeto_Seleccionado.Objeto.text.substring(0, My_Var_In_sEditor.getInstance().Label_Objeto_Seleccionado.Objeto.text.length-1);
                              if (My_Var_In_sEditor.getInstance().Label_Objeto_Seleccionado.Objeto.text.length == 0) My_Var_In_sEditor.getInstance().Label_Objeto_Seleccionado.Objeto.text = " ";
                            }
                          }
                       }
                    }
                   }
               }
            }
         }
      }
      
      /* --> XML READER - PROCESO DE CARGA XML MEDIANTE BASE DE DATOS */
      public function loadXmlFromPhp(phpURLName:String, phpParam1:int) {     
         var request:URLRequest = new URLRequest(phpURLName);
         request.method = URLRequestMethod.POST;
                
         var vars:URLVariables = new URLVariables();
                
         vars.ident = phpParam1;           
         request.data = vars;
                
         var loader:URLLoader = new URLLoader (request);
         loader.dataFormat = URLLoaderDataFormat.TEXT;
         loader.addEventListener(Event.COMPLETE, onCompleteLoadXML);
         loader.load(request);
      }
      
      public function onCompleteLoadXML(event:Event):void{
         var output:URLVariables=new URLVariables(event.target.data);
         
         if (output.xmldb.length > 0) processXML(output.xmldb);
      } 
      /* --> END XML READER */
      
      private function New_Label_Dise(event:MouseEvent, indexSecc:int) {
         if (btn_seccionTexto.label == "Etiqueta") {
            btn_seccionTexto.label = "Terminar";
            My_Var_In_sEditor.getInstance().Insertar_Label = true;
            My_Var_In_sEditor.getInstance().Creando_Objeto = true;
            
            mouseIconText.mouseEnabled = false;
            addChild(mouseIconText);
         
            cambiarDiseEstadoBotones(false, btn_seccionTexto);
            mostrarMenusObjetos(false, false);
         }
         else {
            formAtributosTexto.visible = false;
            btn_seccionTexto.label = "Etiqueta";
            
            /* Si hay el flag de insertar => que no se ha hecho click sobre la pizarra => eliminar cursor manualmente */
            if (My_Var_In_sEditor.getInstance().Insertar_Label) {
               mouseIconText.x = 0;
               mouseIconText.y = 0;
               removeChild(mouseIconText);
               My_Var_In_sEditor.getInstance().Insertar_Label = false;
            }

            /* Los labels con texto vacio ... => Eliminar */
            if ((My_Var_In_sEditor.getInstance().Label_Objeto_Seleccionado != null) && (trim(My_Var_In_sEditor.getInstance().Label_Objeto_Seleccionado.Objeto.text).length > 0)) {  

               /* Introducimos los eventos de poder mover las etiquetas */
               My_Var_In_sEditor.getInstance().Label_Objeto_Seleccionado.Objeto.addEventListener(MouseEvent.MOUSE_MOVE, label_In);
               My_Var_In_sEditor.getInstance().Label_Objeto_Seleccionado.Objeto.addEventListener(MouseEvent.MOUSE_OUT, label_Out);
               
               My_Var_In_sEditor.getInstance().Label_Objeto_Seleccionado.Objeto.addEventListener(MouseEvent.MOUSE_DOWN, label_Drag);
               My_Var_In_sEditor.getInstance().Label_Objeto_Seleccionado.Objeto.addEventListener(MouseEvent.MOUSE_UP, label_Drop);
            
               My_Var_In_sEditor.getInstance().Label_Objeto_Seleccionado.contextMenu = Menu_Pol_Labels;
               Mini_Mapa_Crear();   
            
               resetearTextoPropiedades(false);
               dadesDetallGuardades = false;
            }
            else if (My_Var_In_sEditor.getInstance().Label_Objeto_Seleccionado != null) { Eliminar_LabelFromObject(false, My_Var_In_sEditor.getInstance().Label_Objeto_Seleccionado); resetearTextoPropiedades(false); }
            
            
            cambiarDiseEstadoBotones(true, btn_seccionTexto);
            mostrarMenusObjetos(false, true);
            My_Var_In_sEditor.getInstance().Creando_Objeto = false;
         }
      }
      
      private function New_Label(event:MouseEvent) {
         if (Herramientas_Ppal.btn_Texto.label == "Etiqueta") {
            Herramientas_Ppal.btn_Texto.label = "Terminar";
            My_Var_In_sEditor.getInstance().Insertar_Label = true;
            My_Var_In_sEditor.getInstance().Creando_Objeto = true;
            
            mouseIconText.mouseEnabled = false;
            addChild(mouseIconText);
         
            cambiarMainEstadoBotones(false, Herramientas_Ppal.btn_Texto);
            mostrarMenusObjetos(true, false);
         }
         else {
            formAtributosTexto.visible = false;
            Herramientas_Ppal.btn_Texto.label = "Etiqueta";
            
            /* Si hay el flag de insertar => que no se ha hecho click sobre la pizarra => eliminar cursor manualmente */
            if (My_Var_In_sEditor.getInstance().Insertar_Label) {
               mouseIconText.x = 0;
               mouseIconText.y = 0;
               removeChild(mouseIconText);
               My_Var_In_sEditor.getInstance().Insertar_Label = false;
            }
            
            /* Los labels con texto vacio ... => Eliminar */
            if ((My_Var_In_sEditor.getInstance().Label_Objeto_Seleccionado != null) && (trim(My_Var_In_sEditor.getInstance().Label_Objeto_Seleccionado.Objeto.text).length > 0)) {  

               /* Introducimos los eventos de poder mover las etiquetas */
               My_Var_In_sEditor.getInstance().Label_Objeto_Seleccionado.Objeto.addEventListener(MouseEvent.MOUSE_MOVE, label_In);
               My_Var_In_sEditor.getInstance().Label_Objeto_Seleccionado.Objeto.addEventListener(MouseEvent.MOUSE_OUT, label_Out);
               
               My_Var_In_sEditor.getInstance().Label_Objeto_Seleccionado.Objeto.addEventListener(MouseEvent.MOUSE_DOWN, label_Drag);
               My_Var_In_sEditor.getInstance().Label_Objeto_Seleccionado.Objeto.addEventListener(MouseEvent.MOUSE_UP, label_Drop);
            
               My_Var_In_sEditor.getInstance().Label_Objeto_Seleccionado.contextMenu = Menu_Pol_Labels;
               Mini_Mapa_Crear();   
            
               resetearTextoPropiedades(true);
            }
            else if (My_Var_In_sEditor.getInstance().Label_Objeto_Seleccionado != null) { Eliminar_LabelFromObject(true, My_Var_In_sEditor.getInstance().Label_Objeto_Seleccionado); resetearTextoPropiedades(true); }
            
            mostrarMenusObjetos(true, true);
            cambiarMainEstadoBotones(true, Herramientas_Ppal.btn_Texto);
            My_Var_In_sEditor.getInstance().Creando_Objeto = false;
         }
      }
      
      public function New_Shapes_Dise(event:MouseEvent, indexSecc:int) {
         if (btn_seccionFormas.label == "Figura") {
            My_Var_In_sEditor.getInstance().Creando_Objeto = true;
            crearVentanaForma(false, false);
         }
         else {
            removeChild(mouseIconPencil);
               
            btn_seccionFormas.label = "Figura";
            Board_Dise.removeChild(Polygon_Crear_Temp);
               
            if (Polygon_Vertex.length>2) {
               Polygon_Shape_Dibujar(false, My_Var_In_sEditor.getInstance().Vista_Actual, indexSecc);
               dadesDetallGuardades = false;
            } else {
               Polygon_Crear_Temp.graphics.clear();
               Polygon_Vertex = Polygon_Vertex.splice(Polygon_Vertex.length);
            }
            
            My_Var_In_sEditor.getInstance().Dibujando_Forma = false;
            My_Var_In_sEditor.getInstance().Dibujando_Seccion = false;
               
            cambiarDiseEstadoBotones(true, btn_seccionFormas);

            mostrarMenusObjetos(false, true);
            My_Var_In_sEditor.getInstance().Creando_Objeto = false;
         }
      }
      
      public function New_Shapes(event:MouseEvent) {
         if (Recinto_Inf.length != 0) {
            if (Herramientas_Ppal.btn_Formas.label == "Figura") {
               My_Var_In_sEditor.getInstance().Creando_Objeto = true;
               crearVentanaForma(true, false);
            } else {
               removeChild(mouseIconPencil);
               
               Herramientas_Ppal.btn_Formas.label = "Figura";
               Board.removeChild(Polygon_Crear_Temp);
               
               if (Polygon_Vertex.length>2) {
                  Polygon_Shape_Dibujar(true, My_Var_In_sEditor.getInstance().Vista_Actual, 0);
               } else {
                  Polygon_Crear_Temp.graphics.clear();
                  Polygon_Vertex = Polygon_Vertex.splice(Polygon_Vertex.length);
               }
               
               My_Var_In_sEditor.getInstance().Dibujando_Forma = false;
               My_Var_In_sEditor.getInstance().Dibujando_Seccion = false;
               
               cambiarMainEstadoBotones(true, Herramientas_Ppal.btn_Formas);
               if (My_Imagen != null) My_Imagen.enableContextMenu();
               
               mostrarMenusObjetos(true, true);
               Mini_Mapa_Crear();
               My_Var_In_sEditor.getInstance().Creando_Objeto = false;
            }
         }
      }
      
      public function New_Graphic_Dise(event:MouseEvent, indexSecc:int) {
         var _Block:Block = new Block();
         var grafico1:Grafico1 = new Grafico1();
         var grafico2:Grafico2 = new Grafico2();
         arrayGraficos = new Array();
         var i:int;
         
         My_Var_In_sEditor.getInstance().Insertando_Grafico = false;
         My_Var_In_sEditor.getInstance().Insertando_Grafico_Tipo = 0;
         cambiarDiseEstadoBotones(false);
         mostrarMenusObjetos(false, false);
         
         addChild(_Block);
         _Block.alpha = 0.9;
         formNewGraphic = new Form_NewGraphic();
         formNewGraphic.Err_NuevoGrafico_ElementoNoSelec.visible = false;
         formNewGraphic.Err_NuevoGrafico_RotacionNoNumerico.visible = false;
         formNewGraphic.Err_NuevoGrafico_AnchoAltoNoNumericoPositivo.visible = false; 
         
         addChild(formNewGraphic);
         formNewGraphic.x = (stage.stageWidth/2) - (formNewGraphic.width/2);
         formNewGraphic.y = (stage.stageHeight/2) - (formNewGraphic.height/2);
         
         formNewGraphic.txt_Rotacion.text = "0";
         formNewGraphic.txt_Ancho.text = String(Variables.DEFAULT_GRAFICO_ANCHO);
         formNewGraphic.txt_Alto.text = String(Variables.DEFAULT_GRAFICO_ALTO);
         
         formNewGraphic.Btn_Aceptar.addEventListener(MouseEvent.MOUSE_DOWN, ventanaGraficos_Aceptar);
         formNewGraphic.Btn_Cancelar.addEventListener(MouseEvent.MOUSE_DOWN, ventanaGraficos_Cancelar);
         
         /* Introducimos los gráficos a la lista - Aqui se introducen nuevos gráficos */
         arrayGraficos.push({icono: formNewGraphic.Fondo_Grafico1, grafico:grafico1});
         arrayGraficos.push({icono: formNewGraphic.Fondo_Grafico2, grafico:grafico2});
            
         for(i = 0; i < arrayGraficos.length; i++) {
            arrayGraficos[i].icono.addEventListener(MouseEvent.MOUSE_OVER, ventanaGraficos_FocusInGrafico);
            arrayGraficos[i].icono.addEventListener(MouseEvent.MOUSE_OUT, ventanaGraficos_FocusOutGrafico);
            arrayGraficos[i].icono.addEventListener(MouseEvent.MOUSE_DOWN, ventanaGraficos_ClickGrafico);         
         }

         function getPositionArrayGrafico(e:MouseEvent):int {
            return int(e.target.x / 60);
         }
         
         function ventanaGraficos_ClickGrafico(e:MouseEvent) {
            var vcolor:ColorTransform = transform.colorTransform;
            vcolor.color = 0xFFFFFF;
            
            My_Var_In_sEditor.getInstance().Insertando_Grafico_Tipo = getPositionArrayGrafico(e) + 1;
             for (var i:int = 0; i < arrayGraficos.length; i++) {
               if (i != getPositionArrayGrafico(e)) arrayGraficos[i].icono.transform.colorTransform = vcolor;
            }
         }
         
         function ventanaGraficos_FocusInGrafico(e:MouseEvent) {
            getPositionArrayGrafico(e);
            var vcolor:ColorTransform = transform.colorTransform;
            vcolor.color = 0xCBFFDB;
            arrayGraficos[getPositionArrayGrafico(e)].icono.transform.colorTransform = vcolor;
            Mouse.cursor = MouseCursor.BUTTON;
         }
         
         function ventanaGraficos_FocusOutGrafico(e:MouseEvent) {
            var vcolor:ColorTransform = transform.colorTransform;
            vcolor.color = 0xFFFFFF;
            
            if (My_Var_In_sEditor.getInstance().Insertando_Grafico_Tipo != getPositionArrayGrafico(e) + 1) arrayGraficos[getPositionArrayGrafico(e)].icono.transform.colorTransform = vcolor;
            Mouse.cursor = MouseCursor.ARROW;
         }

         function ventanaGraficos_Aceptar(e:MouseEvent) {
            var obj:Object;
            formNewGraphic.Err_NuevoGrafico_ElementoNoSelec.visible = false;
            formNewGraphic.Err_NuevoGrafico_RotacionNoNumerico.visible = false;
            formNewGraphic.Err_NuevoGrafico_AnchoAltoNoNumericoPositivo.visible = false; 
         
            if (My_Var_In_sEditor.getInstance().Insertando_Grafico_Tipo != 0) {
               if ((formNewGraphic.txt_Rotacion.text.length > 0) && (!isNaN(Number(formNewGraphic.txt_Rotacion.text)))) {
                  if (((formNewGraphic.txt_Ancho.text.length > 0) && (!isNaN(Number(formNewGraphic.txt_Ancho.text))) && (int(formNewGraphic.txt_Ancho.text) > 0)) && ((formNewGraphic.txt_Alto.text.length > 0) && (!isNaN(Number(formNewGraphic.txt_Alto.text))) && (int(formNewGraphic.txt_Alto.text) > 0))) {
                     My_Var_In_sEditor.getInstance().Insertando_Grafico = true;
                     My_Var_In_sEditor.getInstance().Insertando_Grafico_Rotacion = int(formNewGraphic.txt_Rotacion.text);
                     My_Var_In_sEditor.getInstance().Insertando_Grafico_Altura = int(formNewGraphic.txt_Alto.text);
                     My_Var_In_sEditor.getInstance().Insertando_Grafico_Anchura = int(formNewGraphic.txt_Ancho.text);
                     My_Var_In_sEditor.getInstance().Creando_Objeto = true;
                     
                     if (My_Var_In_sEditor.getInstance().Insertando_Grafico_Rotacion >= 0)  My_Var_In_sEditor.getInstance().Insertando_Grafico_Rotacion = (Math.abs(My_Var_In_sEditor.getInstance().Insertando_Grafico_Rotacion) % 360);
                     else My_Var_In_sEditor.getInstance().Insertando_Grafico_Rotacion = -(Math.abs(My_Var_In_sEditor.getInstance().Insertando_Grafico_Rotacion) % 360);
                     
                     obj = arrayGraficos[My_Var_In_sEditor.getInstance().Insertando_Grafico_Tipo - 1].grafico;
                     
                     Board_Dise.addChild(DisplayObject(obj));
                     
                     obj.width = int(formNewGraphic.txt_Ancho.text);
                     obj.height = int(formNewGraphic.txt_Alto.text);
                     obj.x = Board_Dise.mouseX;
                     obj.y = Board_Dise.mouseY;
                     obj.rotationZ = -My_Var_In_sEditor.getInstance().Insertando_Grafico_Rotacion;
                     
                     removeChild(formNewGraphic);
                     removeChild(_Block);
                  }
                  else formNewGraphic.Err_NuevoGrafico_AnchoAltoNoNumericoPositivo.visible = true; 
               }
               else formNewGraphic.Err_NuevoGrafico_RotacionNoNumerico.visible = true;
            }
            else formNewGraphic.Err_NuevoGrafico_ElementoNoSelec.visible = true;
         }
         
         function ventanaGraficos_Cancelar(e:MouseEvent) {
            cambiarDiseEstadoBotones(true);
            mostrarMenusObjetos(false, true);
                  
            removeChild(formNewGraphic);
            removeChild(_Block);
         }   
      }
      
      public function New_Graphic(event:MouseEvent) {
         var _Block:Block = new Block();
         var grafico1:Grafico1 = new Grafico1();
         var grafico2:Grafico2 = new Grafico2();
         arrayGraficos = new Array();
         var i:int;
         
         My_Var_In_sEditor.getInstance().Insertando_Grafico = false;
         My_Var_In_sEditor.getInstance().Insertando_Grafico_Tipo = 0;
         cambiarMainEstadoBotones(false);
         mostrarMenusObjetos(true, false);
         
         addChild(_Block);
         _Block.alpha = 0.9;
         formNewGraphic = new Form_NewGraphic();
         formNewGraphic.Err_NuevoGrafico_ElementoNoSelec.visible = false;
         formNewGraphic.Err_NuevoGrafico_RotacionNoNumerico.visible = false;
         formNewGraphic.Err_NuevoGrafico_AnchoAltoNoNumericoPositivo.visible = false; 
         
         addChild(formNewGraphic);
         formNewGraphic.x = (stage.stageWidth/2) - (formNewGraphic.width/2);
         formNewGraphic.y = (stage.stageHeight/2) - (formNewGraphic.height/2);
         
         formNewGraphic.txt_Rotacion.text = "0";
         formNewGraphic.txt_Ancho.text = String(Variables.DEFAULT_GRAFICO_ANCHO);
         formNewGraphic.txt_Alto.text = String(Variables.DEFAULT_GRAFICO_ALTO);
         
         formNewGraphic.Btn_Aceptar.addEventListener(MouseEvent.MOUSE_DOWN, ventanaGraficos_Aceptar);
         formNewGraphic.Btn_Cancelar.addEventListener(MouseEvent.MOUSE_DOWN, ventanaGraficos_Cancelar);
         
         /* Introducimos los gráficos a la lista - Aqui se introducen nuevos gráficos */
         arrayGraficos.push({icono: formNewGraphic.Fondo_Grafico1, grafico:grafico1});
         arrayGraficos.push({icono: formNewGraphic.Fondo_Grafico2, grafico:grafico2});
            
         for(i = 0; i < arrayGraficos.length; i++) {
            arrayGraficos[i].icono.addEventListener(MouseEvent.MOUSE_OVER, ventanaGraficos_FocusInGrafico);
            arrayGraficos[i].icono.addEventListener(MouseEvent.MOUSE_OUT, ventanaGraficos_FocusOutGrafico);
            arrayGraficos[i].icono.addEventListener(MouseEvent.MOUSE_DOWN, ventanaGraficos_ClickGrafico);         
         }
         
         function getPositionArrayGrafico(e:MouseEvent):int {
            return int(e.target.x / 60);
         }
         
         function ventanaGraficos_ClickGrafico(e:MouseEvent) {
            var vcolor:ColorTransform = transform.colorTransform;
            vcolor.color = 0xFFFFFF;
            
            My_Var_In_sEditor.getInstance().Insertando_Grafico_Tipo = getPositionArrayGrafico(e) + 1;
             for (var i:int = 0; i < arrayGraficos.length; i++) {
               if (i != getPositionArrayGrafico(e)) arrayGraficos[i].icono.transform.colorTransform = vcolor;
            }         
         }
         
         function ventanaGraficos_FocusInGrafico(e:MouseEvent) {
            getPositionArrayGrafico(e);
            var vcolor:ColorTransform = transform.colorTransform;
            vcolor.color = 0xCBFFDB;
            arrayGraficos[getPositionArrayGrafico(e)].icono.transform.colorTransform = vcolor;
            Mouse.cursor = MouseCursor.BUTTON;
         }
         
         function ventanaGraficos_FocusOutGrafico(e:MouseEvent) {
            var vcolor:ColorTransform = transform.colorTransform;
            vcolor.color = 0xFFFFFF;
            
            if (My_Var_In_sEditor.getInstance().Insertando_Grafico_Tipo != getPositionArrayGrafico(e) + 1) arrayGraficos[getPositionArrayGrafico(e)].icono.transform.colorTransform = vcolor;
            Mouse.cursor = MouseCursor.ARROW;
         }
         
         function ventanaGraficos_Aceptar(e:MouseEvent) {
            var obj:Object;
            formNewGraphic.Err_NuevoGrafico_ElementoNoSelec.visible = false;
            formNewGraphic.Err_NuevoGrafico_RotacionNoNumerico.visible = false;
            formNewGraphic.Err_NuevoGrafico_AnchoAltoNoNumericoPositivo.visible = false; 
         
            if (My_Var_In_sEditor.getInstance().Insertando_Grafico_Tipo != 0) {
               if ((formNewGraphic.txt_Rotacion.text.length > 0) && (!isNaN(Number(formNewGraphic.txt_Rotacion.text)))) {
                  if (((formNewGraphic.txt_Ancho.text.length > 0) && (!isNaN(Number(formNewGraphic.txt_Ancho.text))) && (int(formNewGraphic.txt_Ancho.text) > 0)) && ((formNewGraphic.txt_Alto.text.length > 0) && (!isNaN(Number(formNewGraphic.txt_Alto.text))) && (int(formNewGraphic.txt_Alto.text) > 0))) {
                     My_Var_In_sEditor.getInstance().Insertando_Grafico = true;
                     My_Var_In_sEditor.getInstance().Insertando_Grafico_Rotacion = int(formNewGraphic.txt_Rotacion.text);
                     My_Var_In_sEditor.getInstance().Insertando_Grafico_Altura = int(formNewGraphic.txt_Alto.text);
                     My_Var_In_sEditor.getInstance().Insertando_Grafico_Anchura = int(formNewGraphic.txt_Ancho.text);                     
                     My_Var_In_sEditor.getInstance().Creando_Objeto = true;
                     
                     if (My_Var_In_sEditor.getInstance().Insertando_Grafico_Rotacion >= 0)  My_Var_In_sEditor.getInstance().Insertando_Grafico_Rotacion = (Math.abs(My_Var_In_sEditor.getInstance().Insertando_Grafico_Rotacion) % 360);
                     else My_Var_In_sEditor.getInstance().Insertando_Grafico_Rotacion = -(Math.abs(My_Var_In_sEditor.getInstance().Insertando_Grafico_Rotacion) % 360);
                     
                     obj = arrayGraficos[My_Var_In_sEditor.getInstance().Insertando_Grafico_Tipo - 1].grafico;
                     Board.addChild(DisplayObject(obj));
                     
                     obj.width = int(formNewGraphic.txt_Ancho.text);
                     obj.height = int(formNewGraphic.txt_Alto.text);
                     obj.x = Board.mouseX;
                     obj.y = Board.mouseY;
                     obj.rotationZ = -My_Var_In_sEditor.getInstance().Insertando_Grafico_Rotacion;
                     
                     removeChild(formNewGraphic);
                     removeChild(_Block);
                  }
                  else formNewGraphic.Err_NuevoGrafico_AnchoAltoNoNumericoPositivo.visible = true; 
               }
               else formNewGraphic.Err_NuevoGrafico_RotacionNoNumerico.visible = true;
            }
            else formNewGraphic.Err_NuevoGrafico_ElementoNoSelec.visible = true;
         }
         
         function ventanaGraficos_Cancelar(e:MouseEvent) {
            cambiarMainEstadoBotones(true);
            mostrarMenusObjetos(true, true);
                  
            removeChild(formNewGraphic);
            removeChild(_Block);
         }      
      }
      
      public function New_Seccion(event:MouseEvent) {
         if (Recinto_Inf.length != 0) {
            if (Herramientas_Ppal.btn_Nuevo.label == "Nueva Sec.") {
               crearVentanaForma(true, true);
            } else {
               Mouse.show();
               removeChild(mouseIconPencil);
               
               Herramientas_Ppal.btn_Nuevo.label = "Nueva Sec.";
               Board.removeChild(Polygon_Crear_Temp);

               if (Polygon_Vertex.length>2) {
                  if (!inputVarTemplate) introducirPrecioDesc(Number(Polygon_Dibujar().Polygon_But_Precio));
                  else Polygon_Dibujar();
               } else {
                  Polygon_Crear_Temp.graphics.clear();
                  Polygon_Vertex = Polygon_Vertex.splice(Polygon_Vertex.length);
               }
               
               My_Var_In_sEditor.getInstance().Dibujando_Forma = false;
               My_Var_In_sEditor.getInstance().Dibujando_Seccion = false;
               
               cambiarMainEstadoBotones(true, Herramientas_Ppal.btn_Nuevo);
               if (My_Imagen != null) My_Imagen.enableContextMenu();
               
               mostrarMenusObjetos(true, true);
               
               Mini_Mapa_Crear();
               actualize_mainInformation();
            }
         }
      }

      /* @Evento llamado cuando se selecciona el botón de crear nueva sección o nueva forma */
      public function crearVentanaForma(mainWindow:Boolean, seccion:Boolean):void {
         var _Block:Block = new Block();
         addChild(_Block);
         _Block.alpha = 0.9;
         formNewShape = new Form_NewShape();
         formNewShape.Err_NuevaSecc_ElementoVacio.visible = false;
         
         addChild(formNewShape);
         formNewShape.x = (stage.stageWidth/2) - (formNewShape.width/2);
         formNewShape.y = (stage.stageHeight/2) - (formNewShape.height/2);
         
         formNewShape_rbgroup = new RadioButtonGroup("rb_grp");
         formNewShape.rb_rectangle.label = "Rectángulo";
         formNewShape.rb_free.label = "Mano Alzada";
         
         formNewShape.rb_rectangle.group = formNewShape_rbgroup;
         formNewShape.rb_free.group = formNewShape_rbgroup;
         
         formNewShape.Btn_Aceptar.addEventListener(MouseEvent.MOUSE_DOWN, crearVentanaForma_Aceptar);
         formNewShape.Btn_Cancelar.addEventListener(MouseEvent.MOUSE_DOWN, crearVentanaForma_Cancelar);
      
         function crearVentanaForma_Aceptar(e:MouseEvent) {
            formNewShape.Err_NuevaSecc_ElementoVacio.visible = false;
            
            if ((formNewShape.rb_rectangle.selected) || (formNewShape.rb_free.selected)) {
               mouseIconPencil.mouseEnabled = false;
               addChild(mouseIconPencil);
               
               if (mainWindow) {
                  if (seccion) Herramientas_Ppal.btn_Nuevo.label = "Terminar Sec."
                  else Herramientas_Ppal.btn_Formas.label = "Terminar"
               }
               else {
                  btn_seccionFormas.label = "Terminar"
               }
               
               onSecc(mainWindow);
               if (seccion) My_Var_In_sEditor.getInstance().Dibujando_Seccion = true;
               else My_Var_In_sEditor.getInstance().Dibujando_Forma = true;
               
               if (formNewShape.rb_rectangle.selected) My_Var_In_sEditor.getInstance().Dibujando_Forma_Tipo = Variables.DIBUJAR_TIPO_RECTANGULO;
               else if (formNewShape.rb_free.selected) My_Var_In_sEditor.getInstance().Dibujando_Forma_Tipo = Variables.DIBUJAR_TIPO_LIBRE;
               
               if (mainWindow) {
                  if (seccion) cambiarMainEstadoBotones(false, Herramientas_Ppal.btn_Nuevo);
                  else cambiarMainEstadoBotones(false, Herramientas_Ppal.btn_Formas);
                  mostrarMenusObjetos(true, false);
               }
               else {
                  cambiarDiseEstadoBotones(false, btn_seccionFormas);
                  mostrarMenusObjetos(false, false);
               }
               
               if (My_Imagen != null) My_Imagen.disableContextMenu();
               
               removeChild(formNewShape);
               removeChild(_Block);
            }
            else {
               formNewShape.Err_NuevaSecc_ElementoVacio.visible = true;
            }
         }      

         function crearVentanaForma_Cancelar(e:MouseEvent) {
            removeChild(formNewShape);
            removeChild(_Block);
         }
      }

      public function Main_Buttons_Over(event:MouseEvent) { Mouse.cursor = MouseCursor.BUTTON; }
      
      public function Main_Buttons_Out(event:MouseEvent) { 
         if ((My_Var_In_sEditor.getInstance().Dibujando_Seccion == false) && (My_Var_In_sEditor.getInstance().Dibujando_Forma == false)) {
            Mouse.cursor = MouseCursor.ARROW; 
         }
         else {
            Mouse.cursor = MouseCursor.ARROW;
         }
      }
      
      public function Section_Buttons_Over(event:MouseEvent) { Mouse.cursor = MouseCursor.BUTTON; }
      public function Section_Buttons_Out(event:MouseEvent) { Mouse.cursor = MouseCursor.ARROW; }
      
      public function Recinto_Mover(event:MouseEvent) {
         var k:int;
         
         if (bloqueadoDesplazamientoVista) {
            Herramientas_Ppal.desplazarVistaImagen(true, My_Var_In_sEditor);
            
            Mouse.cursor = MouseCursor.HAND;
            My_Var_In_sEditor.getInstance().Mover_Recinto = true;
            
            bloqueadoDesplazamientoVista = false;
            cambiarMainEstadoBotones(false, Herramientas_Ppal.btn_Mover);
                               
            if (My_Imagen != null) My_Imagen.disableContextMenu();
            
            if (!inputVarLocked) { mostrarMenusObjetos(true, false); }
         }
         else {
            Board.stopDrag(); 
            Herramientas_Ppal.desplazarVistaImagen(false, My_Var_In_sEditor);
            
            Mouse.cursor = MouseCursor.ARROW;
             My_Var_In_sEditor.getInstance().Mover_Recinto = false;
            
            bloqueadoDesplazamientoVista = true;
            cambiarMainEstadoBotones(true, Herramientas_Ppal.btn_Mover);
            if (My_Imagen != null) My_Imagen.enableContextMenu();
            
            if (!inputVarLocked) { mostrarMenusObjetos(true, true); }
         }
      }
      
      public function Recinto_Imagen(event:MouseEvent):void {
         if (Recinto_Inf.length != 0) { My_Imagen = new CargarImagen(Board); Mini_Mapa_Crear(); }
      }
      
      public function onSecc(mainWindow:Boolean) {
         if (Polygon_Crear_Temp) {
            Polygon_Crear_Temp.graphics.clear();
            Polygon_Vertex=Polygon_Vertex.splice(Polygon_Vertex.length);
         }
         Polygon_Crear = true;
         Polygon_Vertex = new Array();

         Polygon_Crear_Temp = new Sprite();
         Polygon_Crear_Temp.graphics.lineStyle(Polygon_Crear_Temp_Ancho,Polygon_Crear_Temp_Color,Polygon_Crear_Temp_Alpha);
         if (mainWindow) Board.addChild(Polygon_Crear_Temp);
         else Board_Dise.addChild(Polygon_Crear_Temp);
         Polygon_Crear_Temp_Point0 = true;
      }
      
      public function Board_DOUBLECLICK(e:MouseEvent) {
         /* Oculta los puntos de todos los Polígonos */
         My_Var_In_sEditor.getInstance().Editando_Pol = false;
         
         for (var i:int=0; i<Polygon_Arreglo.length; i++) {
            Polygon_M_O_Point(Polygon_Arreglo[i], false);
         }
         for (var k:int=0; k<Polygon_Arreglo_Formas.length; k++) {
            Polygon_M_O_Point(Polygon_Arreglo_Formas[k], false);
         }
      }

      public function Board_Dise_DOUBLECLICK(e:MouseEvent) {
         /* Oculta los puntos de todos los Polígonos */
         My_Var_In_sEditor.getInstance().Editando_Pol = false;
         
         for (var k:int=0; k<Polygon_Arreglo_Formas_Dise.length; k++) {
            Polygon_M_O_Point(Polygon_Arreglo_Formas_Dise[k], false);
         }
      }
      
      private function Board_Dise_DOWN(e:MouseEvent) {
         if (bloqueadoDesplazamientoVistaDiseño == false) Board_Dise.startDrag();
         else { 
            if ((My_Var_In_sEditor.getInstance().Dibujando_Forma == true) && (My_Var_In_sEditor.getInstance().Dibujando_Forma_Tipo == Variables.DIBUJAR_TIPO_RECTANGULO) && (Polygon_Vertex.length == 0)) {
               Polygon_Vertex.push({name:"", x:Board_Dise.mouseX, y:Board_Dise.mouseY});
            }
         }
      }
      
      private function Board_DOWN(e:MouseEvent) {
         if (bloqueadoDesplazamientoVista == false) Board.startDrag();
         else {
            if (((My_Var_In_sEditor.getInstance().Dibujando_Seccion == true) || (My_Var_In_sEditor.getInstance().Dibujando_Forma == true)) && (My_Var_In_sEditor.getInstance().Dibujando_Forma_Tipo == Variables.DIBUJAR_TIPO_RECTANGULO) && (Polygon_Vertex.length == 0)) {
               Polygon_Vertex.push({name:"", x:Board.mouseX, y:Board.mouseY});
            }         
         }
      }
      
      private function Board_Dise_UP(e:MouseEvent, indexSecc:int) {
         var valueX:int;
         var valueY:int;
         var minValue:int;
         
         Board_Dise.stopDrag();
         
         if ((My_Var_In_sEditor.getInstance().Dibujando_Forma == true) && (My_Var_In_sEditor.getInstance().Dibujando_Forma_Tipo == Variables.DIBUJAR_TIPO_RECTANGULO) && (Polygon_Vertex.length > 0)) {
            if (My_Var_In_sEditor.getInstance().ControlKey_Pressed) {
               minValue = Math.abs(Board_Dise.mouseX - Polygon_Vertex[0].x);
               if (minValue > Math.abs(Board_Dise.mouseY - Polygon_Vertex[0].y)) {
                  valueY = Board_Dise.mouseY - Polygon_Vertex[0].y;
                  if ((Board_Dise.mouseX - Polygon_Vertex[0].x) >= 0) valueX = Math.abs(valueY);
                  else valueX = -Math.abs(valueY);
               }
               else { 
                  valueX = Board_Dise.mouseX - Polygon_Vertex[0].x;
                  if ((Board_Dise.mouseY - Polygon_Vertex[0].y) >= 0) valueY = Math.abs(valueX);
                  else valueY = -Math.abs(valueX);
               }

               /* Introducimos solo el polígono si cumple un tamaño mínimo */
               if (minValue >= Variables.DISTANCIA_VERTICES_MIN_POLIGONOS) {
                  Polygon_Vertex.push({name:"", x:Polygon_Vertex[0].x + valueX, y:Polygon_Vertex[0].y});
                  Polygon_Vertex.push({name:"", x:Polygon_Vertex[0].x + valueX, y:Polygon_Vertex[0].y + valueY});
                  Polygon_Vertex.push({name:"", x:Polygon_Vertex[0].x, y:Polygon_Vertex[0].y + valueY});
               }
               else Polygon_Vertex.pop();
               New_Shapes_Dise(e, indexSecc);
            }
            else {
               /* Introducimos solo el polígono si cumple un tamaño mínimo */
               if ((Math.abs(Board_Dise.mouseX - Polygon_Vertex[0].x) >= Variables.DISTANCIA_VERTICES_MIN_POLIGONOS) || (Math.abs(Board_Dise.mouseY - Polygon_Vertex[0].y) >= Variables.DISTANCIA_VERTICES_MIN_POLIGONOS)) {
                  Polygon_Vertex.push({name:"", x:Board_Dise.mouseX, y:Polygon_Vertex[0].y});
                  Polygon_Vertex.push({name:"", x:Board_Dise.mouseX, y:Board_Dise.mouseY});
                  Polygon_Vertex.push({name:"", x:Polygon_Vertex[0].x, y:Board_Dise.mouseY});
               }
               else Polygon_Vertex.pop();
               New_Shapes_Dise(e, indexSecc);
            }            
         }   
      }
      
      private function Board_UP(e:MouseEvent) {
         var valueX:int;
         var valueY:int;
         var minValue:int;
         
         Board.stopDrag();
         Mini_Mapa_Crear();
         
         if (((My_Var_In_sEditor.getInstance().Dibujando_Seccion == true) || (My_Var_In_sEditor.getInstance().Dibujando_Forma == true)) && (My_Var_In_sEditor.getInstance().Dibujando_Forma_Tipo == Variables.DIBUJAR_TIPO_RECTANGULO) && (Polygon_Vertex.length > 0)) {
            if (My_Var_In_sEditor.getInstance().ControlKey_Pressed) {
               minValue = Math.abs(Board.mouseX - Polygon_Vertex[0].x);
               if (minValue > Math.abs(Board.mouseY - Polygon_Vertex[0].y)) {
                  valueY = Board.mouseY - Polygon_Vertex[0].y;
                  if ((Board.mouseX - Polygon_Vertex[0].x) >= 0) valueX = Math.abs(valueY);
                  else valueX = -Math.abs(valueY);
               }
               else { 
                  valueX = Board.mouseX - Polygon_Vertex[0].x;
                  if ((Board.mouseY - Polygon_Vertex[0].y) >= 0) valueY = Math.abs(valueX);
                  else valueY = -Math.abs(valueX);
               }

               /* Introducimos solo el polígono si cumple un tamaño mínimo */
               if (minValue >= Variables.DISTANCIA_VERTICES_MIN_POLIGONOS) {
                  Polygon_Vertex.push({name:"", x:Polygon_Vertex[0].x + valueX, y:Polygon_Vertex[0].y});
                  Polygon_Vertex.push({name:"", x:Polygon_Vertex[0].x + valueX, y:Polygon_Vertex[0].y + valueY});
                  Polygon_Vertex.push({name:"", x:Polygon_Vertex[0].x, y:Polygon_Vertex[0].y + valueY});
               }
               else Polygon_Vertex.pop();
               if (My_Var_In_sEditor.getInstance().Dibujando_Seccion) New_Seccion(e);
               else New_Shapes(e);
            }
            else {
               /* Introducimos solo el polígono si cumple un tamaño mínimo */
               if ((Math.abs(Board.mouseX - Polygon_Vertex[0].x) >= Variables.DISTANCIA_VERTICES_MIN_POLIGONOS) || (Math.abs(Board.mouseY - Polygon_Vertex[0].y) >= Variables.DISTANCIA_VERTICES_MIN_POLIGONOS)) {
                  Polygon_Vertex.push({name:"", x:Board.mouseX, y:Polygon_Vertex[0].y});
                  Polygon_Vertex.push({name:"", x:Board.mouseX, y:Board.mouseY});
                  Polygon_Vertex.push({name:"", x:Polygon_Vertex[0].x, y:Board.mouseY});
               }
               else Polygon_Vertex.pop();
               if (My_Var_In_sEditor.getInstance().Dibujando_Seccion) New_Seccion(e);
               else New_Shapes(e);
            }            
         }   
      }
      
      private function Board_Dise_CLICK(e:MouseEvent) {
         if (My_Var_In_sEditor.getInstance().Marcar_Butaca == false) {
            if ((My_Var_In_sEditor.getInstance().Dibujando_Forma == true) && (My_Var_In_sEditor.getInstance().Dibujando_Forma_Tipo == Variables.DIBUJAR_TIPO_LIBRE)) {
               if (Polygon_Crear==true&&Polygon_Crear_Temp_Point0==true) {
                  Polygon_Vertex.push({name:"", x:Board_Dise.mouseX, y:Board_Dise.mouseY});
                  Polygon_Crear_Temp_Point0=false;
               } else if (Polygon_Crear==true && Polygon_Crear_Temp_Point0==false) {
                  if (!My_Var_In_sEditor.getInstance().ControlKey_Pressed) Polygon_Vertex.push({name:"", x:Board_Dise.mouseX, y:Board_Dise.mouseY});
                  crearLiniaRectaSecc(My_Var_In_sEditor.getInstance().ControlKey_Pressed, My_Var_In_sEditor.getInstance().Vista_Actual);
               }
            }

            if (My_Var_In_sEditor.getInstance().Insertar_Label) {
               mouseIconText.x = 0;
               mouseIconText.y = 0;
               removeChild(mouseIconText);
            
               My_Var_In_sEditor.getInstance().Insertar_Label = false;
               My_Var_In_sEditor.getInstance().Escribir_Label = true;
               
               /* Creamos el label */
               var objLabel:Texto = new Texto();
               Label_Count_Dise++;
               
               objLabel.Objeto.autoSize = TextFieldAutoSize.LEFT;
               
               objLabel.x = Board_Dise.mouseX;
               objLabel.y = Board_Dise.mouseY;
               objLabel.Objeto.text = " ";
               objLabel.Objeto.textField.border = true;
               objLabel.Objeto.textField.borderColor = 0x000000;
               objLabel.Objeto.height = Variables.DEFAULT_LABEL_SIZE * 1.3;
               
               objLabel.atr_id = Label_Count_Dise;
               objLabel.atr_idRec = Recinto_Inf[0].Id;
               objLabel.atr_nombre = "@-" + getMaxID_LabelName(Label_Arreglo_Dise);
               objLabel.name = objLabel.atr_nombre;
               objLabel.atr_fontName = Variables.DEFAULT_LABEL_FONT;
               objLabel.atr_fontSize = Variables.DEFAULT_LABEL_SIZE;
               objLabel.atr_bold = int(Variables.DEFAULT_LABEL_BOLD);
               objLabel.atr_italic = int(Variables.DEFAULT_LABEL_ITALIC);
               objLabel.atr_color = Variables.DEFAULT_LABEL_COLOR;
               objLabel.atr_rotate = 0;
               objLabel.Objeto.setStyle("textFormat", _Est.Format_defaultLabelFormat());
                                                
               Board_Dise.addChild(objLabel);
               My_Var_In_sEditor.getInstance().Label_Objeto_Seleccionado = objLabel;
               
               Label_Arreglo_Dise.push(objLabel);
               
               mostrarPropiedadesTexto(formAtributosTexto);
            }
            
            if (My_Var_In_sEditor.getInstance().Insertando_Grafico) {
               var objGraphic:Object;
               
               Graphic_Count_Dise++;
               objGraphic = arrayGraficos[My_Var_In_sEditor.getInstance().Insertando_Grafico_Tipo - 1].grafico;
               
               objGraphic.x = Board_Dise.mouseX;
               objGraphic.y = Board_Dise.mouseY;
               //objGraphic.height = My_Var_In_sEditor.getInstance().Insertando_Grafico_Altura;
               //objGraphic.width = My_Var_In_sEditor.getInstance().Insertando_Grafico_Anchura;
               objGraphic.atr_id = Graphic_Count_Dise;
               objGraphic.atr_idRec = Recinto_Inf[0].Id;
               objGraphic.atr_nombre = "@-" + getMaxID_GraphicName(Graphic_Arreglo_Dise);
               objGraphic.name = objGraphic.atr_nombre;
               objGraphic.atr_rotate = My_Var_In_sEditor.getInstance().Insertando_Grafico_Rotacion;
               objGraphic.atr_tipo = My_Var_In_sEditor.getInstance().Insertando_Grafico_Tipo;
               objGraphic.contextMenu = Menu_Pol_Graphics;
               
               objGraphic.addEventListener(MouseEvent.MOUSE_MOVE, graphic_In);
               objGraphic.addEventListener(MouseEvent.MOUSE_OUT, graphic_Out);
               
               objGraphic.addEventListener(MouseEvent.MOUSE_DOWN, graphic_Drag);
               objGraphic.addEventListener(MouseEvent.MOUSE_UP, graphic_Drop);
               
               Graphic_Arreglo_Dise.push(objGraphic);
               
               cambiarDiseEstadoBotones(true);
               mostrarMenusObjetos(false, true);
                     
               My_Var_In_sEditor.getInstance().Insertando_Grafico = false;
               My_Var_In_sEditor.getInstance().Insertando_Grafico_Tipo = 0;
               My_Var_In_sEditor.getInstance().Insertando_Grafico_Rotacion = 0;
               My_Var_In_sEditor.getInstance().Creando_Objeto = false;
               dadesDetallGuardades = false;
            }
         }
      }
      
      private function Board_CLICK(e:MouseEvent) {
         if (My_Var_In_sEditor.getInstance().Marcar_Butaca == false) {
            if (((My_Var_In_sEditor.getInstance().Dibujando_Seccion == true) || (My_Var_In_sEditor.getInstance().Dibujando_Forma == true)) && (My_Var_In_sEditor.getInstance().Dibujando_Forma_Tipo == Variables.DIBUJAR_TIPO_LIBRE)) {
               if (Polygon_Crear==true&&Polygon_Crear_Temp_Point0==true) {
                  Polygon_Vertex.push({name:"", x:Board.mouseX, y:Board.mouseY});
                  Polygon_Crear_Temp_Point0=false;
               } else if (Polygon_Crear==true && Polygon_Crear_Temp_Point0==false) {
                  if (!My_Var_In_sEditor.getInstance().ControlKey_Pressed) Polygon_Vertex.push({name:"", x:Board.mouseX, y:Board.mouseY});
                  crearLiniaRectaSecc(My_Var_In_sEditor.getInstance().ControlKey_Pressed, My_Var_In_sEditor.getInstance().Vista_Actual);
               }
            }
            
            if (My_Var_In_sEditor.getInstance().Insertar_Label) {
               mouseIconText.x = 0;
               mouseIconText.y = 0;
               removeChild(mouseIconText);
            
               My_Var_In_sEditor.getInstance().Insertar_Label = false;
               My_Var_In_sEditor.getInstance().Escribir_Label = true;
               
               /* Creamos el label */
               var objLabel:Texto = new Texto();
               Label_Count++;
               
               objLabel.Objeto.autoSize = TextFieldAutoSize.LEFT;
               
               objLabel.x = Board.mouseX;
               objLabel.y = Board.mouseY;
               objLabel.Objeto.text = " ";
               objLabel.Objeto.textField.border = true;
               objLabel.Objeto.textField.borderColor = 0x000000;
               objLabel.Objeto.height = Variables.DEFAULT_LABEL_SIZE * 1.3;
               
               objLabel.atr_id = Label_Count;
               objLabel.atr_idRec = Recinto_Inf[0].Id;
               objLabel.atr_nombre = "@-" + getMaxID_LabelName(Label_Arreglo);
               objLabel.name = objLabel.atr_nombre;
               objLabel.atr_fontName = Variables.DEFAULT_LABEL_FONT;
               objLabel.atr_fontSize = Variables.DEFAULT_LABEL_SIZE;
               objLabel.atr_bold = int(Variables.DEFAULT_LABEL_BOLD);
               objLabel.atr_italic = int(Variables.DEFAULT_LABEL_ITALIC);
               objLabel.atr_color = Variables.DEFAULT_LABEL_COLOR;
               objLabel.atr_rotate = 0;
               objLabel.Objeto.setStyle("textFormat", _Est.Format_defaultLabelFormat());
                                                
               Board.addChild(objLabel);
               My_Var_In_sEditor.getInstance().Label_Objeto_Seleccionado = objLabel;
               
               Label_Arreglo.push(objLabel);
               
               mostrarPropiedadesTexto(formAtributosTexto);
            }
            
            if (My_Var_In_sEditor.getInstance().Insertando_Grafico) {
               var objGraphic:Object;
               
               Graphic_Count++;
               objGraphic = arrayGraficos[My_Var_In_sEditor.getInstance().Insertando_Grafico_Tipo - 1].grafico;
               
               objGraphic.x = Board.mouseX;
               objGraphic.y = Board.mouseY;
               //objGraphic.height = My_Var_In_sEditor.getInstance().Insertando_Grafico_Altura;
               //objGraphic.width = My_Var_In_sEditor.getInstance().Insertando_Grafico_Anchura;
               objGraphic.atr_id = Graphic_Count;
               objGraphic.atr_idRec = Recinto_Inf[0].Id;
               objGraphic.atr_nombre = "@-" + getMaxID_GraphicName(Graphic_Arreglo);
               objGraphic.name = objGraphic.atr_nombre;
               objGraphic.atr_rotate = My_Var_In_sEditor.getInstance().Insertando_Grafico_Rotacion;
               objGraphic.atr_tipo = My_Var_In_sEditor.getInstance().Insertando_Grafico_Tipo;
               objGraphic.contextMenu = Menu_Pol_Graphics;
               
               objGraphic.addEventListener(MouseEvent.MOUSE_MOVE, graphic_In);
               objGraphic.addEventListener(MouseEvent.MOUSE_OUT, graphic_Out);
               
               objGraphic.addEventListener(MouseEvent.MOUSE_DOWN, graphic_Drag);
               objGraphic.addEventListener(MouseEvent.MOUSE_UP, graphic_Drop);
               
               Graphic_Arreglo.push(objGraphic);

               cambiarMainEstadoBotones(true);
               mostrarMenusObjetos(true, true);
                     
               My_Var_In_sEditor.getInstance().Insertando_Grafico = false;
               My_Var_In_sEditor.getInstance().Insertando_Grafico_Tipo = 0;
               My_Var_In_sEditor.getInstance().Insertando_Grafico_Rotacion = 0;
               My_Var_In_sEditor.getInstance().Creando_Objeto = false;
            }
         }
      }
      
      public function Board_Dise_Mov_Mouse(e:MouseEvent) {
         var obj:Object;
         
         mouseIconPencil.x = stage.mouseX;
         mouseIconPencil.y = stage.mouseY;
         
         if (My_Var_In_sEditor.getInstance().Insertar_Label) {
            mouseIconText.x = stage.mouseX;
            mouseIconText.y = stage.mouseY;
         }

         if (My_Var_In_sEditor.getInstance().Insertando_Grafico) {
            obj = arrayGraficos[My_Var_In_sEditor.getInstance().Insertando_Grafico_Tipo - 1].grafico;
            obj.x = Board_Dise.mouseX;
            obj.y = Board_Dise.mouseY;
         }
         
         if (((My_Var_In_sEditor.getInstance().Dibujando_Seccion == true) || (My_Var_In_sEditor.getInstance().Dibujando_Forma == true)) && (My_Var_In_sEditor.getInstance().Dibujando_Forma_Tipo == Variables.DIBUJAR_TIPO_RECTANGULO) && (Polygon_Vertex.length > 0)) crearRectanguloSecc(My_Var_In_sEditor.getInstance().Vista_Actual);
         
         if (((My_Var_In_sEditor.getInstance().Dibujando_Seccion == true) || (My_Var_In_sEditor.getInstance().Dibujando_Forma == true)) && (My_Var_In_sEditor.getInstance().Dibujando_Forma_Tipo == Variables.DIBUJAR_TIPO_LIBRE) && (Polygon_Vertex.length > 0)) crearLiniaRectaSecc(false, My_Var_In_sEditor.getInstance().Vista_Actual);
      }
      
      public function Board_Mov_Mouse(e:MouseEvent) {
         var obj:Object;
         
         mouseIconPencil.x = stage.mouseX;
         mouseIconPencil.y = stage.mouseY;
         
         if (My_Var_In_sEditor.getInstance().Insertar_Label) {
            mouseIconText.x = stage.mouseX;
            mouseIconText.y = stage.mouseY;
         }
         
         if (My_Var_In_sEditor.getInstance().Mover_Recinto) Mouse.cursor = MouseCursor.HAND;
         
         if (My_Var_In_sEditor.getInstance().Insertando_Grafico) {
            obj = arrayGraficos[My_Var_In_sEditor.getInstance().Insertando_Grafico_Tipo - 1].grafico;
            obj.x = Board.mouseX;
            obj.y = Board.mouseY;
         }
         
         if (((My_Var_In_sEditor.getInstance().Dibujando_Seccion == true) || (My_Var_In_sEditor.getInstance().Dibujando_Forma == true)) && (My_Var_In_sEditor.getInstance().Dibujando_Forma_Tipo == Variables.DIBUJAR_TIPO_RECTANGULO) && (Polygon_Vertex.length > 0)) crearRectanguloSecc(My_Var_In_sEditor.getInstance().Vista_Actual);
         
         if (((My_Var_In_sEditor.getInstance().Dibujando_Seccion == true) || (My_Var_In_sEditor.getInstance().Dibujando_Forma == true)) && (My_Var_In_sEditor.getInstance().Dibujando_Forma_Tipo == Variables.DIBUJAR_TIPO_LIBRE) && (Polygon_Vertex.length > 0)) crearLiniaRectaSecc(false, My_Var_In_sEditor.getInstance().Vista_Actual);
      }
      
      private function redibujarPoligono() {
         var i:int;
         
         Polygon_Crear_Temp.graphics.lineStyle(Polygon_Crear_Temp_Ancho,Polygon_Crear_Temp_Color,Polygon_Crear_Temp_Alpha);
         if (Polygon_Vertex.length > 1) {
            Polygon_Crear_Temp.graphics.moveTo(Polygon_Vertex[0].x, Polygon_Vertex[0].y);
            for(i = 1; i < Polygon_Vertex.length; i++) {
               Polygon_Crear_Temp.graphics.lineTo(Polygon_Vertex[i].x,Polygon_Vertex[i].y);
            }
         }
      }
      
      private function getGrados(radianes:Number) { return ((radianes * 180)/Math.PI); }
      
      private function crearLiniaRectaSecc(pushVertex:Boolean, Board:Object) {
         var valueX:int;
         var valueY:int;
         var dif:int;
         var incX:int;
         var incY:int;
         var grados:Number;
         var valueXGrad:int;
         var valueYGrad:int;
         
         if (My_Var_In_sEditor.getInstance().ControlKey_Pressed) {
            Polygon_Crear_Temp.graphics.clear();
            redibujarPoligono();
            
            valueXGrad = Board.mouseX - Polygon_Vertex[Polygon_Vertex.length - 1].x;
            valueYGrad = Polygon_Vertex[Polygon_Vertex.length - 1].y - Board.mouseY;
            valueX = Math.abs(Board.mouseX - Polygon_Vertex[Polygon_Vertex.length - 1].x);
            valueY = Math.abs(Board.mouseY - Polygon_Vertex[Polygon_Vertex.length - 1].y);
            grados = 0;
            
            if (valueXGrad == 0) valueXGrad = 1;
            if ((valueXGrad > 0) && (valueYGrad >= 0)) { grados = getGrados(Math.atan(valueYGrad/valueXGrad)); }
            else if (valueXGrad < 0) { grados = 180 + getGrados(Math.atan(valueYGrad/valueXGrad)); }
            else if ((valueXGrad > 0) && (valueYGrad < 0)) { grados = 360 + getGrados(Math.atan(valueYGrad/valueXGrad)); }
            
            /* 1er caso -> entre (375.5º a 22.5º) o (157.5º a 202.5º) -> linia recta horizontal */
            if (((grados >= 337.5) || (grados <= 22.5)) || ((grados >= 157.5) && (grados <= 202.5))) {
               Polygon_Crear_Temp.graphics.moveTo(Polygon_Vertex[Polygon_Vertex.length - 1].x, Polygon_Vertex[Polygon_Vertex.length - 1].y);
               Polygon_Crear_Temp.graphics.lineTo(Polygon_Vertex[Polygon_Vertex.length - 1].x + (Board.mouseX - Polygon_Vertex[Polygon_Vertex.length - 1].x), Polygon_Vertex[Polygon_Vertex.length - 1].y);
               Polygon_Crear_Temp.graphics.beginFill(_Est.Polygonos_St()[3],1);
               Polygon_Crear_Temp.graphics.drawCircle(Polygon_Vertex[Polygon_Vertex.length - 1].x + (Board.mouseX - Polygon_Vertex[Polygon_Vertex.length - 1].x), Polygon_Vertex[Polygon_Vertex.length - 1].y, 2.5);
               Polygon_Crear_Temp.graphics.endFill();
               if (pushVertex) Polygon_Vertex.push({name:"", x:Polygon_Vertex[Polygon_Vertex.length - 1].x + (Board.mouseX - Polygon_Vertex[Polygon_Vertex.length - 1].x), y:Polygon_Vertex[Polygon_Vertex.length - 1].y});    
            }
            /* 2do caso -> entre (22.5º a 67.5º) o (112.5º a 157.5º) o (202.5º a 247.5º) o (292.5º a 337.5º) -> linia inclinada */
            else if (((grados >= 22.5) && (grados <= 67.5)) || ((grados >= 112.5) && (grados <= 157.5)) || ((grados >= 202.5) && (grados <= 247.5)) || ((grados >= 292.5) && (grados <= 337.5))) {
               dif = Math.abs(valueX - valueY);
               if (valueX == valueY) { incX = 0; incY = 0; }
               else if (valueX > valueY) {
                  incX = 0;
                  incY = dif;
                  if ((Board.mouseY - Polygon_Vertex[Polygon_Vertex.length - 1].y) < 0) incY *= -1; 
               }
               else {
                  incX = dif;
                  incY = 0;
                  if ((Board.mouseX - Polygon_Vertex[Polygon_Vertex.length - 1].x) < 0) incX *= -1; 
               }
               Polygon_Crear_Temp.graphics.moveTo(Polygon_Vertex[Polygon_Vertex.length - 1].x, Polygon_Vertex[Polygon_Vertex.length - 1].y);
               Polygon_Crear_Temp.graphics.lineTo(Polygon_Vertex[Polygon_Vertex.length - 1].x + (Board.mouseX - Polygon_Vertex[Polygon_Vertex.length - 1].x) + incX, Polygon_Vertex[Polygon_Vertex.length - 1].y + (Board.mouseY - Polygon_Vertex[Polygon_Vertex.length - 1].y) + incY);
               Polygon_Crear_Temp.graphics.beginFill(_Est.Polygonos_St()[3],1);
               Polygon_Crear_Temp.graphics.drawCircle(Polygon_Vertex[Polygon_Vertex.length - 1].x + (Board.mouseX - Polygon_Vertex[Polygon_Vertex.length - 1].x) + incX, Polygon_Vertex[Polygon_Vertex.length - 1].y + (Board.mouseY - Polygon_Vertex[Polygon_Vertex.length - 1].y) + incY, 2.5);
               Polygon_Crear_Temp.graphics.endFill();                  
               if (pushVertex) {
                  Polygon_Vertex.push({name:"", x:Polygon_Vertex[Polygon_Vertex.length - 1].x + (Board.mouseX - Polygon_Vertex[Polygon_Vertex.length - 1].x) + incX, y:Polygon_Vertex[Polygon_Vertex.length - 1].y + (Board.mouseY - Polygon_Vertex[Polygon_Vertex.length - 1].y) + incY});
               }
            }
            /* 3er caso -> entre (67.5º a 112.5º) o (247.5 a 292.5) -> linia recta vertical */
            else if (((grados >= 67.5) && (grados <= 112.5)) || ((grados >= 247.5) && (grados <= 292.5))) {
               Polygon_Crear_Temp.graphics.moveTo(Polygon_Vertex[Polygon_Vertex.length - 1].x, Polygon_Vertex[Polygon_Vertex.length - 1].y);
               Polygon_Crear_Temp.graphics.lineTo(Polygon_Vertex[Polygon_Vertex.length - 1].x, Polygon_Vertex[Polygon_Vertex.length - 1].y + (Board.mouseY - Polygon_Vertex[Polygon_Vertex.length - 1].y));            
               Polygon_Crear_Temp.graphics.beginFill(_Est.Polygonos_St()[3],1);
               Polygon_Crear_Temp.graphics.drawCircle(Polygon_Vertex[Polygon_Vertex.length - 1].x, Polygon_Vertex[Polygon_Vertex.length - 1].y + (Board.mouseY - Polygon_Vertex[Polygon_Vertex.length - 1].y), 2.5);
               Polygon_Crear_Temp.graphics.endFill();               
               if (pushVertex) Polygon_Vertex.push({name:"", x:Polygon_Vertex[Polygon_Vertex.length - 1].x, y:Polygon_Vertex[Polygon_Vertex.length - 1].y + (Board.mouseY - Polygon_Vertex[Polygon_Vertex.length - 1].y)});
            }
         }
         else {
            Polygon_Crear_Temp.graphics.clear();
            redibujarPoligono();         
         }
      }
      
      private function crearRectanguloSecc(Board:Object) {
         var valueX:int;
         var valueY:int;
         var minValue:int;
         
         Polygon_Crear_Temp.graphics.clear();
         Polygon_Crear_Temp.graphics.lineStyle(Polygon_Crear_Temp_Ancho,Polygon_Crear_Temp_Color,Polygon_Crear_Temp_Alpha);
         
         if (My_Var_In_sEditor.getInstance().ControlKey_Pressed) {
            minValue = Math.abs(Board.mouseX - Polygon_Vertex[0].x);
            if (minValue > Math.abs(Board.mouseY - Polygon_Vertex[0].y)) {
               minValue = Math.abs(Board.mouseY - Polygon_Vertex[0].y);
               valueY = Board.mouseY - Polygon_Vertex[0].y;
               if ((Board.mouseX - Polygon_Vertex[0].x) >= 0) valueX = Math.abs(valueY);
               else valueX = -Math.abs(valueY);
            }
            else { 
               valueX = Board.mouseX - Polygon_Vertex[0].x;
               if ((Board.mouseY - Polygon_Vertex[0].y) >= 0) valueY = Math.abs(valueX);
               else valueY = -Math.abs(valueX);
            }
            
            Polygon_Crear_Temp.graphics.moveTo(Polygon_Vertex[0].x, Polygon_Vertex[0].y);
            Polygon_Crear_Temp.graphics.lineTo(Polygon_Vertex[0].x + valueX, Polygon_Vertex[0].y);
            Polygon_Crear_Temp.graphics.lineTo(Polygon_Vertex[0].x + valueX, Polygon_Vertex[0].y + valueY);
            Polygon_Crear_Temp.graphics.lineTo(Polygon_Vertex[0].x, Polygon_Vertex[0].y + valueY);
            Polygon_Crear_Temp.graphics.lineTo(Polygon_Vertex[0].x, Polygon_Vertex[0].y);   
         }
         else {
            Polygon_Crear_Temp.graphics.moveTo(Polygon_Vertex[0].x, Polygon_Vertex[0].y);
            Polygon_Crear_Temp.graphics.lineTo(Board.mouseX, Polygon_Vertex[0].y);
            Polygon_Crear_Temp.graphics.lineTo(Board.mouseX, Board.mouseY);
            Polygon_Crear_Temp.graphics.lineTo(Polygon_Vertex[0].x, Board.mouseY);
            Polygon_Crear_Temp.graphics.lineTo(Polygon_Vertex[0].x, Polygon_Vertex[0].y);   
         }
      }

      public function Secc_Nom_Act(Nombre_Out:String, Nombre_Inp:String) {
         var index:int;

         for (var j:int=0; j<Polygon_Arreglo.length; j++) {
            if (Polygon_Arreglo[j].name==Nombre_Out) {
               index=j;
               Polygon_Arreglo[j].name=Nombre_Inp;
               Polygon_Arreglo[j].getChildAt(Polygon_Arreglo[j].getChildIndex(Polygon_Arreglo[j].getChildByName("Etiqueta"))).text=Nombre_Inp;
               Polygon_Arreglo[j].getChildAt(Polygon_Arreglo[j].getChildIndex(Polygon_Arreglo[j].getChildByName("Etiqueta"))).width=Nombre_Inp.length*30;

               for (var XML_Renomb:int=0; XML_Renomb<myXML.Recinto[0].Secciones[0].children().length(); XML_Renomb++) {
                  if (myXML.Recinto[0].Secciones[0].Seccion[XML_Renomb].@id_Secc==Polygon_Arreglo[j].Polygon_Nombre_Array[0].id) {
                     myXML.Recinto[0].Secciones[0].Seccion[XML_Renomb].@Nombre=Nombre_Inp;
                  }
               }
            }
         }
         for (var i:int=0; i<Polygon_Secciones.length; i++) {
            if (Polygon_Secciones[i].label==Nombre_Out) {
               Polygon_Secciones[i].label=Nombre_Inp;
            }
         }
         if (Polygon_Arreglo[index].Polygon_Act_Mod==true) {
            for (var A:int=1; A<Polygon_Arreglo[index].getChildAt(Polygon_Arreglo[index].numChildren-1).numChildren; A++) {
               Polygon_Arreglo[index].getChildAt(Polygon_Arreglo[index].numChildren-1).getChildAt(A).Butaca_Seccion=Polygon_Arreglo[index].name;
            }
         }
      }

      public function Polygon_Dibujar(Polygon_Nombre_Inp:String=null, Importado:String=null):Object {
         if (Polygon_Crear == true) {
            var Polygon_Nombre:String;
            if (Polygon_Nombre_Inp!=null) {
               Polygon_Count++;
               Polygon_Nombre=Polygon_Nombre_Inp;
            } else {
               Polygon_Count++;
               Polygon_Nombre="S-" + getMaxID_PolygonName(Polygon_Arreglo);
            }
            Polygon_Objeto = new PolygonTest(Polygon_Vertex,Polygon_Nombre, My_Var_In_sEditor, inputVarLocked);
            Polygon_Objeto.name = Polygon_Nombre;
            Polygon_Objeto.Polygon_Vertex_Array = Polygon_Vertex;
            Polygon_Objeto.Polygon_Recinto_Array.push({Id:Recinto_Inf[0].Id, Nombre:Recinto_Inf[0].Nombre});
            Polygon_Objeto.Polygon_Posicion_Array.push({x:Polygon_Objeto.x, y:Polygon_Objeto.y });
            Board.addChild(Polygon_Objeto);
            Vertices_Array.push({objeto:Polygon_Vertex});

            Polygon_Secciones.push({label:Polygon_Nombre});
            Polygon_Objeto.doubleClickEnabled = true;
            Polygon_Objeto.Polygon_Id=Polygon_Nombre;
            Polygon_Arreglo.push(Polygon_Objeto);
            Polygon_Objeto.Polygon_Nombre_Array.push({nombre:Polygon_Nombre, id:Polygon_Count});
            Polygon_Vertex=Polygon_Vertex.splice(Polygon_Vertex.length);
            Polygon_Objeto.addEventListener(MouseEvent.MOUSE_OVER, Polygon_inForm);
            Polygon_Objeto.addEventListener(MouseEvent.MOUSE_OUT, Polygon_outForm);
            
            if (!inputVarLocked) {
               Polygon_Objeto.addEventListener(MouseEvent.MOUSE_DOWN, Seccion_Move);
               Polygon_Objeto.addEventListener(MouseEvent.MOUSE_UP, Seccion_Stop);
            }
            
            if (Importado==null) {
               Polygon_Objeto.Polygon_But_Precio = "0.00";
               Polygon_Objeto.Polygon_Num_Inv = false;
               myXML=My_Xml.Insert_Secc(Polygon_Objeto,myXML);
            }

            Polygon_M_O_Point(Polygon_Objeto, false);

            if (!inputVarLocked) Polygon_Objeto.contextMenu = Menu_Pol;
            
            /* Debemos actualizar la sección cargadas inicialmente XML */
            if (Importado != null) {
               
               for(var k:int = 0; k < myXML.Recinto[0].Secciones[0].children().length(); k++) {
                  if (myXML.Recinto[0].Secciones[0].Seccion[k].@Nombre == Polygon_Nombre) {
                     myXML.Recinto[0].Secciones[0].Seccion[k].@id_Secc = Polygon_Objeto.Polygon_Nombre_Array[0].id;
                     
                     /* Actualizamos las butacas */
                     for (var l:int = 0; l < myXML.Recinto[0].Secciones[0].Seccion[k].Butacas[0].children().length(); l++) {
                         myXML.Recinto[0].Secciones[0].Seccion[k].Butacas[0]._Butaca[l].@id_Secc = Polygon_Objeto.Polygon_Nombre_Array[0].id;
                     }
                  }
               }
            }
            
            Polygon_Crear_Temp.graphics.clear();
            Polygon_Crear_Temp_Point0=true;
            Polygon_Crear=false;
            return Polygon_Objeto;
         }
         return null;
      }
      
      private function getMaxID_LabelName(array:Array):int {
         var id:int;
         id = 0;
         
         for(var i:int = 0; i < array.length; i++) {
            if ((array[i].atr_nombre.split("-")[0] == "@") && (!isNaN(Number(array[i].atr_nombre.split("-")[1])))) {
               if (int(array[i].atr_nombre.split("-")[1]) > id) id = int(array[i].atr_nombre.split("-")[1]);
            }
         }
         
         return id + 1;
      }
      
      private function getMaxID_GraphicName(array:Array):int {
         var id:int;
         id = 0;
         
         for(var i:int = 0; i < array.length; i++) {
            if ((array[i].atr_nombre.split("-")[0] == "@") && (!isNaN(Number(array[i].atr_nombre.split("-")[1])))) {
               if (int(array[i].atr_nombre.split("-")[1]) > id) id = int(array[i].atr_nombre.split("-")[1]);
            }
         }
         
         return id + 1;
      }
      
      
      private function getMaxID_PolygonName(array:Array):int {
         var id:int;
         id = 0;
         
         for(var i:int = 0; i < array.length; i++) {
            if (((array[i].Polygon_Nombre_Array[0].nombre.split("-")[0] == "S") || (array[i].Polygon_Nombre_Array[0].nombre.split("-")[0] == "@")) && (!isNaN(Number(array[i].Polygon_Nombre_Array[0].nombre.split("-")[1])))) {
               if (int(array[i].Polygon_Nombre_Array[0].nombre.split("-")[1]) > id) id = int(array[i].Polygon_Nombre_Array[0].nombre.split("-")[1]);
            }
         }
         
         return id + 1;
      }
      
      public function Polygon_Shape_Dibujar(mainWindow:Boolean, Board:Object, indexSecc:int, Polygon_Nombre_Inp:String=null, Importado:String = null):Object {
         var indexSeccXML:int;
         var k:int;
         
         if (Polygon_Crear == true) {
            var Polygon_Nombre:String;
            if (Polygon_Nombre_Inp!=null) {
               if (mainWindow) Polygon_Count_Formas++;
               else Polygon_Count_Formas_Dise++;
               
               Polygon_Nombre = Polygon_Nombre_Inp;
            } else {
               if (mainWindow) { 
                  Polygon_Count_Formas++;
                  Polygon_Nombre="@-" + getMaxID_PolygonName(Polygon_Arreglo_Formas);
               }
               else {
                  Polygon_Count_Formas_Dise++;
                  Polygon_Nombre="@-" + getMaxID_PolygonName(Polygon_Arreglo_Formas_Dise);
               }      
            }
            
            Polygon_Objeto = new PolygonTest(Polygon_Vertex, "", My_Var_In_sEditor, inputVarLocked, false);
            Polygon_Objeto.name = Polygon_Nombre;
            Polygon_Objeto.Polygon_Vertex_Array = Polygon_Vertex;
            Polygon_Objeto.Polygon_Recinto_Array.push({Id:Recinto_Inf[0].Id, Nombre:Recinto_Inf[0].Nombre});
            Polygon_Objeto.Polygon_Posicion_Array.push({x:Polygon_Objeto.x, y:Polygon_Objeto.y });
            Board.addChild(Polygon_Objeto);
            Vertices_Array.push({objeto:Polygon_Vertex});
            
            if (mainWindow) Polygon_Arreglo_Formas.push(Polygon_Objeto);
            else Polygon_Arreglo_Formas_Dise.push(Polygon_Objeto);
            
            Polygon_Objeto.Polygon_Id = Polygon_Nombre;
            if (mainWindow) Polygon_Objeto.Polygon_Nombre_Array.push({nombre:Polygon_Nombre, id:Polygon_Count_Formas});
            else Polygon_Objeto.Polygon_Nombre_Array.push({nombre:Polygon_Nombre, id:Polygon_Count_Formas_Dise});
            
            Polygon_Vertex = Polygon_Vertex.splice(Polygon_Vertex.length);
            
            var func_overObject:Function = function(e:MouseEvent) { 
               if (permitirMoverObjetos(true)) {
                  if (!inputVarLocked) Mouse.cursor = MouseCursor.HAND;
               }
               else Mouse.cursor = MouseCursor.ARROW;
            }
            var func_outObject:Function = function(e:MouseEvent) { Mouse.cursor = MouseCursor.ARROW; Polygon_Objeto.drawLines(_Est.Format_ColoresPoligonos()[0]); }
            Polygon_Objeto.addEventListener(MouseEvent.MOUSE_OVER, func_overObject);
            Polygon_Objeto.addEventListener(MouseEvent.MOUSE_OUT, func_outObject);
            
            if (!inputVarLocked) {
               Polygon_Objeto.addEventListener(MouseEvent.MOUSE_DOWN, Seccion_Move);
               Polygon_Objeto.addEventListener(MouseEvent.MOUSE_UP, Seccion_Stop);
            }

            if (mainWindow) {   
               if (Importado==null) {
                  myXML = My_Xml.Insert_Shape(Polygon_Objeto, myXML);
               }
            }
            
            Polygon_M_O_Point(Polygon_Objeto, false);

            if (!inputVarLocked) Polygon_Objeto.contextMenu = Menu_Pol_Formas;
            
            /* Debemos actualizar las figuras cargadas inicialmente XML */
            if (mainWindow) {
               if (Importado != null) {
                  
                  for(k = 0; k < myXML.Recinto[0].Figuras[0].children().length(); k++) {
                     if (myXML.Recinto[0].Figuras[0].Figura[k].@Nombre == Polygon_Nombre) {
                        myXML.Recinto[0].Figuras[0].Figura[k].@id_Fig = Polygon_Objeto.Polygon_Nombre_Array[0].id;
                        myXML.Recinto[0].Figuras[0].Figura[k].Vertices[0].@id_Fig = Polygon_Objeto.Polygon_Nombre_Array[0].id;
                     }
                  }
               }
            }
            else {
               if (Importado != null) {
                  indexSeccXML = getIndexSeccXML(indexSecc);
                  
                  for(k = 0; k < myXML.Recinto[0].Secciones[0].Seccion[indexSeccXML].Figuras[0].children().length(); k++) {
                     if (myXML.Recinto[0].Secciones[0].Seccion[indexSeccXML].Figuras[0].Figura[k].@Nombre == Polygon_Nombre) {
                        myXML.Recinto[0].Secciones[0].Seccion[indexSeccXML].Figuras[0].Figura[k].@id_Fig = Polygon_Objeto.Polygon_Nombre_Array[0].id;
                        myXML.Recinto[0].Secciones[0].Seccion[indexSeccXML].Figuras[0].Figura[k].Vertices[0].@id_Fig = Polygon_Objeto.Polygon_Nombre_Array[0].id;
                     }
                  }
               }
            }
            
            Polygon_Crear_Temp.graphics.clear();
            Polygon_Crear_Temp_Point0=true;
            Polygon_Crear=false;
            return Polygon_Objeto;            
         }
         return null;
      }
      
      public function Grafico_Dibujar(mainWindow:Boolean, Board:Object, indexSecc:int, inf_grafico:Object) {
         var k:int;
         var indexSeccXML:int;

         /* Creamos el gráfico */
         var objGraphic:Object;

         if (int(inf_grafico.GrafTipo) == 1) objGraphic = new Grafico1();         
         else if (int(inf_grafico.GrafTipo) == 2) objGraphic = new Grafico2();
         
         if (mainWindow) Graphic_Count++;
         else Graphic_Count_Dise++;
         
         Board.addChild(DisplayObject(objGraphic));
         
         objGraphic.x = inf_grafico.xGraf;
         objGraphic.y = inf_grafico.yGraf;
         
         if (mainWindow) objGraphic.atr_id = Graphic_Count;
         else objGraphic.atr_id = Graphic_Count_Dise;
         objGraphic.atr_idRec = Recinto_Inf[0].Id;
         objGraphic.atr_nombre = inf_grafico.Graf_Name;
         objGraphic.name = objGraphic.atr_nombre;
         objGraphic.atr_rotate = int(inf_grafico.Rotacion);
         objGraphic.atr_tipo = int(inf_grafico.GrafTipo);
         objGraphic.rotationZ = -objGraphic.atr_rotate;

         objGraphic.height = int(inf_grafico.AltoGraf);
         objGraphic.width = int(inf_grafico.AnchoGraf);
         
         /* Introducimos los eventos de poder mover los gráficos */
         if (!inputVarLocked) {
            objGraphic.addEventListener(MouseEvent.MOUSE_MOVE, graphic_In);
            objGraphic.addEventListener(MouseEvent.MOUSE_OUT, graphic_Out);
                  
            objGraphic.addEventListener(MouseEvent.MOUSE_DOWN, graphic_Drag);
            objGraphic.addEventListener(MouseEvent.MOUSE_UP, graphic_Drop);
                  
            objGraphic.contextMenu = Menu_Pol_Graphics;   
         }
         
         if (mainWindow) Graphic_Arreglo.push(objGraphic);
         else Graphic_Arreglo_Dise.push(objGraphic);
         
         if (mainWindow) Mini_Mapa_Crear();
         
         if (mainWindow) {
            /* Debemos actualizar los gráficos cargadas inicialmente XML */
            for(k = 0; k < myXML.Recinto[0].Graficos[0].children().length(); k++) {
               if (myXML.Recinto[0].Graficos[0].Grafico[k].@Nombre == objGraphic.atr_nombre) {
                  myXML.Recinto[0].Graficos[0].Grafico[k].@id_Graf = objGraphic.atr_id;
               }
            }
         }
         else {
            indexSeccXML = getIndexSeccXML(indexSecc);
            for(k = 0; k < myXML.Recinto[0].Secciones[0].Seccion[indexSeccXML].Graficos[0].children().length(); k++) {
               if (myXML.Recinto[0].Secciones[0].Seccion[indexSeccXML].Graficos[0].Grafico[k].@Nombre == objGraphic.atr_nombre) {
                  myXML.Recinto[0].Secciones[0].Seccion[indexSeccXML].Graficos[0].Grafico[k].@id_Graf = objGraphic.atr_id;
               }
            }
         }      
      }
      
      public function Label_Dibujar(mainWindow:Boolean, Board:Object, indexSecc:int, inf_label:Object) {
         var k:int;
         var indexSeccXML:int;
         
         /* Creamos el label */
         var objLabel:Texto = new Texto();
         if (mainWindow) Label_Count++;
         else Label_Count_Dise++;
         
         objLabel.Objeto.autoSize = TextFieldAutoSize.LEFT;
               
         objLabel.x = inf_label.xLab;
         objLabel.y = inf_label.yLab;
         objLabel.Objeto.text = inf_label.Texto;
         objLabel.Objeto.height = int(inf_label.FuenteTam) * 1.3;
               
         if (mainWindow) objLabel.atr_id = Label_Count;
         else objLabel.atr_id = Label_Count_Dise;
         objLabel.atr_idRec = Recinto_Inf[0].Id;
         objLabel.atr_nombre = inf_label.Lab_Name;
         objLabel.name = objLabel.atr_nombre;
         objLabel.atr_fontName = inf_label.Fuente;
         objLabel.atr_fontSize = int(inf_label.FuenteTam);
         objLabel.atr_bold = int(inf_label.FuenteBold);
         objLabel.atr_italic = int(inf_label.FuenteItalic);
         objLabel.atr_color = int(inf_label.FuenteColor);
         objLabel.atr_rotate = int(inf_label.FuenteRotacion);
         
         /* Introducimos los eventos de poder mover las etiquetas */
         if (!inputVarLocked) {
            objLabel.Objeto.addEventListener(MouseEvent.MOUSE_MOVE, label_In);
            objLabel.Objeto.addEventListener(MouseEvent.MOUSE_OUT, label_Out);
                  
            objLabel.Objeto.addEventListener(MouseEvent.MOUSE_DOWN, label_Drag);
            objLabel.Objeto.addEventListener(MouseEvent.MOUSE_UP, label_Drop);
            
            objLabel.contextMenu = Menu_Pol_Labels;
         }
         
         if (mainWindow) Label_Arreglo.push(objLabel);
         else Label_Arreglo_Dise.push(objLabel);
         
         My_Var_In_sEditor.getInstance().Label_Objeto_Seleccionado = objLabel;
         actualizarTexto();
         My_Var_In_sEditor.getInstance().Label_Objeto_Seleccionado = null;
         Board.addChild(objLabel);
         
         if (mainWindow) Mini_Mapa_Crear();
         
         if (mainWindow) {
            /* Debemos actualizar las etiquetas cargadas inicialmente XML */
            for(k = 0; k < myXML.Recinto[0].Etiquetas[0].children().length(); k++) {
               if (myXML.Recinto[0].Etiquetas[0].Etiqueta[k].@Nombre == objLabel.atr_nombre) {
                  myXML.Recinto[0].Etiquetas[0].Etiqueta[k].@id_Etiq = objLabel.atr_id;
               }
            }
         }
         else {
            indexSeccXML = getIndexSeccXML(indexSecc);
            for(k = 0; k < myXML.Recinto[0].Secciones[0].Seccion[indexSeccXML].Etiquetas[0].children().length(); k++) {
               if (myXML.Recinto[0].Secciones[0].Seccion[indexSeccXML].Etiquetas[0].Etiqueta[k].@Nombre == objLabel.atr_nombre) {
                  myXML.Recinto[0].Secciones[0].Seccion[indexSeccXML].Etiquetas[0].Etiqueta[k].@id_Etiq = objLabel.atr_id;
               }
            }
         }
      }
      
      public function Polygon_inForm(e:MouseEvent):void {
         var objParent:Object;
         
         if (polygon_mouseOver == false) {
            polygon_mouseOver = true;
            if (e.target.parent.name != "Etiqueta") objParent = e.target.parent;
            else objParent = e.target.parent.parent;
            
            /* Pintamos los Polígonos */
            var index:int = Buscar_en_Arreglo(Polygon_Arreglo, objParent.name);
            for (var i:int=0; i<Polygon_Arreglo.length; i++) {
               if (Polygon_Arreglo[i].name!=Polygon_Arreglo[index].name) {
                  Polygon_Arreglo[i].drawLines(Polygon_Arreglo[i].Polygon_Color);
               } else {
                  Polygon_Arreglo[i].drawLinesOver(Polygon_Arreglo[i].Polygon_Color);
               }
            }

            if (permitirMoverObjetos(true)) {
               if (!inputVarLocked) Mouse.cursor = MouseCursor.HAND;
               else Mouse.cursor = MouseCursor.BUTTON;
            }
            else Mouse.cursor = MouseCursor.ARROW;
            
            Polygon_Out=false;
            e.target.doubleClickEnabled = true;
            e.target.addEventListener(MouseEvent.DOUBLE_CLICK, Polygon_Vista_Diseño);
            e.target.addEventListener(MouseEvent.MOUSE_MOVE, Seccion_Info);
            
            function Seccion_Info(e:Object) {
               if (e.target.parent.name!="Etiqueta") {
                 var index:int=Buscar_en_Arreglo(Polygon_Arreglo,e.target.parent.name);
                 Seccion_Inf_Globo.visible = true;
                 
                 Seccion_Inf_Globo.Secc_Nombre.setStyle("textFormat", _Est.Format_PopupSection(true));
                 Seccion_Inf_Globo.Secc_Nombre.text = e.target.parent.name;
                     
                 Seccion_Inf_Globo.Secc_Libres.setStyle("textFormat", _Est.Format_PopupSection(false));
                 
                 But_Acciones = new AccionesButacas();
                 if (!inputVarTemplate) Seccion_Inf_Globo.Secc_Libres.text = Polygon_Arreglo[index].Polygon_But_Libres + " localidades libres";
                 else Seccion_Inf_Globo.Secc_Libres.text = Polygon_Arreglo[index].Polygon_But_Totales + " localidades";
                 
                 Seccion_Inf_Globo.Secc_Precio.setStyle("textFormat", _Est.Format_PopupSection(false));
                 
                 if (!inputVarTemplate) Seccion_Inf_Globo.Secc_Precio.text = Number(Polygon_Arreglo[index].Polygon_But_Precio).toFixed(2) + " €";
                 else Seccion_Inf_Globo.Secc_Precio.text = "-- €";
                 
                 if (stage.mouseX + 10 + Seccion_Inf_Globo.width < stage.stageWidth) Seccion_Inf_Globo.x = stage.mouseX + 10;
                 else Seccion_Inf_Globo.x = stage.mouseX + 10 - ((stage.mouseX + 10 + Seccion_Inf_Globo.width) - stage.stageWidth);
         
                 if (stage.mouseY - 10 - Seccion_Inf_Globo.height > 39) Seccion_Inf_Globo.y = stage.mouseY - Seccion_Inf_Globo.height - 10;
                 else Seccion_Inf_Globo.y = stage.mouseY + 10;
               }
            }
         }
      }
      
      public function Polygon_outForm(e:MouseEvent):void {
         if (e.target.parent.name != "Etiqueta") {
            polygon_mouseOver = false;
            Seccion_Inf_Globo.visible = false;
            Polygon_Out = true;
            e.target.parent.drawLines(e.target.parent.Polygon_Color);
            if ((My_Var_In_sEditor.getInstance().Dibujando_Seccion == false) && (My_Var_In_sEditor.getInstance().Dibujando_Forma == false)) Mouse.cursor = MouseCursor.ARROW;
         }
      }
      
      public function Polygon_Precio(e:ContextMenuEvent) {
         var parentObj:Object;
         var Ind_Secc:int;
         var tmpPrecio:Number;
         
         if (e.mouseTarget.parent.name != "Etiqueta") parentObj = e.mouseTarget.parent;
         else parentObj = e.mouseTarget.parent.parent;
         
         Ind_Secc = Buscar_en_Arreglo(Polygon_Arreglo, parentObj.name);
         
         var _Block01:Block = new Block();
         addChild(_Block01);
         _Block01.alpha = 0.9;

         var Form_Precio:Seccion_Precio_Form = new Seccion_Precio_Form();
         Form_Precio.Err_PrecioNumerico.visible = false;
         Form_Precio.Btn_Aceptar.addEventListener(MouseEvent.MOUSE_DOWN, Aceptar_Precio);
         Form_Precio.Btn_Cancelar.addEventListener(MouseEvent.MOUSE_DOWN, Cancelar_Precio);
         addChild(Form_Precio);
         centrar_Alerta(Form_Precio);
         Form_Precio.Precio_Inp.text = myXML.Recinto[0].Secciones[0].Seccion[Ind_Secc].@But_Precio;
         
         function Aceptar_Precio(e:MouseEvent) {
            Form_Precio.Err_PrecioNumerico.visible = false;
            
            if (!isNaN(Number(Form_Precio.Precio_Inp.text))) {
               if ((Form_Precio.Precio_Inp.text.length > 0) && (Number(Form_Precio.Precio_Inp.text) > 0)) {
                  myXML.Recinto[0].Secciones[0].Seccion[Ind_Secc].@But_Precio = Number(Form_Precio.Precio_Inp.text).toFixed(2);
                  tmpPrecio = Number(Number(Form_Precio.Precio_Inp.text).toFixed(2));
                  
                  if (!inputVarTemplate) cambiarPrecioDesc(Number(Polygon_Arreglo[Ind_Secc].Polygon_But_Precio), tmpPrecio);
                  Polygon_Arreglo[Ind_Secc].Polygon_But_Precio = tmpPrecio.toString();
                  
                  if (!inputVarTemplate) pintarPoligonos();   
                  removeChild(_Block01);
                  removeChild(Form_Precio);
               }
               else Form_Precio.Err_PrecioNumerico.visible = true;
            }
            else Form_Precio.Err_PrecioNumerico.visible = true;
         }
         
         function Cancelar_Precio(e:MouseEvent) {
            removeChild(_Block01);
            removeChild(Form_Precio);
         }
         
      }
      
      public function Polygon_Mostrar_Puntos(e:ContextMenuEvent) {
         var parentObj:Object;
         var index:int;
         var secc:Boolean;
         var i:int;
         var j:int;
         
         if (e.mouseTarget.parent.name != "Etiqueta") parentObj = e.mouseTarget.parent;
         else parentObj = e.mouseTarget.parent.parent;
         
         index = 0;
         secc = false;
         if (My_Var_In_sEditor.getInstance().Vista_Recinto) {
            /* Oculta los puntos a los poligonos no seleccionados */
            for (i=0; i<Polygon_Arreglo.length; i++) {
               if (Polygon_Arreglo[i].name != parentObj.name) {
                  Polygon_M_O_Point(Polygon_Arreglo[i], false);
               }
               else { secc = true; index = i; }
            }
            for (j = 0; j<Polygon_Arreglo_Formas.length; j++) {
               if (Polygon_Arreglo_Formas[j].name != parentObj.name) {
                  Polygon_M_O_Point(Polygon_Arreglo_Formas[j], false);
               }
               else { secc = false; index = j; }
            }
            
            /* Seleccionamos otro polígono distinto del que estamos editando => quitamos la edición */
            if ((My_Var_In_sEditor.getInstance().Editando_Pol) && ((My_Var_In_sEditor.getInstance().Editando_Pol_Index != index) || ((My_Var_In_sEditor.getInstance().Editando_Pol_Index == index) && (My_Var_In_sEditor.getInstance().Editando_Pol_Secc != secc)))) {
               My_Var_In_sEditor.getInstance().Editando_Pol = false;  
            }
         }
         else {
            /* Oculta los puntos a los poligonos no seleccionados */
            for (j = 0; j<Polygon_Arreglo_Formas_Dise.length; j++) {
               if (Polygon_Arreglo_Formas_Dise[j].name != parentObj.name) {
                  Polygon_M_O_Point(Polygon_Arreglo_Formas_Dise[j], false);
               }
               else { index = j; }
            }
            
            /* Seleccionamos otro polígono distinto del que estamos editando => quitamos la edición */
            if ((My_Var_In_sEditor.getInstance().Editando_Pol) && (My_Var_In_sEditor.getInstance().Editando_Pol_Index != index)) {
               My_Var_In_sEditor.getInstance().Editando_Pol = false;  
            }
         }
            
         if (My_Var_In_sEditor.getInstance().Editando_Pol != true) {
            Polygon_M_O_Point(parentObj, true);
            My_Var_In_sEditor.getInstance().Editando_Pol = true;
            My_Var_In_sEditor.getInstance().Editando_Pol_Index = index;
            My_Var_In_sEditor.getInstance().Editando_Pol_Secc = secc;
         } else {
            Polygon_M_O_Point(parentObj, false);
            My_Var_In_sEditor.getInstance().Editando_Pol = false;
         }
      }
      
      private function Polygon_M_O_Point(Polygon:Object, Accion:Boolean=false) {
         for (var i:int=0; i<Polygon.numChildren; i++) {
            if (Polygon.getChildAt(i).name=="P") {
               Polygon.getChildAt(i).visible=Accion;
            }
         }
      }

      public function Polygon_Vista_Diseño(event:MouseEvent, Polygon_Name:String=null):void {
         var Pol:int;
         var Lab:int;
         var Graf:int;
         var i:int;
         var j:int;
         var p:int;
         var index:int;
         var objParent:Object;
         
         if (permitirMoverObjetos(true)) {
            reiniciarVariablesGlobales();
            Polygon_Count_Formas_Dise = 0;
            Label_Count_Dise = 0;
            Graphic_Count_Dise = 0;
            Polygon_Arreglo_Formas_Dise = new Array();
            Label_Arreglo_Dise = new Array();
            Graphic_Arreglo_Dise = new Array();
            
            Menu_Board_Dise = new ContextMenu();
            Mouse.cursor = MouseCursor.ARROW;
            dadesDetallGuardades = true;
            Matriz="F";
            Herramientas_Ppal.visible=false;
            
            Board_Mini.visible = false;
            polygon_mouseOver = false;
            My_Var_In_sEditor.getInstance().Editando_Pol = false;
            
            if (event.target.parent.name != "Etiqueta") objParent = event.target.parent;
            else objParent = event.target.parent.parent;
               
            if (Polygon_Name==null) {
               index=Buscar_en_Arreglo(Polygon_Arreglo, objParent.name);
            } else {
               index=Buscar_en_Arreglo(Polygon_Arreglo, Polygon_Name);
            }
            My_Var_In_sEditor.getInstance().Seccion_Edit=Polygon_Arreglo[index].name;
            for (i = 0; i<Polygon_Arreglo.length; i++) {
               if (Polygon_Arreglo[i].name!=Polygon_Arreglo[index].name) {
                  Polygon_Arreglo[i].alpha=0.3;
               } else {
                  Polygon_Arreglo[i].alpha=1;
               }
            }
            Mini_Mapa_Crear();
            Board.visible=false;
            
            Board_Dise = new Board_Vista_Diseño();
            Board_Dise.doubleClickEnabled = true;
            if (!inputVarLocked) Board_Dise.addEventListener(MouseEvent.DOUBLE_CLICK, Board_Dise_DOUBLECLICK);
            
            My_Var_In_sEditor.getInstance().Vista_Actual = Board_Dise;
            My_Var_In_sEditor.getInstance().Vista_Recinto = false;
            But_Inf_Globo = new But_Inf();
            addChild(But_Inf_Globo);
            But_Inf_Globo.visible = false;
            But_Inf_Globo.alpha=1.0;

            Board_Dise_Zoom_Point = new SpriteRegPoint("C");
            Board_Dise_Zoom_Point.addChild(Board_Dise);
            addChild(Board_Dise_Zoom_Point);
            Board_Dise_Zoom_Point.x = stage.stageWidth/2 + 30;
            Board_Dise_Zoom_Point.y = stage.stageHeight/2 + 20;
         
            var But_Arreglo:Array=[];
            Board_Dise.x = 2560;
            Board_Dise.y = 2490;
         
            var Board_Scroll:Function=function(e:MouseEvent){_Board_Scroll(e, Board_Dise_Zoom_Point)};
            Board_Dise.addEventListener(MouseEvent.MOUSE_WHEEL, Board_Scroll);
            Board_Dise.addEventListener(MouseEvent.MOUSE_MOVE, Board_Dise_Mov_Mouse);
            Board_Dise.addEventListener(MouseEvent.MOUSE_DOWN, Board_Dise_DOWN);
            var _Board_Dise_UP:Function = function(e:MouseEvent) { Board_Dise_UP(e, index) };
            Board_Dise.addEventListener(MouseEvent.MOUSE_UP, _Board_Dise_UP);
            Board_Dise.addEventListener(MouseEvent.CLICK, Board_Dise_CLICK);
            Board_Dise.name="_Board_Dise";
            
            var Marco_Dise:Board_Marco_Vista_Diseño=new Board_Marco_Vista_Diseño();

            addChild(Marco_Dise);
            Marco_Dise.Tool_V.alpha = 1.0;

            var retornar:Function = function(e:MouseEvent) { _btn_Retornar(e, Board_Dise_Zoom_Point, Board_Dise, Marco_Dise) };
            Marco_Dise.Btn_Volver.addEventListener(MouseEvent.MOUSE_DOWN, retornar);
            Marco_Dise.Btn_Volver.label = "Retroceder";
            Marco_Dise.Btn_Volver.setStyle("textFormat", _Est.Herramientas_MPpal_St()[4]);
            var tooltip_Btn_Volver:ToolTip = new ToolTip(Marco_Dise.Btn_Volver, "Volver a Escenario");
            btn_seccionVolver = Marco_Dise.Btn_Volver; 
            
            var moverSeccion:Function = function(e:MouseEvent) { _btn_MoverSeccion(e, Board_Dise, Marco_Dise) };
            Marco_Dise.Btn_Mover.addEventListener(MouseEvent.MOUSE_DOWN, moverSeccion);
            Marco_Dise.Btn_Mover.label = "Mover";
            Marco_Dise.Btn_Mover.setStyle("textFormat", _Est.Herramientas_MPpal_St()[4]);
            var tooltip_Btn_Mover:ToolTip = new ToolTip(Marco_Dise.Btn_Mover, "Mover Sección");
            btn_seccionMover = Marco_Dise.Btn_Mover;
            
            var Escenario_Salvar:Function=function(e:MouseEvent) { _Escenario_Salvar(e,Board_Dise, Marco_Dise, Polygon_Arreglo[index].name, index)};
            Marco_Dise.Btn_Salvar.addEventListener(MouseEvent.MOUSE_DOWN, Escenario_Salvar);
            Marco_Dise.Btn_Salvar.label = "Salvar";
            Marco_Dise.Btn_Salvar.setStyle("textFormat", _Est.Herramientas_MPpal_St()[4]);            
            var tooltip_Btn_Salvar:ToolTip=new ToolTip(Marco_Dise.Btn_Salvar, "Salvar Diseño de Butacas");
            btn_seccionSalvar = Marco_Dise.Btn_Salvar; 
            
            var No_Butacas:int;
            var Butacas:Function=function(e:MouseEvent){ No_Butacas=1; Butacas_Diseño(e,Board_Dise,Marco_Dise, But_Arreglo, index, No_Butacas, 1, 1)};
            Marco_Dise.Btn_But_Col.addEventListener(MouseEvent.MOUSE_DOWN, Butacas);
            Marco_Dise.Btn_But_Col.label = "Butaca";
            Marco_Dise.Btn_But_Col.setStyle("textFormat", _Est.Herramientas_MPpal_St()[4]);            
            var tooltip_Btn_But_Col:ToolTip=new ToolTip(Marco_Dise.Btn_But_Col, "Colocar Butaca");
            btn_seccionButaca = Marco_Dise.Btn_But_Col; 
            
            var tooltip_Btn_But_Col_M:ToolTip=new ToolTip(Marco_Dise.Btn_C_M,"Colocar Matriz de Butacas");
            var Butacas_C_M:Function=function(e:MouseEvent){Form_But_C_Matriz(e,Board_Dise,Marco_Dise, But_Arreglo, index, No_Butacas)};
            Marco_Dise.Btn_C_M.addEventListener(MouseEvent.MOUSE_DOWN, Butacas_C_M);
            Marco_Dise.Btn_C_M.label = "Butacas";
            Marco_Dise.Btn_C_M.setStyle("textFormat", _Est.Herramientas_MPpal_St()[4]);
            btn_seccionButacas = Marco_Dise.Btn_C_M;
            
               img_Mover = new UILoader();
            img_Mover.scaleContent = false;
            img_Mover.source = My_Var_In_sEditor.getInstance().HTTP_SEditor + "images/mtools_lockon.png";
            if (!inputVarLocked) img_Mover.move(403, 8);
            else img_Mover.move(137, 8);
            Marco_Dise.addChild(img_Mover);

            var tooltip_btn_Formas:ToolTip=new ToolTip(Marco_Dise.btn_Formas, "Insertar Figura");
            var _New_Shapes_Dise:Function=function(e:MouseEvent){ New_Shapes_Dise(e,index) };
            Marco_Dise.btn_Formas.addEventListener(MouseEvent.MOUSE_DOWN, _New_Shapes_Dise);
            Marco_Dise.btn_Formas.label = "Figura";
            Marco_Dise.btn_Formas.setStyle("textFormat", _Est.Herramientas_MPpal_St()[8]);
            btn_seccionFormas = Marco_Dise.btn_Formas;
            
            var tooltip_btn_Texto:ToolTip=new ToolTip(Marco_Dise.btn_Texto, "Insertar Etiqueta");
            var _New_Label_Dise:Function=function(e:MouseEvent){New_Label_Dise(e,index)};
            Marco_Dise.btn_Texto.addEventListener(MouseEvent.MOUSE_DOWN, _New_Label_Dise);
            Marco_Dise.btn_Texto.label = "Etiqueta";
            Marco_Dise.btn_Texto.setStyle("textFormat", _Est.Herramientas_MPpal_St()[8]);
            btn_seccionTexto = Marco_Dise.btn_Texto;
            
            var tooltip_btn_Grafico:ToolTip=new ToolTip(Marco_Dise.btn_Grafico, "Insertar Gráfico");
            var _New_Graphic_Dise:Function=function(e:MouseEvent){New_Graphic_Dise(e,index)};
            Marco_Dise.btn_Grafico.addEventListener(MouseEvent.MOUSE_DOWN, _New_Graphic_Dise);
            Marco_Dise.btn_Grafico.label = "Gráfico";
            Marco_Dise.btn_Grafico.setStyle("textFormat", _Est.Herramientas_MPpal_St()[8]);
            btn_seccionGrafico = Marco_Dise.btn_Grafico;
            
            function Invertir_Change(event:Event):void { Polygon_Arreglo[index].Polygon_Num_Inv = event.target.selected; }
            Marco_Dise.chk_Num_Inv.addEventListener(Event.CHANGE, Invertir_Change);
            Marco_Dise.chk_Num_Inv.visible = false;
            
            var tooltip_chk_Num_Inv:ToolTip = new ToolTip(Marco_Dise.chk_Num_Inv, "Desactivado - Col. Arriba, Fil. Izquierda\nActivado      - Col. Izquierda, Fil. Arriba");
            btn_seccionNumeracion = Marco_Dise.chk_Num_Inv;
            
            btn_seccionVolver.addEventListener(MouseEvent.MOUSE_OVER, Section_Buttons_Over);
            btn_seccionVolver.addEventListener(MouseEvent.MOUSE_OUT, Section_Buttons_Out);
            btn_seccionButaca.addEventListener(MouseEvent.MOUSE_OVER, Section_Buttons_Over);
            btn_seccionButaca.addEventListener(MouseEvent.MOUSE_OUT, Section_Buttons_Out);
            btn_seccionButacas.addEventListener(MouseEvent.MOUSE_OVER, Section_Buttons_Over);
            btn_seccionButacas.addEventListener(MouseEvent.MOUSE_OUT, Section_Buttons_Out);
            btn_seccionMover.addEventListener(MouseEvent.MOUSE_OVER, Section_Buttons_Over);
            btn_seccionMover.addEventListener(MouseEvent.MOUSE_OUT, Section_Buttons_Out);
            btn_seccionSalvar.addEventListener(MouseEvent.MOUSE_OVER, Section_Buttons_Over);
            btn_seccionSalvar.addEventListener(MouseEvent.MOUSE_OUT, Section_Buttons_Out);
            btn_seccionNumeracion.addEventListener(MouseEvent.MOUSE_OVER, Section_Buttons_Over);
            btn_seccionNumeracion.addEventListener(MouseEvent.MOUSE_OUT, Section_Buttons_Out);
            btn_seccionFormas.addEventListener(MouseEvent.MOUSE_OVER, Section_Buttons_Over);
            btn_seccionFormas.addEventListener(MouseEvent.MOUSE_OUT, Section_Buttons_Out);
            btn_seccionTexto.addEventListener(MouseEvent.MOUSE_OVER, Section_Buttons_Over);
            btn_seccionTexto.addEventListener(MouseEvent.MOUSE_OUT, Section_Buttons_Out);
            btn_seccionGrafico.addEventListener(MouseEvent.MOUSE_OVER, Section_Buttons_Over);
            btn_seccionGrafico.addEventListener(MouseEvent.MOUSE_OUT, Section_Buttons_Out);
            
            grid = new Grid(false);
            Board_Dise.addChildAt(grid, 1);
            grid.name="_Board_Dise_Grid";
            
            No_Butacas=1;
            var Ind_Secc:int=0;
            for (var Pol_Name:int=0; Pol_Name<myXML.Recinto[0].Secciones[0].children().length(); Pol_Name++) {
               if (myXML.Recinto[0].Secciones[0].Seccion[Pol_Name].@Nombre==Polygon_Arreglo[index].name) {
                  Ind_Secc=Pol_Name;
               }
            }
            
            Metodo_But_Propiedades = function(e:Object, doubleClick:Boolean) { _Metodo_But_Propiedades(e, Board_Dise, Marco_Dise, index, doubleClick) };
            Metodo_But_Propiedades_no_dc = function(e:Object) { Metodo_But_Propiedades(e, false) };
            Metodo_But_Propiedades_dc = function(e:Object) { Metodo_But_Propiedades(e, true) };
            
            /* Actualizamos el atributo de Numeración Invertida */
            Polygon_Arreglo[index].Polygon_Num_Inv = Boolean(int(myXML.Recinto[0].Secciones[0].Seccion[Ind_Secc].@Num_Inv));
            btn_seccionNumeracion.selected = Boolean(int(myXML.Recinto[0].Secciones[0].Seccion[Ind_Secc].@Num_Inv));
            
            if (myXML.Recinto[0].Secciones[0].Seccion[Ind_Secc].Butacas.children().length()!=0) {
   
               var My_But:But;
               var But_Int:Function=function (e:MouseEvent){_But_Int(e,My_But, No_Butacas)};
               for (var But_Rest:int=0; But_Rest<myXML.Recinto[0].Secciones[0].Seccion[Ind_Secc].Butacas.children().length(); But_Rest++) {
                  My_But = new But();
                  Board_Dise.addChild(My_But);
                  My_But.doubleClickEnabled = true;

                  My_But.name="But";
                  My_But.difX=0;
                  My_But.difY=0;
                  My_But.But_Modificada = false;
      
                  My_But.Fila=myXML.Recinto[0].Secciones[0].Seccion[Ind_Secc].Butacas._Butaca[But_Rest].@F;
                  My_But.Columna=myXML.Recinto[0].Secciones[0].Seccion[Ind_Secc].Butacas._Butaca[But_Rest].@C;
                  My_But.Estado=myXML.Recinto[0].Secciones[0].Seccion[Ind_Secc].Butacas._Butaca[But_Rest].@E;
                  My_But.Calidad=(int(Number(myXML.Recinto[0].Secciones[0].Seccion[Ind_Secc].Butacas._Butaca[But_Rest].@Q)*100));
                  My_But.Id_Butaca=myXML.Recinto[0].Secciones[0].Seccion[Ind_Secc].Butacas._Butaca[But_Rest].@Id_But;
                  
                  if (My_But.Estado=="Libre") { My_But.gotoAndStop(1); }
                  if (My_But.Estado=="Ocupada") { My_But.gotoAndStop(2); }
                  if (My_But.Estado=="Asignada") { My_But.gotoAndStop(3); }
                  if (My_But.Estado=="Averiada") { My_But.gotoAndStop(7); }
                  if (My_But.Estado=="Reservada") { My_But.gotoAndStop(9); }
                  
                  My_But.Angulo=myXML.Recinto[0].Secciones[0].Seccion[Ind_Secc].Butacas._Butaca[But_Rest].@A;
                  if (My_But.Angulo!=0) {
                     My_But.rotation=My_But.Angulo*(-1);
                  }
                  My_But.But_Marcada=false;
                  My_But.x=myXML.Recinto[0].Secciones[0].Seccion[Ind_Secc].Butacas._Butaca[But_Rest].@x;
                  My_But.y=myXML.Recinto[0].Secciones[0].Seccion[Ind_Secc].Butacas._Butaca[But_Rest].@y;

                  My_But.addEventListener(MouseEvent.MOUSE_DOWN, But_Down);
                  var But_UP:Function=function(evento:MouseEvent){_But_Up(evento, Board_Dise)};
                  
                  My_But.addEventListener(MouseEvent.MOUSE_UP, But_UP);
                     
                  My_But.addEventListener(MouseEvent.DOUBLE_CLICK, Metodo_But_Propiedades_dc);
                  My_But.addEventListener(MouseEvent.MOUSE_OVER, But_Act);
                  My_But.addEventListener(MouseEvent.MOUSE_OUT, But_DesAct);
               }
               My_Coord.Refrescar(Board_Dise);
            }

            But_Acciones = new AccionesButacas();
            But_Acciones.Marcar_Butacas(Board_Dise, My_Var_In_sEditor);
               
            /* Menu contextual Board Disseño */
            Eliminar_Butacas = function(e:ContextMenuEvent){_Eliminar_Butacas(e,Board_Dise, Marco_Dise, index)};
            Metodo_Menu_Board_Dise_Marcar_Todas = function(e:ContextMenuEvent){_Menu_Board_Dise_Marcar_Todas(e,Board_Dise)};
            Menu_Board_Dise_Marcar_Todas.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT,Metodo_Menu_Board_Dise_Marcar_Todas);
            Metodo_Menu_Board_Dise_Desmarcar = function(e:ContextMenuEvent){_Menu_Board_Dise_Desmarcar(e,Board_Dise)};
            Menu_Board_Dise_Desmarcar.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT,Metodo_Menu_Board_Dise_Desmarcar);
            Menu_Board_Dise_Eliminar.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT,Eliminar_Butacas);
            
            Menu_Board_Dise_Propiedades.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, Metodo_But_Propiedades_no_dc);                   

            Menu_Board_Dise.hideBuiltInItems();
            if (!inputVarLocked) {
               Menu_Board_Dise.customItems.push(Menu_Board_Dise_Marcar_Todas);
               Menu_Board_Dise.customItems.push(Menu_Board_Dise_Desmarcar);
               Menu_Board_Dise.customItems.push(Menu_Board_Dise_Eliminar);
            }
            Menu_Board_Dise.customItems.push(Menu_Board_Dise_Propiedades);
            
            Board_Dise.contextMenu = Menu_Board_Dise;
            
            if (inputVarLocked) {
               Marco_Dise.Btn_But_Col.visible = false;
               Marco_Dise.Btn_C_M.visible = false;

               Marco_Dise.img_DiseBut.visible = false;
               Marco_Dise.img_MatrixDiseBut.visible = false;
               
               Marco_Dise.Btn_Mover.x = 166.45;
               Marco_Dise.img_DiseSave.x = Marco_Dise.img_MatrixDiseBut.x;
               Marco_Dise.Btn_Salvar.x = Marco_Dise.Btn_C_M.x;

               Marco_Dise.img_Formas.visible = false;
               Marco_Dise.btn_Formas.visible = false;
               Marco_Dise.img_Texto.visible = false;
               Marco_Dise.btn_Texto.visible = false;
               Marco_Dise.img_Grafico.visible = false;
               Marco_Dise.btn_Grafico.visible = false;
            }

            /* Introducimos las Figuras */
            Recinto_Array_Cargar_Figuras_Dise = new Array();
            vertex_Array_Cargar_Figuras_Dise = new Array();
            for (Pol = 0; Pol < myXML.Recinto[0].Secciones[0].Seccion[Ind_Secc].Figuras[0].children().length(); Pol++) {
               var Nombre_Fig:String = myXML.Recinto[0].Secciones[0].Seccion[Ind_Secc].Figuras[0].Figura[Pol].@Nombre;
            
               for (i = 0; i< myXML.Recinto[0].Secciones[0].Seccion[Ind_Secc].Figuras[0].Figura[Pol].Vertices.children().length(); i++) {
                  vertex_Array_Cargar_Figuras_Dise.push({x:Number(myXML.Recinto[0].Secciones[0].Seccion[Ind_Secc].Figuras[0].Figura[Pol].Vertices._Point[i].@x), y:Number(myXML.Recinto[0].Secciones[0].Seccion[Ind_Secc].Figuras[0].Figura[Pol].Vertices._Point[i].@y), xPol:Number(myXML.Recinto[0].Secciones[0].Seccion[Ind_Secc].Figuras[0].Figura[Pol].@x), yPol:Number(myXML.Recinto[0].Secciones[0].Seccion[Ind_Secc].Figuras[0].Figura[Pol].@y), Fig_Name:myXML.Recinto[0].Secciones[0].Seccion[Ind_Secc].Figuras[0].Figura[Pol].@Nombre});
               }
            
               Recinto_Array_Cargar_Figuras_Dise.push({Pol:vertex_Array_Cargar_Figuras_Dise});
               vertex_Array_Cargar_Figuras_Dise = vertex_Array_Cargar_Figuras_Dise.splice(vertex_Array_Cargar_Figuras_Dise.length);
            }
            
            /* Dibujamos las Figuras */
            for (j = 0; j < Recinto_Array_Cargar_Figuras_Dise.length; j++) {
               Polygon_Crear = true;
                Polygon_Vertex = new Array();
               Polygon_Vertex = Polygon_Vertex.splice(Polygon_Vertex.length);
               for (p = 0; p < Recinto_Array_Cargar_Figuras_Dise[j].Pol.length; p++) {
                  Polygon_Vertex.push({name:Recinto_Array_Cargar_Figuras_Dise[j].Pol[p].Fig_Name, x:Recinto_Array_Cargar_Figuras_Dise[j].Pol[p].x, y:Recinto_Array_Cargar_Figuras_Dise[j].Pol[p].y});
               }
               Polygon_Crear_Temp=new Sprite();
               Board_Dise.addChild(Polygon_Crear_Temp);
               Polygon_Shape_Dibujar(false, My_Var_In_sEditor.getInstance().Vista_Actual, index, Polygon_Vertex[0].name, "True");
               Polygon_Arreglo_Formas_Dise[j].Polygon_Act_Mod = false;

               if (Recinto_Array_Cargar_Figuras_Dise[j].Pol[0].xPol!=0||Recinto_Array_Cargar_Figuras_Dise[j].Pol[0].yPol!=0) {
                  Polygon_Arreglo_Formas_Dise[j].x = Recinto_Array_Cargar_Figuras_Dise[j].Pol[0].xPol;
                  Polygon_Arreglo_Formas_Dise[j].y = Recinto_Array_Cargar_Figuras_Dise[j].Pol[0].yPol;
               }
            }
            
            /* Introducimos los Labels */
            Cargar_Labels_Dise = new Array();
            for (Lab = 0; Lab < myXML.Recinto[0].Secciones[0].Seccion[Ind_Secc].Etiquetas[0].children().length(); Lab++) {
               Cargar_Labels_Dise.push({xLab: Number(myXML.Recinto[0].Secciones[0].Seccion[Ind_Secc].Etiquetas[0].Etiqueta[Lab].@x), yLab:Number(myXML.Recinto[0].Secciones[0].Seccion[Ind_Secc].Etiquetas[0].Etiqueta[Lab].@y), Lab_Name:myXML.Recinto[0].Secciones[0].Seccion[Ind_Secc].Etiquetas[0].Etiqueta[Lab].@Nombre, Fuente:myXML.Recinto[0].Secciones[0].Seccion[Ind_Secc].Etiquetas[0].Etiqueta[Lab].@Fuente, FuenteTam:myXML.Recinto[0].Secciones[0].Seccion[Ind_Secc].Etiquetas[0].Etiqueta[Lab].@FuenteTam, FuenteBold:myXML.Recinto[0].Secciones[0].Seccion[Ind_Secc].Etiquetas[0].Etiqueta[Lab].@FuenteBold, FuenteItalic:myXML.Recinto[0].Secciones[0].Seccion[Ind_Secc].Etiquetas[0].Etiqueta[Lab].@FuenteItalic, FuenteColor:myXML.Recinto[0].Secciones[0].Seccion[Ind_Secc].Etiquetas[0].Etiqueta[Lab].@FuenteColor, FuenteRotacion:myXML.Recinto[0].Secciones[0].Seccion[Ind_Secc].Etiquetas[0].Etiqueta[Lab].@FuenteRotacion, Texto:myXML.Recinto[0].Secciones[0].Seccion[Ind_Secc].Etiquetas[0].Etiqueta[Lab].@Texto});
            }
            
            /* Dibujamos los Labels */
            for (j = 0; j < Cargar_Labels_Dise.length; j++) {
               Label_Dibujar(false, My_Var_In_sEditor.getInstance().Vista_Actual, index, Cargar_Labels_Dise[j]);
            }
         
            /* Introducimos los Gráficos */
            Cargar_Graficos_Dise = new Array();
            for (Graf = 0; Graf < myXML.Recinto[0].Secciones[0].Seccion[Ind_Secc].Graficos[0].children().length(); Graf++) {
               Cargar_Graficos_Dise.push({xGraf: Number(myXML.Recinto[0].Secciones[0].Seccion[Ind_Secc].Graficos[0].Grafico[Graf].@x), yGraf:Number(myXML.Recinto[0].Secciones[0].Seccion[Ind_Secc].Graficos[0].Grafico[Graf].@y), Graf_Name:myXML.Recinto[0].Secciones[0].Seccion[Ind_Secc].Graficos[0].Grafico[Graf].@Nombre, AnchoGraf: Number(myXML.Recinto[0].Secciones[0].Seccion[Ind_Secc].Graficos[0].Grafico[Graf].@Ancho), AltoGraf: Number(myXML.Recinto[0].Secciones[0].Seccion[Ind_Secc].Graficos[0].Grafico[Graf].@Alto), GrafTipo:Number(myXML.Recinto[0].Secciones[0].Seccion[Ind_Secc].Graficos[0].Grafico[Graf].@Tipo), Rotacion:myXML.Recinto[0].Secciones[0].Seccion[Ind_Secc].Graficos[0].Grafico[Graf].@Rotacion});
            }

            /* Dibujamos los Graficos */
            for (j = 0; j < Cargar_Graficos_Dise.length; j++) {
               Grafico_Dibujar(false, My_Var_In_sEditor.getInstance().Vista_Actual, index, Cargar_Graficos_Dise[j]);
            }
         
            resetearTextoPropiedades(false);
            actualize_diseInformation(Board_Dise, Marco_Dise, index, true); 
            centrar_vistaButacas(Board_Dise, Marco_Dise);
         }
      }
      
      private function Over_Button(e:MouseEvent) {
         e.target.gotoAndStop(2);
      }
      private function Out_Button(e:MouseEvent) {
         e.target.gotoAndStop(1);
      }
      
      private function getIndexSeccXML(Index:int) {
         var i:int;
         
         for (i=0; i<myXML.Recinto[0].Secciones[0].children().length(); i++ ){
            if (myXML.Recinto[0].Secciones[0].Seccion[i].@id_Secc == Polygon_Arreglo[Index].Polygon_Nombre_Array[0].id) {
               return i;
            }
          }      
      }
   
      private function _Escenario_Salvar(e:MouseEvent, Board_Dise:Object, Marco_Dise:Sprite, Seccion_Nombre:String, Index:int) {
         var i:int;
         var butacasListStr:String;
         var idSecc:int;
         var count:int;
         var numInv:int;
         var indexSecc:int;
         var Count_But:int = 0;
         var Count_Libres:Number = 0;
         var nodeXML_Fig:XML;
         var nodeXML_But:XML;
         var nodeXML_Etiq:XML;
         var nodeXML_Graf:XML; 
         
         //if (!inputVarLocked) {
         if(true) {
            if (!existenButacasFCDuplicadas(Board_Dise)) {
               dadesDetallGuardades = true;
               indexSecc = getIndexSeccXML(Index);
               
               delete myXML.Recinto[0].Secciones[0].Seccion[indexSecc].Butacas;
               nodeXML_But = new XML();
               nodeXML_But = <Butacas />;
               myXML.Recinto[0].Secciones[0].Seccion[indexSecc].appendChild(nodeXML_But);

               /* Actualizamos las butacas */
               for (i = 0; i<Board_Dise.numChildren; i++) {
                  if (Board_Dise.getChildAt(i).name == "But") {
                     if (Board_Dise.getChildAt(i).Estado == "Libre") {
                        Count_Libres++;
                     }
                     Count_But++;
                     Board_Dise.getChildAt(i).Id_Butaca=Count_But;
                     myXML=My_Xml.Insert_But(Polygon_Arreglo[Index],Board_Dise.getChildAt(i),myXML);
                  }
               }
               Polygon_Arreglo[Index].Polygon_But_Totales = Count_But;
               Polygon_Arreglo[Index].Polygon_But_Libres = Count_Libres;
         
               myXML.Recinto[0].Secciones[0].Seccion[indexSecc].@But_Libres = Polygon_Arreglo[Index].Polygon_But_Libres;
               myXML.Recinto[0].Secciones[0].Seccion[indexSecc].@Num_Inv = int(Polygon_Arreglo[Index].Polygon_Num_Inv);
               
               /* Actualizamos las formas */
               delete myXML.Recinto[0].Secciones[0].Seccion[indexSecc].Figuras;
               nodeXML_Fig = new XML();
               nodeXML_Fig = <Figuras />;
               myXML.Recinto[0].Secciones[0].Seccion[indexSecc].appendChild(nodeXML_Fig);
               
               for(i=0; i <Polygon_Arreglo_Formas_Dise.length; i++) actualizar_formas_dise(indexSecc, i);
               
               /* Actualizamos las etiquetas */
               delete myXML.Recinto[0].Secciones[0].Seccion[indexSecc].Etiquetas;
               nodeXML_Etiq = new XML();
               nodeXML_Etiq = <Etiquetas />;
               myXML.Recinto[0].Secciones[0].Seccion[indexSecc].appendChild(nodeXML_Etiq);
               
               for(i=0; i < Label_Arreglo_Dise.length; i++) actualizar_etiquetas_dise(indexSecc, i);
               
               /* Actualizamos los gráficos */
               delete myXML.Recinto[0].Secciones[0].Seccion[indexSecc].Graficos;
               nodeXML_Graf = new XML();
               nodeXML_Graf = <Graficos />;
               myXML.Recinto[0].Secciones[0].Seccion[indexSecc].appendChild(nodeXML_Graf);
               
               for(i=0; i < Graphic_Arreglo_Dise.length; i++) actualizar_graficos_dise(indexSecc, i);
               
               if (!inputVarTemplate) pintarPoligonos();   
               actualize_mainInformation();
               msgSeccionSalvada();
            }
            else {
               msgErrSeccionSalvarButacasDuplicadas();
            }
         }
         else {
            dadesDetallGuardades = true;
            butacasListStr = "";
            idSecc = Polygon_Arreglo[Index].Polygon_Nombre_Array[0].id;
            numInv = int(Polygon_Arreglo[Index].Polygon_Num_Inv);
            
            count = 0;
            for (i = 0; i < Board_Dise.numChildren; i++) {
               if (Board_Dise.getChildAt(i).name == "But" && Board_Dise.getChildAt(i).But_Modificada) {
                  count++;
                  if (butacasListStr.length > 0) butacasListStr = butacasListStr + "&";
                  
                  butacasListStr = butacasListStr + Board_Dise.getChildAt(i).Id_Butaca + "," + Board_Dise.getChildAt(i).Estado + "," + Board_Dise.getChildAt(i).Angulo + "," +  + Board_Dise.getChildAt(i).Estado + "," + Board_Dise.getChildAt(i).Calidad;   
                  Board_Dise.getChildAt(i).But_Modificada = false;
               }
            }
            
            if (count > 0) {
               /* Llamada al fichero php para realizar los cambios en la base de datos */
               var request:URLRequest = new URLRequest(My_Var_In_sEditor.getInstance().HTTP_SEditor + "flash_updateXML.php");
               request.method = URLRequestMethod.POST;
               
               var vars:URLVariables = new URLVariables();
               vars.idSeccion = idSecc;
               vars.idAforament = inputVarId;
               vars.numInvertida = numInv;
               
               vars.butacasModificadas = butacasListStr;
               request.data = vars;
               
               Object(Marco_Dise).Btn_Volver.enabled = false;
               Object(Marco_Dise).Btn_Mover.enabled = false;
               Object(Marco_Dise).Btn_Salvar.enabled = false;

               var loader:URLLoader = new URLLoader (request);
               loader.dataFormat = URLLoaderDataFormat.TEXT;
               loader.addEventListener(Event.COMPLETE, onCompleteUpdate);
               loader.load(request);
            }
            else msgSeccionSalvada();
         }
         
         function onCompleteUpdate(event:Event):void {
            var output:URLVariables = new URLVariables(event.target.data);
         
            if (output.updatedb.length == 0) { 
               var Count_But:int=0;
               var Count_Libres:Number=0;
               for (i = 0; i<Board_Dise.numChildren; i++) {
                  if (Board_Dise.getChildAt(i).name == "But") {
                     if (Board_Dise.getChildAt(i).Estado == "Libre") {
                        Count_Libres++;
                     }
                     Count_But++;
                     //myXML.Recinto[0].Secciones[0].Seccion[Index].Butacas[0]._Butaca[Board_Dise.getChildAt(i).Id_Butaca].@E = Board_Dise.getChildAt(i).Estado;
                     //myXML.Recinto[0].Secciones[0].Seccion[Index].Butacas[0]._Butaca[Board_Dise.getChildAt(i).Id_Butaca].@A = Board_Dise.getChildAt(i).Angulo;
                  }
               }
               Polygon_Arreglo[Index].Polygon_But_Totales = Count_But;
               Polygon_Arreglo[Index].Polygon_But_Libres = Count_Libres;
               myXML.Recinto[0].Secciones[0].Seccion[Index].@But_Libres = Polygon_Arreglo[Index].Polygon_But_Libres;
               
               if (!inputVarTemplate) pintarPoligonos();   
               actualize_mainInformation();
               msgSeccionSalvada();
            }
            else {
               msgErrSeccionUpdate(output.updatedb, Board_Dise, Marco_Dise);
            }
            Object(Marco_Dise).Btn_Volver.enabled = true;
            Object(Marco_Dise).Btn_Mover.enabled = true;
            Object(Marco_Dise).Btn_Salvar.enabled = true;
         }
      }
      
      /* @Popup al pulsar el boton de salvar sección en modo limitado 
                respuesta con error -> mensaje informativo */
      public function msgErrSeccionUpdate(labelStr:String, Board_Dise:Object, Marco_Dise:Sprite):void {
         var _Block01:Block = new Block();
         var metodo1:Function;

         addChild(_Block01);
         _Block01.alpha = 0.9;
         errorUpdate = new Alerta_ErrorUpdate();
         addChild(errorUpdate);
         errorUpdate.x = (stage.stageWidth / 2) - (errorUpdate.width / 2);
         errorUpdate.y = (stage.stageHeight / 2) - (errorUpdate.height / 2);
         
         metodo1 = function(e:MouseEvent) { 
                      removeChild(errorUpdate);
                      removeChild(_Block01);
                      _btn_Retornar(new MouseEvent(MouseEvent.MOUSE_DOWN), Board_Dise_Zoom_Point, Board_Dise, Marco_Dise);

                      reiniciarVariables();
                      loadXmlFromPhp(My_Var_In_sEditor.getInstance().HTTP_SEditor + "flash_loadXML.php", inputVarId);
                   };
         
         errorUpdate.Label_ErrReserva.text = labelStr;
         errorUpdate.Btn_Aceptar.addEventListener(MouseEvent.MOUSE_DOWN, metodo1);
      }
      
      private function existenButacasFCDuplicadas(Board_Dise:Object):Boolean {
         var i:int;
         var j:int;
         var duplicado:Boolean;
         
         duplicado = false;
         for (i = 0; ((i < Board_Dise.numChildren) && (!duplicado)); i++) {
            if (Board_Dise.getChildAt(i).name == "But") {
                   for (j = 0; ((j < Board_Dise.numChildren) && (!duplicado)); j++) {
                  if ((Board_Dise.getChildAt(j).name == "But") && (i != j)) {
                    if ((Board_Dise.getChildAt(i).Fila == Board_Dise.getChildAt(j).Fila) && (Board_Dise.getChildAt(i).Columna == Board_Dise.getChildAt(j).Columna)) duplicado = true;
                 }
               }
            }
         }
         
         return duplicado;
      }
      
      private function _Board_Scroll(e:MouseEvent, Board_Dise:Object) {
         if (e.delta<0) {
            Board_Dise.scaleX=Board_Dise.scaleX*1.09;
            Board_Dise.scaleY=Board_Dise.scaleX*1.09;

         } else {
            Board_Dise.scaleX=Board_Dise.scaleX/1.09;
            Board_Dise.scaleY=Board_Dise.scaleY/1.09;
         }
      }
      
      private function _Board_Ppal_Scroll(e:MouseEvent) {
         if (e.delta<0) {
            Board_Zoom_Point.scaleX=Board_Zoom_Point.scaleX*1.09;
            Board_Zoom_Point.scaleY=Board_Zoom_Point.scaleY*1.09;
         } else {
            Board_Zoom_Point.scaleX=Board_Zoom_Point.scaleX/1.09;
            Board_Zoom_Point.scaleY=Board_Zoom_Point.scaleY/1.09;
         }
      }
      
      private function _Menu_Board_Dise_Marcar_Todas(Event:ContextMenuEvent, Board_Dise:Object){
         But_Acciones = new AccionesButacas();
         But_Acciones.Marcar_Todas_Butacas(Board_Dise);
      }
      
      private function _Menu_Board_Dise_Desmarcar(Event:ContextMenuEvent, Board_Dise:Object) {
         But_Acciones = new AccionesButacas();
         But_Acciones.Desmarcar_Butacas(Board_Dise);
      }
      
      private function _Eliminar_Butacas(Event:ContextMenuEvent, Board_Dise:Object, Marco_Dise:Object, index:int) {
         var Papelera:Array=[];
         var Laton:Sprite=new Sprite;
         var targetObj:Object;
         
         if (Event.mouseTarget.name == "But") { 
            targetObj = Event.mouseTarget;
            targetObj.But_Marcada = true;
            targetObj.But_Move = false;
         }
         
         dadesDetallGuardades = false;
         Board_Dise.addChild(Laton);
         for (var i:int=2; i<Board_Dise.numChildren; i++) {
            if (Board_Dise.getChildAt(i).name=="But") {
               if (Board_Dise.getChildAt(i).But_Marcada==true) {
                  Papelera.push(Board_Dise.getChildAt(i));
               }
            }
         }
         for (var j:int=0; j<Papelera.length; j++) {
            Laton.addChild(Papelera[j]);
         }
         Board_Dise.removeChild(Laton);
         My_Coord.Refrescar(Board_Dise);
         
         actualize_diseInformation(Board_Dise, Marco_Dise, index, false);
      }

      public function _btn_Retornar(e:MouseEvent,Board_Dise_Zoom_Point:Sprite,Board_Dise:Object, Marco_Dise:Sprite) {
         polygon_mouseOver = false;
         
         if (dadesDetallGuardades) {
            dadesDetallGuardades = false; 
            Board_Mini.visible = true;
               
            var index:int = Buscar_en_Arreglo(Polygon_Arreglo,My_Var_In_sEditor.getInstance().Seccion_Edit);
            My_Var_In_sEditor.getInstance().Seccion_Edit = null;

            /* Remove events Listeners */
            Menu_Board_Dise_Marcar_Todas.removeEventListener(ContextMenuEvent.MENU_ITEM_SELECT,Metodo_Menu_Board_Dise_Marcar_Todas);
            Menu_Board_Dise_Desmarcar.removeEventListener(ContextMenuEvent.MENU_ITEM_SELECT,Metodo_Menu_Board_Dise_Desmarcar);
            Menu_Board_Dise_Eliminar.removeEventListener(ContextMenuEvent.MENU_ITEM_SELECT,Eliminar_Butacas);
            Menu_Board_Dise_Propiedades.removeEventListener(ContextMenuEvent.MENU_ITEM_SELECT, Metodo_But_Propiedades_no_dc);
            
            removeChild(Marco_Dise);
            Object(Board_Dise_Zoom_Point).removeChild(Board_Dise);
            removeChild(Board_Dise_Zoom_Point);
            reiniciarVariablesGlobales();
            My_Var_In_sEditor.getInstance().Vista_Actual = Board;
            My_Var_In_sEditor.getInstance().Vista_Recinto = true;
            
            for (var i:int=0; i<Polygon_Arreglo.length; i++) {
               Polygon_Arreglo[i].alpha=1;
            }
            for (var k:int=0; k<Polygon_Arreglo_Formas.length; k++) {
               Polygon_Arreglo_Formas[k].alpha=1;
            }
            
            Mini_Mapa_Crear();
            Board.visible = true;
            Herramientas_Ppal.visible = true;
            centrar_vistaRecinto(Board);
         }
         else {
            var _Block01:Block = new Block();
            addChild(_Block01);
            _Block01.alpha = 0.9;
   
            var Form_ConfirmacionSalir:Alerta_Confirmacion_Salir = new Alerta_Confirmacion_Salir();
            Form_ConfirmacionSalir.Btn_Aceptar.addEventListener(MouseEvent.MOUSE_DOWN, Aceptar_Salir);
            Form_ConfirmacionSalir.Btn_Cancelar.addEventListener(MouseEvent.MOUSE_DOWN, Cancelar_Salir);
            addChild(Form_ConfirmacionSalir);
            centrar_Alerta(Form_ConfirmacionSalir);
   
            function Aceptar_Salir(e:MouseEvent) {
               removeChild(_Block01);
               removeChild(Form_ConfirmacionSalir);
               
               Board_Mini.visible = true;
               
               var index:int = Buscar_en_Arreglo(Polygon_Arreglo, My_Var_In_sEditor.getInstance().Seccion_Edit);
               My_Var_In_sEditor.getInstance().Seccion_Edit = null;
               
               /* Remove events Listeners */
               Menu_Board_Dise_Marcar_Todas.removeEventListener(ContextMenuEvent.MENU_ITEM_SELECT,Metodo_Menu_Board_Dise_Marcar_Todas);
               Menu_Board_Dise_Desmarcar.removeEventListener(ContextMenuEvent.MENU_ITEM_SELECT,Metodo_Menu_Board_Dise_Desmarcar);
               Menu_Board_Dise_Eliminar.removeEventListener(ContextMenuEvent.MENU_ITEM_SELECT,Eliminar_Butacas);
               Menu_Board_Dise_Propiedades.removeEventListener(ContextMenuEvent.MENU_ITEM_SELECT, Metodo_But_Propiedades_no_dc);
               
               removeChild(Marco_Dise);
               Object(Board_Dise_Zoom_Point).removeChild(Board_Dise);
               removeChild(Board_Dise_Zoom_Point);
               reiniciarVariablesGlobales();
               My_Var_In_sEditor.getInstance().Vista_Actual = Board;
               My_Var_In_sEditor.getInstance().Vista_Recinto = true;
               
               for (var i:int=0; i<Polygon_Arreglo.length; i++) {
                  Polygon_Arreglo[i].alpha = 1;
               }
               for (var k:int=0; k<Polygon_Arreglo_Formas.length; k++) {
                  Polygon_Arreglo_Formas[k].alpha=1;
               }
            
               Mini_Mapa_Crear();
               Board.visible = true;
               Herramientas_Ppal.visible = true;
               centrar_vistaRecinto(Board);
            }
            
            
            function Cancelar_Salir(e:MouseEvent) {
               removeChild(_Block01);
               removeChild(Form_ConfirmacionSalir);
            }
         }
      }
      
      public function _btn_MoverSeccion(e:MouseEvent, Board_Dise:Object, Marco_Dise:Object) {
         
         if (bloqueadoDesplazamientoVistaDiseño) {
            desplazarVistaSeccionImagen(true);
            
            My_Var_In_sEditor.getInstance().Mover_Seccion = true;
            
            cambiarDiseEstadoBotones(false, btn_seccionMover);
            
            mostrarMenusObjetos(false, false);
            
            bloqueadoDesplazamientoVistaDiseño = false;
         }
         else { 
            desplazarVistaSeccionImagen(false);
            
            My_Var_In_sEditor.getInstance().Mover_Seccion = false;
            
            cambiarDiseEstadoBotones(true, btn_seccionMover);
            
            mostrarMenusObjetos(false, true);
            
            Mouse.cursor = MouseCursor.ARROW;
            bloqueadoDesplazamientoVistaDiseño = true;
         } 
      }
      
      public function desplazarVistaSeccionImagen(permit:Boolean):void {
         if (permit) img_Mover.source = My_Var_In_sEditor.getInstance().HTTP_SEditor + "images/mtools_lockoff.png";
         else img_Mover.source = My_Var_In_sEditor.getInstance().HTTP_SEditor + "images/mtools_lockon.png"; 
      }
      
      private function Butacas_Diseño(e:MouseEvent,Board_Dise:Object,Marco_Dise:Object, But_Arreglo:Array, Index:int, No_Butacas:int, N_Filas:int, N_Columnas:int) {
         cambiarDiseEstadoBotones(false);
         
         mostrarMenusObjetos(false, false);
         dadesDetallGuardades = false;
         But_Acciones = new AccionesButacas();
         Carrito=new Sprite();

         Carrito.graphics.beginFill(0xFFFFFF,1);
         Carrito.graphics.drawCircle(0, 0, 10);
         Carrito.graphics.endFill();
         Board_Dise.addChildAt(Carrito,1);
         Carrito.visible=false;
         
         But_Arreglo=But_Arreglo.splice(But_Arreglo.length);
         var My_But:But;
         var Metodo_But_Propiedades:Function = function(e:Object, doubleClick:Boolean) { _Metodo_But_Propiedades(e, Board_Dise, Marco_Dise, Index, doubleClick) };
         var Metodo_But_Propiedades_dc:Function = function(e:Object) { Metodo_But_Propiedades(e, true) };
         
         var But_Int:Function=function (e:MouseEvent){_But_Int(e,My_But, No_Butacas)};
            
         Carrito.visible=true;
         var Point_0:Point=new Point(0,0);
         for (var FC_F:int=0; FC_F<N_Columnas; FC_F++) {
            for (var FC_C:int=0; FC_C<N_Filas; FC_C++) {
               My_But= new But();
               My_But.But_Marcada=false;
               My_But.x=Point_0.x+(30*FC_F);
               My_But.y=Point_0.y+(30*FC_C);
               My_But.addEventListener(MouseEvent.MOUSE_OVER, But_Act);
               My_But.addEventListener(MouseEvent.MOUSE_OUT, But_DesAct);
               My_But.addEventListener(MouseEvent.DOUBLE_CLICK, Metodo_But_Propiedades_dc);
               Board_Dise.addChild(Carrito);
               Carrito.addChild(My_But);
               My_But.doubleClickEnabled=true;
               My_But.name="But";
               My_But.Fila="0";
               My_But.Columna="0";
               My_But.Estado="Libre";
               My_But.Angulo=0;
               My_But.Calidad=100;
               My_But.gotoAndStop(1);
               But_Arreglo.push(My_But);
            }
         }
         var Carro_Mover:Function=function(e:MouseEvent){_Carrito_Mover(e,Carrito, But_Arreglo[0])};
         Carrito.parent.addEventListener(MouseEvent.MOUSE_MOVE, Carro_Mover);
         var Carro_Click:Function=function(e:MouseEvent){_Carrito_Click(e,Carro_Mover, But_Arreglo, Board_Dise, Carrito, Point_0, Carro_Click, Index, Marco_Dise, N_Filas, N_Columnas)};
         Carrito.addEventListener(MouseEvent.CLICK, Carro_Click);
         But_Acciones.Desmarcar_Butacas(Board_Dise);
      }
      
      /* @Evento llamado al pulsar la opción del menú contextual de propiedades de las butacas */
      private function _Metodo_But_Propiedades(e:Object, Board_Dise:Object, Marco_Dise:Object, index:int, doubleClick:Boolean) {
         var targetObj:Object;
         var butacaMin:Array;
         var butacaMax:Array;
         var permitirAbrirPropiedades:Boolean = false;
         
         _Block_But_Propiedades = new Block();
         _Form_But_Propiedades = new Form_But_Propiedades();
         _Block_But_Propiedades.alpha = 0.9;
         _Form_But_Propiedades.visible = false;
         _Block_But_Propiedades.visible = false;         
         stage.addChild(_Block_But_Propiedades);
         stage.addChild(_Form_But_Propiedades);
         centrar_Alerta(_Form_But_Propiedades);
         
         _Form_But_Propiedades.Err_PropiedadesFilaCol.visible = false;
         _Form_But_Propiedades.Err_PropiedadesPasosNumerico.visible = false;
         _Form_But_Propiedades.Err_PropiedadesAnguloNumerico.visible = false;
         _Form_But_Propiedades.Err_PropiedadesModoRes.visible = false;
         _Form_But_Propiedades.Err_PropiedadesCalidad.visible = false;
         
         if (doubleClick) targetObj = e.target;
         else targetObj = e.mouseTarget;
         
         if (targetObj.name == "But") {
            targetObj.But_Marcada = true;
            targetObj.But_Move = false;
            refrescar_numButacasSeleccionadas(Board_Dise);
            But_Acciones.Resaltar_Butaca(targetObj);
         }
         else {
            But_Acciones = new AccionesButacas();         
            But_Acciones.Contar_Butacas(Board_Dise);      
         }
         
         if (My_Var_In_sEditor.getInstance().Butacas_Marcadas > 0) {
            butacaMin = But_Acciones.get_ButacaMin(Board_Dise);
            butacaMax = But_Acciones.get_ButacaMax(Board_Dise);
         
            if ((butacaMax[0] - butacaMin[0] < My_Var_In_sEditor.getInstance().Numero_MaxElem_Propiedades_Columna) && (butacaMax[1] - butacaMin[1] < My_Var_In_sEditor.getInstance().Numero_MaxElem_Propiedades_Fila)) permitirAbrirPropiedades = true;

            if (permitirAbrirPropiedades) {
               _Form_But_Propiedades.visible = true;
               _Block_But_Propiedades.visible = true;
               
               _Form_But_Propiedades.Filas_Pasos.enabled = true;
               _Form_But_Propiedades.Columnas_Pasos.enabled = true;
                  
               /* Seleccionamos la butaca seleccionada de forma manual */
               if (targetObj.name != "But") {
                  targetObj = My_Var_In_sEditor.getInstance().Ultima_Butaca_Marcada;
               }
               
               _Form_But_Propiedades.Filas_Pasos.text = '1';
               _Form_But_Propiedades.Columnas_Pasos.text = '1';
               Fila_Pasos_Valor = '1';
               Columna_Pasos_Valor = '1';
               Invertir_Numeracion = false;
               
               if (My_Var_In_sEditor.getInstance().Butacas_Marcadas > 1) {
                  _Form_But_Propiedades.Filas_Inp.text = '';
                  Fila_Valor = '';
                  _Form_But_Propiedades.Columnas_Inp.text = '';
                  Columna_Valor = '';
                  
                  _Form_But_Propiedades.Calidad_Inp.text = '';
                  Calidad_Valor = '';
                  
                  _Form_But_Propiedades.Angulo_Inp.text = '0';
                  Angulo_Valor = 0;
                  
                  _Form_But_Propiedades.Estado_Inp.selectedIndex = 0;
                  Estado_But="Libre";
               }
               else {
                  _Form_But_Propiedades.Filas_Inp.text = targetObj.Fila;
                  _Form_But_Propiedades.Columnas_Inp.text = targetObj.Columna;
                  _Form_But_Propiedades.Angulo_Inp.text = targetObj.Angulo;
                  
                  _Form_But_Propiedades.Calidad_Inp.text = targetObj.Calidad;
                  _Form_But_Propiedades.Filas_Pasos.enabled = false;
                  _Form_But_Propiedades.Columnas_Pasos.enabled = false;
                  
                  Fila_Valor = targetObj.Fila;
                  Columna_Valor = targetObj.Columna;
                  Angulo_Valor = targetObj.Angulo;
                  Calidad_Valor = targetObj.Calidad;
                  
                  if (targetObj.Estado == "Libre") {
                     _Form_But_Propiedades.Estado_Inp.selectedIndex = 0;
                     Estado_But = "Libre";
                  }
                  if (targetObj.Estado == "Ocupada") {
                     _Form_But_Propiedades.Estado_Inp.selectedIndex = 1;
                     Estado_But = "Ocupada";
                  }
                  if (targetObj.Estado == "Reservada") {
                     _Form_But_Propiedades.Estado_Inp.selectedIndex = 2;
                     Estado_But = "Reservada";
                  }
                  if (targetObj.Estado == "Averiada") {
                     _Form_But_Propiedades.Estado_Inp.selectedIndex = 3;
                     Estado_But = "Averiada";
                  }
               }
               
               if (inputVarLocked) {
                  _Form_But_Propiedades.Filas_Pasos.enabled = false;
                  _Form_But_Propiedades.Columnas_Pasos.enabled = false;
                  _Form_But_Propiedades.Filas_Inp.text = '';
                  Fila_Valor = '';
                  _Form_But_Propiedades.Filas_Inp.enabled = false;
                  _Form_But_Propiedades.Columnas_Inp.text = '';
                  Columna_Valor = '';
                  _Form_But_Propiedades.Columnas_Inp.enabled = false;                  
               }
               
               _Form_But_Propiedades.Estado_Inp.addEventListener(Event.CHANGE, Combo_Estado);
               _Form_But_Propiedades.Filas_Inp.addEventListener(Event.CHANGE, Fila_Change);
               _Form_But_Propiedades.Columnas_Inp.addEventListener(Event.CHANGE, Columna_Change);
               _Form_But_Propiedades.Angulo_Inp.addEventListener(Event.CHANGE, Angulo_Change);
               _Form_But_Propiedades.Calidad_Inp.addEventListener(Event.CHANGE, Calidad_Change);
               _Form_But_Propiedades.Filas_Pasos.addEventListener(Event.CHANGE, Fila_Pasos_Change);
               _Form_But_Propiedades.Columnas_Pasos.addEventListener(Event.CHANGE, Columna_Pasos_Change);
               _Form_But_Propiedades.InvertirNumeracion.addEventListener(Event.CHANGE, Invertir_Change);
                                                               
               function Form_But_Propiedades_Cancelar() {
                  stage.removeChild(_Block_But_Propiedades);
                  _Form_But_Propiedades.Estado_Inp.close();
                  stage.removeChild(_Form_But_Propiedades);
               }
   
               function Form_But_Propiedades_Aceptar() {
                  _Form_But_Propiedades.Err_PropiedadesFilaCol.visible = false;
                  _Form_But_Propiedades.Err_PropiedadesPasosNumerico.visible = false;
                  _Form_But_Propiedades.Err_PropiedadesAnguloNumerico.visible = false;
                  _Form_But_Propiedades.Err_PropiedadesModoRes.visible = false;
                  _Form_But_Propiedades.Err_PropiedadesCalidad.visible = false;
                  
                  Fila_Valor = Fila_Valor.toUpperCase();
                  Columna_Valor = Columna_Valor.toUpperCase();
                  if (((inputVarLocked) && (permitirCambioEstadoRes(Board_Dise, Estado_But))) || (!inputVarLocked)) {
                     if ((_Form_But_Propiedades.Angulo_Inp.text.length > 0) && (!isNaN(Number(_Form_But_Propiedades.Angulo_Inp.text))) && ((!isNaN(Number(Fila_Valor))) || (Fila_Valor.length <= 1)) && ((!isNaN(Number(Columna_Valor))) || (Columna_Valor.length <= 1)) && (!isNaN(Number(Fila_Pasos_Valor))) && (!isNaN(Number(Columna_Pasos_Valor)))) {    
                        if ((((Fila_Valor.length == 1) && (isNaN(Number(Fila_Valor))) && (Fila_Valor.charCodeAt(0) >= 65) && (Fila_Valor.charCodeAt(0) <= 90)) || !isNaN(Number(Fila_Valor))) && (((Columna_Valor.length == 1) && (isNaN(Number(Columna_Valor))) && (Columna_Valor.charCodeAt(0) >= 65) && (Columna_Valor.charCodeAt(0) <= 90)) || !isNaN(Number(Columna_Valor)))) {
                           if ((((Fila_Valor.length > 0) && (Fila_Pasos_Valor.length > 0)) || (Fila_Valor.length == 0)) && (((Columna_Valor.length > 0) && (Columna_Pasos_Valor.length > 0)) || (Columna_Valor.length == 0))) {
                              if ((((Fila_Valor.length > 0) && (Number(Fila_Valor) > 0)) || (Fila_Valor.length == 0) || isNaN(Number(Fila_Valor))) && (((Columna_Valor.length > 0) && (Number(Columna_Valor) > 0)) || (Columna_Valor.length == 0) || isNaN(Number(Columna_Valor)))) {
                                 if ((Calidad_Valor.length == 0) || (Calidad_Valor.length > 0) && (!isNaN(Number(Calidad_Valor))) && ((Number(Calidad_Valor) >= 0) && (Number(Calidad_Valor) <= 100))) {
                                    dadesDetallGuardades = false;
                              
                                    stage.removeChild(_Block_But_Propiedades);
                                    _Form_But_Propiedades.Estado_Inp.close();
                                    stage.removeChild(_Form_But_Propiedades);
                                    var Cambiar:Array=[];
                                    Cambiar.push({F:Fila_Valor,C:Columna_Valor,E:Estado_But,A:Angulo_Valor,FP:Fila_Pasos_Valor,CP:Columna_Pasos_Valor,I:Invertir_Numeracion,Q:Calidad_Valor});
                                    But_Acciones.Cambiar(Board_Dise, Cambiar);
                                    But_Acciones.Marcar_Butacas_Modificadas(Board_Dise);
                                    But_Acciones.Desmarcar_Butacas(Board_Dise);
                                    
                                    actualize_diseInformation(Board_Dise, Marco_Dise, index, false);
                                 }
                                 else _Form_But_Propiedades.Err_PropiedadesCalidad.visible = true;
                              }
                              else _Form_But_Propiedades.Err_PropiedadesFilaCol.visible = true;
                           }
                           else _Form_But_Propiedades.Err_PropiedadesPasosNumerico.visible = true;
                        }
                        else _Form_But_Propiedades.Err_PropiedadesFilaCol.visible = true;
                     }
                     else if (((isNaN(Number(Fila_Valor))) && (Fila_Valor.length > 0)) || ((isNaN(Number(Columna_Valor))) && (Columna_Valor.length > 0))) {
                        _Form_But_Propiedades.Err_PropiedadesFilaCol.visible = true;
                     }
                     else if (isNaN(Number(Fila_Pasos_Valor)) || isNaN(Number(Columna_Pasos_Valor))) {
                        _Form_But_Propiedades.Err_PropiedadesPasosNumerico.visible = true;
                     }
                     else if ((_Form_But_Propiedades.Angulo_Inp.text.length == 0) || (isNaN(Number(_Form_But_Propiedades.Angulo_Inp.text)))) {
                        _Form_But_Propiedades.Err_PropiedadesAnguloNumerico.visible = true;
                     }
                  }
                  else {
                     _Form_But_Propiedades.Err_PropiedadesModoRes.visible = true;
                  }
               }
               
               _Form_But_Propiedades.Btn_Aceptar.addEventListener(MouseEvent.MOUSE_DOWN, Form_But_Propiedades_Aceptar);
               _Form_But_Propiedades.Btn_Cancelar.addEventListener(MouseEvent.MOUSE_DOWN, Form_But_Propiedades_Cancelar);
               
               if (My_Var_In_sEditor.getInstance().Butacas_Marcadas > 1) {
                  if ((But_Acciones.Comprobar(Board_Dise)[0].F != "Y") || (But_Acciones.Comprobar(Board_Dise)[0].C != "Y")) {
                     if (But_Acciones.Comprobar(Board_Dise)[0].F=="Y") {
                        _Form_But_Propiedades.Columnas_Pasos.enabled = false;
                     }
                     if (But_Acciones.Comprobar(Board_Dise)[0].C=="Y") {
                        _Form_But_Propiedades.Filas_Pasos.enabled = false;
                     }
                  }
               }
            }
            else {
               msgErrPropiedades();
            }
         }
      }
      
      private function permitirCambioEstadoRes(Board_Dise:Object, estadoCambiar:String) {
         var i:int;
         var err:Boolean;
         
         err = false;
         for (i = 0; ((i < Board_Dise.numChildren) && (!err)); i++) {
            if (Board_Dise.getChildAt(i).name != undefined && Board_Dise.getChildAt(i).name == "But" && Board_Dise.getChildAt(i).But_Marcada == true) {
               if ((Board_Dise.getChildAt(i).Estado == "Ocupada") || (estadoCambiar == "Ocupada")) err = true;
            }
         }
         return !err;
      }
      
      private function Fila_Pasos_Change(event:Event) { Fila_Pasos_Valor = event.target.text; }
      private function Columna_Pasos_Change(event:Event) { Columna_Pasos_Valor = event.target.text; }
      private function Fila_Change(event:Event) { Fila_Valor = event.target.text; }
      private function Columna_Change(event:Event) { Columna_Valor = event.target.text; }
      private function Angulo_Change(event:Event) { Angulo_Valor = event.target.text; }
      private function Calidad_Change(event:Event) { Calidad_Valor = event.target.text; }
      private function Combo_Estado(event:Event):void { Estado_But = event.target.selectedItem.label; }
      private function Invertir_Change(event:Event):void { Invertir_Numeracion = event.target.selected; }
      
      private function But_Act(e:MouseEvent) {
         But_Acciones = new AccionesButacas();
         But_Acciones.Resaltar_Butaca(e.target);
         
         if (stage.mouseX + 10 + But_Inf_Globo.width < stage.stageWidth) But_Inf_Globo.x = stage.mouseX + 10;
         else But_Inf_Globo.x = stage.mouseX + 10 - ((stage.mouseX + 10 + But_Inf_Globo.width) - stage.stageWidth);
         
         if (stage.mouseY - 10 - But_Inf_Globo.height > 39) But_Inf_Globo.y = stage.mouseY - But_Inf_Globo.height - 10;
         else But_Inf_Globo.y = stage.mouseY + 10;
                 
         But_Inf_Globo.Fila_Inf.text = e.target.Fila;
         But_Inf_Globo.Col_Inf.text = e.target.Columna;
         But_Inf_Globo.visible = true;
         addChild(But_Inf_Globo);
         e.target.addEventListener(MouseEvent.MOUSE_MOVE, But_Info);
         if (!inputVarLocked) Mouse.cursor = MouseCursor.HAND;
         else Mouse.cursor = MouseCursor.BUTTON;
      }
      
      private function But_Info(e:MouseEvent) {
         if (stage.mouseX + 10 + But_Inf_Globo.width < stage.stageWidth) But_Inf_Globo.x = stage.mouseX + 10;
         else But_Inf_Globo.x = stage.mouseX + 10 - ((stage.mouseX + 10 + But_Inf_Globo.width) - stage.stageWidth);
         
         if (stage.mouseY - 10 - But_Inf_Globo.height > 39) But_Inf_Globo.y = stage.mouseY - But_Inf_Globo.height - 10;
         else But_Inf_Globo.y = stage.mouseY + 10;
      }
      
      private function But_DesAct(e:MouseEvent) {
         if (e.target.But_Marcada == false) {
            But_Acciones = new AccionesButacas();
            But_Acciones.Resaltar_Del_Butaca(e.target);
         }
         But_Inf_Globo.visible = false;
         Mouse.cursor = MouseCursor.ARROW;
      }
      
      private function _Carrito_Mover(e:MouseEvent, Carrito:Object, My_But:Object) {
         Carrito.x=int(Carrito.parent.mouseX / (My_But.width/4)) * (My_But.width/4);
         Carrito.y=int(Carrito.parent.mouseY / (My_But.height/4)) * (My_But.height/4);
      }
      
      private function _Carrito_Click(e:MouseEvent, Carro_Mover:Function, But_Arreglo:Array, Board_Dise:Object, Carrito:Object, Point_0:Point, Carro_Click:Function, Index:int, Marco_Dise:Object, N_Filas:int, N_Columnas:int) {
         var maxFila:int;
         var maxColumna:int;
         
         But_Arreglo=But_Arreglo.splice(But_Arreglo.length);
         for (var j:int=0; j<Carrito.numChildren; j++) {
            But_Arreglo[j]=Carrito.getChildAt(j);
         }
         But_Arreglo[0].x=Carrito.x;
         But_Arreglo[0].y=Carrito.y;
         But_Arreglo[0].x=((int(((2490+But_Arreglo[0].x)/30))*30)+15)-2490;
         But_Arreglo[0].y=((int(((2490+But_Arreglo[0].y)/30))*30)+15)-2490;
         But_Arreglo[0].addEventListener(MouseEvent.MOUSE_DOWN, But_Down);
         var But_UP:Function=function(evento:MouseEvent){_But_Up(evento, Board_Dise)};
         But_Arreglo[0].addEventListener(MouseEvent.MOUSE_UP, But_UP);
         var Count_But:int=0;
         var nFilas:int = getMaxNumFilaSeccion(Board_Dise);
         var nColumnas:int = getMaxNumColumnaSeccion(Board_Dise);
         if ((N_Columnas > 0) || (N_Filas > 0)) {
            for (var FC_F:int=0; FC_F<int(N_Columnas); FC_F++) {
               for (var FC_C:int=0; FC_C<int(N_Filas); FC_C++) {
                  But_Arreglo[Count_But].x=But_Arreglo[0].x+(30*FC_F);
                  But_Arreglo[Count_But].y=But_Arreglo[0].y+(30*FC_C);
                  Board_Dise.addChild(But_Arreglo[Count_But]);
                  
                  But_Arreglo[Count_But].Fila = FC_C + (nFilas + 1);
                  But_Arreglo[Count_But].Columna = FC_F + (nColumnas + 1);
                  
                  But_Arreglo[Count_But].addEventListener(MouseEvent.MOUSE_DOWN, But_Down);
                  But_Arreglo[Count_But].addEventListener(MouseEvent.MOUSE_UP, But_UP);
                  Count_But++;
               }
            }
         }
         Board_Dise.removeEventListener(MouseEvent.MOUSE_MOVE, Carro_Mover);
         Board_Dise.removeChild(Carrito);
         But_Acciones = new AccionesButacas();
         But_Acciones.Desmarcar_Butacas(Board_Dise);
         My_Coord.Refrescar(Board_Dise);
         
         mostrarMenusObjetos(false, true);
         cambiarDiseEstadoBotones(true);
         
         actualize_diseInformation(Board_Dise, Marco_Dise, Index, false);
      }
   
      private function getMaxNumFilaSeccion(Board_Dise:Object):int {
         var numFila:int;
         var i:int;
         
         numFila = 0;
         for (i = 0; i<Board_Dise.numChildren; i++) {
            if (Board_Dise.getChildAt(i).name == "But") {
               if ((!isNaN(Number(Board_Dise.getChildAt(i).Fila))) && (numFila < (Number(Board_Dise.getChildAt(i).Fila)))) {
                  numFila = Number(Board_Dise.getChildAt(i).Fila);
               }
            }
         }
         return numFila;
      }
      
      private function getMaxNumColumnaSeccion(Board_Dise:Object):int {
         var numColumna:int;
         var i:int;
         
         numColumna = 0;
         for (i = 0; i<Board_Dise.numChildren; i++) {
            if (Board_Dise.getChildAt(i).name == "But") {
               if ((!isNaN(Number(Board_Dise.getChildAt(i).Columna))) && (numColumna < (Number(Board_Dise.getChildAt(i).Columna)))) {
                  numColumna = Number(Board_Dise.getChildAt(i).Columna);
               }
            }
         }
         return numColumna;
      }
      
      private function _But_Int(e:MouseEvent, My_But:Object, No_Butacas:int) {
         My_But.x = My_But.parent.mouseX;
         My_But.y = My_But.parent.mouseY;
      }

      /* Eventos de las butacas -> MouseDown, MouseUp, MouseClick */
      private function But_Down(e:MouseEvent) {
         e.target.parent.addChild(e.target);
         e.target.But_Marcada = true;

         if (!inputVarLocked) e.target.addEventListener(MouseEvent.MOUSE_MOVE, But_Mover);
      }
      
      private function But_Mover(e:MouseEvent) {
         if (My_Var_In_sEditor.getInstance().Mover_Seccion == false) {
            dadesDetallGuardades = false;
            My_Var_In_sEditor.getInstance().Mover_But = true;
            e.target.But_Mov = true;
            e.target.startDrag();
            
            if (My_Var_In_sEditor.getInstance().Butacas_Marcadas > 1) {
               But_Array = But_Array.splice(But_Array.length);
               
               if (e.target.Angulo != 0) { e.target.rotation = 0; }
               
               /* Mapeamos todas las butacas seleccionadas para realizar el movimiento */
               e.target.But_Marcada = false;
               for (var j:int=0; j < e.target.parent.numChildren; j++) {
                  if (e.target.parent.getChildAt(j).name == "But" && e.target.parent.getChildAt(j).But_Marcada == true) {
                     e.target.parent.getChildAt(j).difX=e.target.parent.getChildAt(j).x-e.target.x;
                     e.target.parent.getChildAt(j).difY=e.target.parent.getChildAt(j).y-e.target.y;
                     But_Array.push(e.target.parent.getChildAt(j));
                  }
               }
               e.target.But_Marcada = true;
               
               /* Ejecutamos la acción de moverlas */
               for (var i:int=0; i<But_Array.length; i++) {
                  e.target.addChild(But_Array[i]);
                  But_Array[i].x=But_Array[i].difX;
                  But_Array[i].y=But_Array[i].difY;
               }
            }
         }
      }
      
      private function _But_Up(e:MouseEvent, Board_Dise:Object) {
         if (My_Var_In_sEditor.getInstance().Mover_Seccion == false) {
            e.target.stopDrag();
            My_Var_In_sEditor.getInstance().Mover_But = false;
            
            e.target.x = ((int(((2490+Board_Dise.mouseX)/30))*30)+15)-2490;
            e.target.y = ((int(((2490+Board_Dise.mouseY)/30))*30)+15)-2490;
            e.target.removeEventListener(MouseEvent.MOUSE_MOVE, But_Mover);
            
            if (e.target.But_Mov == true) {
               if (My_Var_In_sEditor.getInstance().Butacas_Marcadas > 1) {
                  But_Array=But_Array.splice(But_Array.length);
                  for (var j:int=0; j<e.target.numChildren; j++) {
                     But_Array.push(e.target.getChildAt(j));
                  }
                  for (var H:int=0; H<But_Array.length; H++) {
                     Board_Dise.addChild(But_Array[H]);
                     But_Array[H].x=e.target.x+But_Array[H].x;
                     But_Array[H].y=e.target.y+But_Array[H].y;
                  }
                  if (e.target.Angulo!=0) {
                     e.target.rotation=int(e.target.Angulo)*-1;
                  }
               }
               e.target.But_Mov = false;
               
               My_Coord.Refrescar(Board_Dise);
            }
            if (!My_Var_In_sEditor.getInstance().ControlKey_Pressed) But_Acciones.Desmarcar_Butacas(Board_Dise);
         }
      }
      
      /* @Popup al seleccionar mas elementos de los permitidos 
                mensaje informativo                            */
      public function msgErrPropiedades():void {
         var _Block01:Block = new Block();
         var metodo1:Function;

         addChild(_Block01);
         _Block01.alpha = 0.9;
         errorPropiedades = new Alerta_ErrorPropiedades();
         addChild(errorPropiedades);
         errorPropiedades.x = (stage.stageWidth / 2) - (errorPropiedades.width / 2);
         errorPropiedades.y = (stage.stageHeight / 2) - (errorPropiedades.height / 2);
         
         metodo1 = function(e:MouseEvent) { 
                      removeChild(errorPropiedades);
                      removeChild(_Block01);
                   };
         
         errorPropiedades.Btn_Aceptar.addEventListener(MouseEvent.MOUSE_DOWN, metodo1);
      }
      
      /* @Popup al pulsar el boton de salvar recinto 
                mensaje informativo                   */
      public function msgRecintoSalvado():void {
         var _Block01:Block = new Block();
         var metodo1:Function;

         addChild(_Block01);
         _Block01.alpha = 0.9;
         recintoSalvado = new Alerta_SalvarRecinto();
         addChild(recintoSalvado);
         recintoSalvado.x = (stage.stageWidth / 2) - (recintoSalvado.width / 2);
         recintoSalvado.y = (stage.stageHeight / 2) - (recintoSalvado.height / 2);
         
         metodo1 = function(e:MouseEvent) { 
                      removeChild(recintoSalvado);
                      removeChild(_Block01);
                   };
         
         recintoSalvado.Btn_Aceptar.addEventListener(MouseEvent.MOUSE_DOWN, metodo1);
      }

      /* @Popup al pulsar el boton de salvar recinto 
                respuesta con error -> mensaje informativo */
      public function msgErrRecintoSalvar(labelStr:String):void {
         var _Block01:Block = new Block();
         var metodo1:Function;

         addChild(_Block01);
         _Block01.alpha = 0.9;
         errRecintoSalvar = new Alerta_ErrorSalvarRecinto();
         addChild(errRecintoSalvar);
         errRecintoSalvar.x = (stage.stageWidth / 2) - (errRecintoSalvar.width / 2);
         errRecintoSalvar.y = (stage.stageHeight / 2) - (errRecintoSalvar.height / 2);
         
         metodo1 = function(e:MouseEvent) { 
                      removeChild(errRecintoSalvar);
                      removeChild(_Block01);
                   };
         
         errRecintoSalvar.Label_ErrSalvar.text = labelStr;
         errRecintoSalvar.Btn_Aceptar.addEventListener(MouseEvent.MOUSE_DOWN, metodo1);
      }
      
      /* @Popup al pulsar el boton de salvar sección 
                mensaje informativo                   */
      public function msgSeccionSalvada():void {
         var _Block01:Block = new Block();
         var metodo1:Function;

         addChild(_Block01);
         _Block01.alpha = 0.9;
         seccionSalvada = new Alerta_SalvarSeccion();
         addChild(seccionSalvada);
         seccionSalvada.x = (stage.stageWidth / 2) - (seccionSalvada.width / 2);
         seccionSalvada.y = (stage.stageHeight / 2) - (seccionSalvada.height / 2);
         
         metodo1 = function(e:MouseEvent) { 
                      removeChild(seccionSalvada);
                      removeChild(_Block01);
                   };
         
         seccionSalvada.Btn_Aceptar.addEventListener(MouseEvent.MOUSE_DOWN, metodo1);
      }
      
      /* @Popup al pulsar el boton de salvar sección 
                error butacas duplicadas             */
      public function msgErrSeccionSalvarButacasDuplicadas():void {
         var _Block01:Block = new Block();
          var metodo1:Function;

         addChild(_Block01);
         _Block01.alpha = 0.9;
         errSeccionSalvarButacasFC = new Alerta_ErrorSalvarSeccionButacasFC();
         addChild(errSeccionSalvarButacasFC);
         errSeccionSalvarButacasFC.x = (stage.stageWidth / 2) - (errSeccionSalvarButacasFC.width / 2);
         errSeccionSalvarButacasFC.y = (stage.stageHeight / 2) - (errSeccionSalvarButacasFC.height / 2);
         
         metodo1 = function(e:MouseEvent) { 
                      removeChild(errSeccionSalvarButacasFC);
                      removeChild(_Block01);
                   };
         
         errSeccionSalvarButacasFC.Btn_Aceptar.addEventListener(MouseEvent.MOUSE_DOWN, metodo1);
      }
      
      /* @Popup al entrar en modo restringuido 
                mensaje informativo                   */
      public function msgRecintoRestringuido():void {
         var _Block01:Block = new Block();
         var metodo1:Function;

         addChild(_Block01);
         _Block01.alpha = 0.9;
         Alerta_RecintoBloq = new Alerta_RecintoBloqueado();
         addChild(Alerta_RecintoBloq);
         Alerta_RecintoBloq.x = (stage.stageWidth / 2) - (Alerta_RecintoBloq.width / 2);
         Alerta_RecintoBloq.y = (stage.stageHeight / 2) - (Alerta_RecintoBloq.height / 2);
         
         metodo1 = function(e:MouseEvent) { 
                      removeChild(Alerta_RecintoBloq);
                      removeChild(_Block01);
                   };
         
         Alerta_RecintoBloq.Btn_Aceptar.addEventListener(MouseEvent.MOUSE_DOWN, metodo1);
      }
      
      /* @Evento llamado cuando se selecciona la opción del menu contextual de renombrar polígono */
      public function Polygon_Renombrar(event:ContextMenuEvent):void {
         var Nombre_Out:String=event.contextMenuOwner.name;
         var _Block01:Block= new Block();
         addChild(_Block01);
         _Block01.alpha=0.9;
         Alerta_Renomb= new Renombrar();
         Alerta_Renomb.Err_NombreDuplicado.visible = false;
         Alerta_Renomb.Err_NombreLongitud.visible = false;
         addChild(Alerta_Renomb);
         Alerta_Renomb.x=(stage.stageWidth/2)-(Alerta_Renomb.width/2);
         Alerta_Renomb.y=(stage.stageHeight/2)-(Alerta_Renomb.height/2);
         metodo1=function(e:MouseEvent) { Alerta_Renomb_Aceptar(e,Nombre_Out,_Block01) };
         var metodoF:Function=function(e:MouseEvent){Alerta_Renomb_Cancelar(e,_Block01)};
         Alerta_Renomb.Btn_Aceptar.addEventListener(MouseEvent.MOUSE_DOWN,metodo1);
         Alerta_Renomb.Btn_Cancelar.addEventListener(MouseEvent.MOUSE_DOWN,metodoF);
      }
      
      public function Alerta_Renomb_Aceptar(e:MouseEvent, Nombre_Out:String, _Block01:Sprite) {
         var err:Boolean;
         err = false;

         if ((Alerta_Renomb.Nombre_Inp.text.length > 0) && (Alerta_Renomb.Nombre_Inp.text.length < Variables.LABEL_MAX_CHARACTERS)) {
            for (var i:int=0; ((i<Polygon_Arreglo.length) && (!err)); i++) {
               if (Polygon_Arreglo[i].name == Alerta_Renomb.Nombre_Inp.text) { err = true; }
            }
            
            if (!err) {
               Secc_Nom_Act(Nombre_Out,Alerta_Renomb.Nombre_Inp.text);
               removeChild(Alerta_Renomb);
               removeChild(_Block01);
            }
            else Alerta_Renomb.Err_NombreDuplicado.visible = true;
         }
         else Alerta_Renomb.Err_NombreLongitud.visible = true;
      }
      
      public function Alerta_Renomb_Cancelar(e:MouseEvent, _Block01:Sprite) {
         removeChild(Alerta_Renomb);
         removeChild(_Block01);
      }

      private function Polygon_Eliminar(event:ContextMenuEvent):void {
         var index:int=Buscar_en_Arreglo(Polygon_Arreglo,event.contextMenuOwner.name);
         Polygon_Arreglo[index].Polygon_Eliminado=true;
         if (!inputVarTemplate) eliminarPrecioDesc(Polygon_Arreglo[index].Polygon_But_Precio);
         My_Xml.Delete_Secc(Polygon_Arreglo[index], myXML);
         Polygon_Arreglo.splice(index,1);
         Board.removeChild(event.contextMenuOwner);
         if (!inputVarTemplate) pintarPoligonos();
         Mini_Mapa_Crear();
         actualize_mainInformation();
      }
      
      private function Eliminar_LabelFromObject(mainWindow:Boolean, obj:Object):void {
         var index:int;
         
         if (mainWindow) {
            index = Buscar_en_Arreglo(Label_Arreglo, obj.name);
            Label_Arreglo.splice(index, 1);
            Board.removeChild(DisplayObject(obj));
            myXML = My_Xml.Delete_Label(obj, myXML);
            Mini_Mapa_Crear();
         }
         else {
            index = Buscar_en_Arreglo(Label_Arreglo_Dise, obj.name);
            Label_Arreglo_Dise.splice(index, 1);
            Board_Dise.removeChild(DisplayObject(obj));
            dadesDetallGuardades = false;
         }
      }
      
      private function Eliminar_Label(event:ContextMenuEvent, mainWindow:Boolean):void { Eliminar_LabelFromObject(mainWindow, event.contextMenuOwner); }
      
      private function Eliminar_Grafico(event:ContextMenuEvent, mainWindow:Boolean):void {
         var index:int;
         
         if (mainWindow) {
            index = Buscar_en_Arreglo(Graphic_Arreglo, event.contextMenuOwner.name);
   
            Graphic_Arreglo.splice(index, 1);
            Board.removeChild(DisplayObject(event.contextMenuOwner));
            
            myXML = My_Xml.Delete_Graphic(event.contextMenuOwner, myXML);
            Mini_Mapa_Crear();
         }
         else {
            index = Buscar_en_Arreglo(Graphic_Arreglo_Dise, event.contextMenuOwner.name);
            Graphic_Arreglo_Dise.splice(index, 1);
            Board_Dise.removeChild(DisplayObject(event.contextMenuOwner));
            dadesDetallGuardades = false;
         }
      }
      
      private function Polygon_Eliminar_Forma(event:ContextMenuEvent):void {
         var index:int;
         if (My_Var_In_sEditor.getInstance().Vista_Recinto) {
            index = Buscar_en_Arreglo(Polygon_Arreglo_Formas,event.contextMenuOwner.name);
            Polygon_Arreglo_Formas[index].Polygon_Eliminado = true;

            My_Xml.Delete_Shape(Polygon_Arreglo_Formas[index], myXML);
            Polygon_Arreglo_Formas.splice(index, 1);
            Board.removeChild(event.contextMenuOwner);

            Mini_Mapa_Crear();
         }
         else {
            dadesDetallGuardades = false;
            index = Buscar_en_Arreglo(Polygon_Arreglo_Formas_Dise, event.contextMenuOwner.name);
            Polygon_Arreglo_Formas_Dise[index].Polygon_Eliminado = true;

            Polygon_Arreglo_Formas_Dise.splice(index, 1);
            Board_Dise.removeChild(event.contextMenuOwner);
         }
      }
      
      private function actualizar_vertices(Index:int):void {
         delete myXML.Recinto[0].Secciones[0].Seccion[Index].Vertices;
         var nodeXML_Vertices:XML=new XML();
         var nodeXML_Puntos:XML=new XML();
         nodeXML_Vertices = <Vertices />;
         myXML.Recinto[0].Secciones[0].Seccion[Index].appendChild(nodeXML_Vertices);
         
         for (var i:int=0; i<Polygon_Arreglo[Index].numChildren; i++) {
            if (Polygon_Arreglo[Index].getChildAt(i).name=="P") {
               nodeXML_Puntos = <_Point x={Polygon_Arreglo[Index].getChildAt(i).x} y={Polygon_Arreglo[Index].getChildAt(i).y}/>;
               myXML.Recinto[0].Secciones[0].Seccion[Index].Vertices = myXML.Recinto[0].Secciones[0].Seccion[Index].Vertices.appendChild(nodeXML_Puntos);
            }
         }
         myXML.Recinto[0].Secciones[0].Seccion[Index].@x = Polygon_Arreglo[Index].x;
         myXML.Recinto[0].Secciones[0].Seccion[Index].@y = Polygon_Arreglo[Index].y;
      }
      
      private function actualizar_etiquetas_dise(indexSecc:int, Index:int):void {
         /* Introducimos todos los atributos de la etiqueta al XML */
         myXML = My_Xml.Insert_Label_Dise(indexSecc, Label_Arreglo_Dise[Index], myXML);
      }

      private function actualizar_graficos_dise(indexSecc:int, Index:int):void {
         /* Introducimos todos los atributos del gráfico al XML */
         myXML = My_Xml.Insert_Graphic_Dise(indexSecc, Graphic_Arreglo_Dise[Index], myXML);
      }
      
      private function actualizar_etiquetas(Index:int):void {
         /* Introducimos todos los atributos de la etiqueta al XML */
         myXML = My_Xml.Insert_Label(Label_Arreglo[Index], myXML);
      }
      
      private function actualizar_graficos(Index:int):void {
         /* Introducimos todos los atributos del gráfico al XML */
         myXML = My_Xml.Insert_Graphic(Graphic_Arreglo[Index], myXML);
      }
      
      private function actualizar_formas_dise(indexSecc:int, Index:int):void {
         myXML = My_Xml.Insert_Shape_Dise(indexSecc, Polygon_Arreglo_Formas_Dise[Index], myXML);
         
         delete myXML.Recinto[0].Secciones[0].Seccion[indexSecc].Figuras[0].Figura[Index].Vertices;
         var nodeXML_Vertices:XML=new XML();
         var nodeXML_Puntos:XML=new XML();
         nodeXML_Vertices = <Vertices id_Fig={Polygon_Arreglo_Formas_Dise[Index].Polygon_Nombre_Array[0].id}/>;
         myXML.Recinto[0].Secciones[0].Seccion[indexSecc].Figuras[0].Figura[Index].appendChild(nodeXML_Vertices);
         
         for (var i:int=0; i<Polygon_Arreglo_Formas_Dise[Index].numChildren; i++) {
            if (Polygon_Arreglo_Formas_Dise[Index].getChildAt(i).name=="P") {
               nodeXML_Puntos = <_Point x={Polygon_Arreglo_Formas_Dise[Index].getChildAt(i).x} y={Polygon_Arreglo_Formas_Dise[Index].getChildAt(i).y}/>;
               myXML.Recinto[0].Secciones[0].Seccion[indexSecc].Figuras[0].Figura[Index].Vertices = myXML.Recinto[0].Secciones[0].Seccion[indexSecc].Figuras[0].Figura[Index].Vertices.appendChild(nodeXML_Puntos);
            }
         }
         myXML.Recinto[0].Secciones[0].Seccion[indexSecc].Figuras[0].Figura[Index].@x = Polygon_Arreglo_Formas_Dise[Index].x;
         myXML.Recinto[0].Secciones[0].Seccion[indexSecc].Figuras[0].Figura[Index].@y = Polygon_Arreglo_Formas_Dise[Index].y;
      }
      
      private function actualizar_vertices_formas(Index:int):void {
         delete myXML.Recinto[0].Figuras[0].Figura[Index].Vertices;
         var nodeXML_Vertices:XML=new XML();
         var nodeXML_Puntos:XML=new XML();
         nodeXML_Vertices = <Vertices id_Fig={Polygon_Arreglo_Formas[Index].Polygon_Nombre_Array[0].id}/>;
         myXML.Recinto[0].Figuras[0].Figura[Index].appendChild(nodeXML_Vertices);
         
         for (var i:int=0; i<Polygon_Arreglo_Formas[Index].numChildren; i++) {
            if (Polygon_Arreglo_Formas[Index].getChildAt(i).name=="P") {
               nodeXML_Puntos = <_Point x={Polygon_Arreglo_Formas[Index].getChildAt(i).x} y={Polygon_Arreglo_Formas[Index].getChildAt(i).y}/>;
               myXML.Recinto[0].Figuras[0].Figura[Index].Vertices = myXML.Recinto[0].Figuras[0].Figura[Index].Vertices.appendChild(nodeXML_Puntos);
            }
         }
         myXML.Recinto[0].Figuras[0].Figura[Index].@x = Polygon_Arreglo_Formas[Index].x;
         myXML.Recinto[0].Figuras[0].Figura[Index].@y = Polygon_Arreglo_Formas[Index].y;
      }
      
      public function Recinto_Salvar_XML(event:MouseEvent):void {
         var i:int;
         var err:Boolean;
         
         err = false;
         for (i=0; i<Polygon_Arreglo.length; i++) actualizar_vertices(i);
         for(i=0; i <Polygon_Arreglo_Formas.length; i++) actualizar_vertices_formas(i);
         for(i=0; i <Label_Arreglo.length; i++) actualizar_etiquetas(i);
         for(i=0; i <Graphic_Arreglo.length; i++) actualizar_graficos(i);
         
         /* Ver si existen precios de secciones a 0.00 € */
         if (!inputVarTemplate) {
            for (i = 0; ((i < Polygon_Arreglo.length) && (!err)); i++) {
               if ((Number(Polygon_Arreglo[i].Polygon_But_Precio)) == 0) {
                 err = true;
               }
            }
         }
         if (err) {
               var _Block01:Block = new Block();
                  var metodo1:Function;

            addChild(_Block01);
            _Block01.alpha = 0.9;
            errRecintoSalvarPrecio = new Alerta_ErrorSalvarRecintoPrecio();
            addChild(errRecintoSalvarPrecio);
            errRecintoSalvarPrecio.x = (stage.stageWidth / 2) - (errRecintoSalvarPrecio.width / 2);
            errRecintoSalvarPrecio.y = (stage.stageHeight / 2) - (errRecintoSalvarPrecio.height / 2);
         
            metodo1 = function(e:MouseEvent) { 
                         removeChild(errRecintoSalvarPrecio);
                         removeChild(_Block01);
                      };
         
            errRecintoSalvarPrecio.Btn_Aceptar.addEventListener(MouseEvent.MOUSE_DOWN, metodo1);
         }
         else My_Xml.Save_Recinto(Herramientas_Ppal, Polygon_Arreglo, myXML);
      }
      
      /* Procesar formato XML para cargar todo el recinto */
      public function processXML(xmldb:String) {
         var Pol:int;
         var Lab:int;
         var Graf:int;
         var i:int;
         var j:int;
         var p:int;
         
         reiniciarVariablesGlobales();
         Polygon_Count = 0;
         Polygon_Count_Formas = 0;
         Label_Count = 0;
         Graphic_Count = 0;
         
         Polygon_Count_Formas_Dise = 0;
         Label_Count_Dise = 0;
         Graphic_Count_Dise = 0;
         
         polygon_mouseOver = false;
         
         /* Vaciar toda la tabla de precios */
         preciosDesc = new Array();
         
         Polygon_Arreglo=Polygon_Arreglo.splice(Polygon_Arreglo.length);
         Recinto_Array_Cargar=Recinto_Array_Cargar.splice(Recinto_Array_Cargar.length);
         Recinto_Array_Cargar_Figuras=Recinto_Array_Cargar_Figuras.splice(Recinto_Array_Cargar_Figuras.length);
         Cargar_Labels=Cargar_Labels.splice(Cargar_Labels.length);
         Cargar_Graficos=Cargar_Graficos.splice(Cargar_Graficos.length);
         Board.parent.removeChild(Board);

         Board = new Main_Board();
         Board.name="_Board";
         Board.x = 2550;
         Board.y = 2495;
         addChildAt(Board,0);
         m_grid = new Grid(true);
         Board.addChild(m_grid);
         m_grid.name="_Board_Grid";
         
         My_Var_In_sEditor.getInstance().Vista_Actual = Board;
         My_Var_In_sEditor.getInstance().Vista_Recinto = true;
         Board.doubleClickEnabled=true;
         Board.addEventListener(MouseEvent.MOUSE_MOVE, Board_Mov_Mouse);
         Board.addEventListener(MouseEvent.CLICK, Board_CLICK);
         Board.addEventListener(MouseEvent.MOUSE_UP, Board_UP);
         Board.addEventListener(MouseEvent.MOUSE_DOWN, Board_DOWN);
         Board.addEventListener(MouseEvent.MOUSE_WHEEL, _Board_Ppal_Scroll);
         
         mainInformation = new Main_InformationBox();
         mainInformation.x = 10;
         mainInformation.y = 400;
         Herramientas_Ppal.addChild(mainInformation);
         
         if (!inputVarLocked) Board.addEventListener(MouseEvent.DOUBLE_CLICK, Board_DOUBLECLICK);
         
         Board_Zoom_Point = new SpriteRegPoint("C");
         Board_Zoom_Point.addChild(Board);
         addChildAt(Board_Zoom_Point,0);
         Board_Zoom_Point.x = (stage.stageWidth/2) + 50;
         Board_Zoom_Point.y = (stage.stageHeight/2) + 20;
         
         myXML=new XML(xmldb);
         Recinto_Inf=Recinto_Inf.splice(Recinto_Inf.length);
         Recinto_Inf.push({Id:int(myXML.Recinto[0].@Id), Nombre:myXML.Recinto[0].@Nombre});
         for (Pol = 0; Pol<myXML.Recinto[0].Secciones[0].children().length(); Pol++) {
            var Nombre_Secc:String=myXML.Recinto[0].Secciones[0].Seccion[Pol].@Nombre;
            
            for (i = 0; i<myXML.Recinto[0].Secciones[0].Seccion[Pol].Vertices.children().length(); i++) {
               vertex_Array_Cargar.push({x:Number(myXML.Recinto[0].Secciones[0].Seccion[Pol].Vertices._Point[i].@x), y:Number(myXML.Recinto[0].Secciones[0].Seccion[Pol].Vertices._Point[i].@y), xPol:Number(myXML.Recinto[0].Secciones[0].Seccion[Pol].@x), yPol:Number(myXML.Recinto[0].Secciones[0].Seccion[Pol].@y), xEtiq:Number(myXML.Recinto[0].Secciones[0].Seccion[Pol].@xEt), yEtiq:Number(myXML.Recinto[0].Secciones[0].Seccion[Pol].@yEt), Secc_Name:myXML.Recinto[0].Secciones[0].Seccion[Pol].@Nombre, But_Libres:Number(myXML.Recinto[0].Secciones[0].Seccion[Pol].@But_Libres), But_Precio:myXML.Recinto[0].Secciones[0].Seccion[Pol].@But_Precio, Num_Inv:myXML.Recinto[0].Secciones[0].Seccion[Pol].@Num_Inv});
            }
            
            Recinto_Array_Cargar.push({Pol:vertex_Array_Cargar, But:Butacas_Array_Cargar});
            vertex_Array_Cargar=vertex_Array_Cargar.splice(vertex_Array_Cargar.length);
            Butacas_Array_Cargar=Butacas_Array_Cargar.splice(Butacas_Array_Cargar.length);
         }
         
         /* Introducimos las Figuras */
         for (Pol = 0; Pol<myXML.Recinto[0].Figuras[0].children().length(); Pol++) {
            var Nombre_Fig:String = myXML.Recinto[0].Figuras[0].Figura[Pol].@Nombre;
            
            for (i = 0; i<myXML.Recinto[0].Figuras[0].Figura[Pol].Vertices.children().length(); i++) {
               vertex_Array_Cargar_Figuras.push({x:Number(myXML.Recinto[0].Figuras[0].Figura[Pol].Vertices._Point[i].@x), y:Number(myXML.Recinto[0].Figuras[0].Figura[Pol].Vertices._Point[i].@y), xPol:Number(myXML.Recinto[0].Figuras[0].Figura[Pol].@x), yPol:Number(myXML.Recinto[0].Figuras[0].Figura[Pol].@y), Fig_Name:myXML.Recinto[0].Figuras[0].Figura[Pol].@Nombre});
            }
            
            Recinto_Array_Cargar_Figuras.push({Pol:vertex_Array_Cargar_Figuras});
            vertex_Array_Cargar_Figuras=vertex_Array_Cargar_Figuras.splice(vertex_Array_Cargar_Figuras.length);
         }
         
         /* Introducimos los Labels */
         for (Lab = 0; Lab<myXML.Recinto[0].Etiquetas[0].children().length(); Lab++) {
            Cargar_Labels.push({xLab: Number(myXML.Recinto[0].Etiquetas[0].Etiqueta[Lab].@x), yLab:Number(myXML.Recinto[0].Etiquetas[0].Etiqueta[Lab].@y), Lab_Name:myXML.Recinto[0].Etiquetas[0].Etiqueta[Lab].@Nombre, Fuente:myXML.Recinto[0].Etiquetas[0].Etiqueta[Lab].@Fuente, FuenteTam:myXML.Recinto[0].Etiquetas[0].Etiqueta[Lab].@FuenteTam, FuenteBold:myXML.Recinto[0].Etiquetas[0].Etiqueta[Lab].@FuenteBold, FuenteItalic:myXML.Recinto[0].Etiquetas[0].Etiqueta[Lab].@FuenteItalic, FuenteColor:myXML.Recinto[0].Etiquetas[0].Etiqueta[Lab].@FuenteColor, FuenteRotacion:myXML.Recinto[0].Etiquetas[0].Etiqueta[Lab].@FuenteRotacion, Texto:myXML.Recinto[0].Etiquetas[0].Etiqueta[Lab].@Texto});
         }

         /* Introducimos los Gráficos */
         for (Graf = 0; Graf<myXML.Recinto[0].Graficos[0].children().length(); Graf++) {
            Cargar_Graficos.push({xGraf: Number(myXML.Recinto[0].Graficos[0].Grafico[Graf].@x), yGraf:Number(myXML.Recinto[0].Graficos[0].Grafico[Graf].@y), Graf_Name:myXML.Recinto[0].Graficos[0].Grafico[Graf].@Nombre, AnchoGraf: Number(myXML.Recinto[0].Graficos[0].Grafico[Graf].@Ancho), AltoGraf: Number(myXML.Recinto[0].Graficos[0].Grafico[Graf].@Alto), GrafTipo:Number(myXML.Recinto[0].Graficos[0].Grafico[Graf].@Tipo), Rotacion:myXML.Recinto[0].Graficos[0].Grafico[Graf].@Rotacion});
         }
         
         for (j = 0; j<Recinto_Array_Cargar.length; j++) {
            Polygon_Crear=true;
            Polygon_Vertex=new Array();
            Polygon_Vertex=Polygon_Vertex.splice(Polygon_Vertex.length);
            for (p = 0; p<Recinto_Array_Cargar[j].Pol.length; p++) {
               Polygon_Vertex.push({name:Recinto_Array_Cargar[j].Pol[p].Secc_Name, x:Recinto_Array_Cargar[j].Pol[p].x, y:Recinto_Array_Cargar[j].Pol[p].y});
            }
            Polygon_Crear_Temp=new Sprite();
            Board.addChild(Polygon_Crear_Temp);
            Polygon_Dibujar(Polygon_Vertex[0].name,"True");
            Polygon_Arreglo[j].Polygon_Act_Mod=false;
            
            Polygon_Arreglo[j].Polygon_But_Totales = 0;
            var Count_Libres:Number=0;
            for (var But_Rest:int=0; But_Rest<myXML.Recinto[0].Secciones[0].Seccion[j].Butacas.children().length(); But_Rest++) {
               if (myXML.Recinto[0].Secciones[0].Seccion[j].Butacas._Butaca[But_Rest].@E == "Libre") {
                  Count_Libres++;
               }
               Polygon_Arreglo[j].Polygon_But_Totales++;
            }         
            
            Polygon_Arreglo[j].Polygon_But_Libres = Count_Libres;
            Polygon_Arreglo[j].Polygon_But_Precio = Recinto_Array_Cargar[j].Pol[0].But_Precio;
            Polygon_Arreglo[j].Polygon_Num_Inv = Boolean(Recinto_Array_Cargar[j].Pol[0].Num_Inv);
            
            if (!inputVarTemplate) introducirPrecioDesc(Number(Polygon_Arreglo[j].Polygon_But_Precio));
            
            if (Recinto_Array_Cargar[j].Pol[0].xPol!=0||Recinto_Array_Cargar[j].Pol[0].yPol!=0) {
               Polygon_Arreglo[j].x=Recinto_Array_Cargar[j].Pol[0].xPol;
               Polygon_Arreglo[j].y=Recinto_Array_Cargar[j].Pol[0].yPol;
            }
            Polygon_Arreglo[j].getChildAt(Polygon_Arreglo[j].getChildIndex(Polygon_Arreglo[j].getChildByName("Etiqueta"))).x=Recinto_Array_Cargar[j].Pol[0].xEtiq;
            Polygon_Arreglo[j].getChildAt(Polygon_Arreglo[j].getChildIndex(Polygon_Arreglo[j].getChildByName("Etiqueta"))).y=Recinto_Array_Cargar[j].Pol[0].yEtiq;
         }
         
         /* Dibujamos las Figuras */
         for (j = 0; j<Recinto_Array_Cargar_Figuras.length; j++) {
            Polygon_Crear=true;
            Polygon_Vertex=new Array();
            Polygon_Vertex=Polygon_Vertex.splice(Polygon_Vertex.length);
            for (p = 0; p<Recinto_Array_Cargar_Figuras[j].Pol.length; p++) {
               Polygon_Vertex.push({name:Recinto_Array_Cargar_Figuras[j].Pol[p].Fig_Name, x:Recinto_Array_Cargar_Figuras[j].Pol[p].x, y:Recinto_Array_Cargar_Figuras[j].Pol[p].y});
            }
            Polygon_Crear_Temp=new Sprite();
            Board.addChild(Polygon_Crear_Temp);
            Polygon_Shape_Dibujar(true, My_Var_In_sEditor.getInstance().Vista_Actual, 0, Polygon_Vertex[0].name,"True");
            Polygon_Arreglo_Formas[j].Polygon_Act_Mod=false;

            if (Recinto_Array_Cargar_Figuras[j].Pol[0].xPol!=0||Recinto_Array_Cargar_Figuras[j].Pol[0].yPol!=0) {
               Polygon_Arreglo_Formas[j].x=Recinto_Array_Cargar_Figuras[j].Pol[0].xPol;
               Polygon_Arreglo_Formas[j].y=Recinto_Array_Cargar_Figuras[j].Pol[0].yPol;
            }
         }         
         
         /* Dibujamos los Labels */
         for (j = 0; j < Cargar_Labels.length; j++) {
            Label_Dibujar(true, My_Var_In_sEditor.getInstance().Vista_Actual, 0, Cargar_Labels[j]);
         }

         /* Dibujamos los Gráficos */
         for (j = 0; j < Cargar_Graficos.length; j++) {
            Grafico_Dibujar(true, My_Var_In_sEditor.getInstance().Vista_Actual, 0, Cargar_Graficos[j]);
         }
         
         if (!inputVarTemplate) pintarPoligonos();
         Mini_Mapa_Crear();
         actualize_mainInformation();
         centrar_vistaRecinto(Board);
         if ((inputVarLocked) && (messageLimited)) { msgRecintoRestringuido(); messageLimited = false; }
      }

      function trim(cadena:String):String { return cadena.replace(/^\s*(.*?)\s*$/g,"$1"); }

      private function Figura_Mover(e:MouseEvent) {
         dadesDetallGuardades = false;      
      }
      
      public function Seccion_Move(e:MouseEvent):void {
         if (permitirMoverObjetos(true)) { 
            My_Var_In_sEditor.getInstance().Moviendo_Objeto = true; 
            e.target.parent.startDrag(); 
            if (!My_Var_In_sEditor.getInstance().Vista_Recinto) {
               e.target.parent.addEventListener(MouseEvent.MOUSE_MOVE, Figura_Mover);
            }
         }
      }

      public function Seccion_Stop(e:MouseEvent):void {
         if (!My_Var_In_sEditor.getInstance().Vista_Recinto) {
            e.target.parent.removeEventListener(MouseEvent.MOUSE_MOVE, Figura_Mover);
         }
         
         My_Var_In_sEditor.getInstance().Moviendo_Objeto = false; 
         e.target.parent.stopDrag(); 
      }
      
      private function label_DoubleClick(e:MouseEvent):void {
         Herramientas_Ppal.btn_Texto.label = "Terminar";
         cambiarMainEstadoBotones(false, Herramientas_Ppal.btn_Texto);
         
         My_Var_In_sEditor.getInstance().Escribir_Label = true;
         My_Var_In_sEditor.getInstance().Label_Objeto_Seleccionado = e.target.parent.parent;

         mostrarPropiedadesTexto(formAtributosTexto);
         
         e.target.parent.textField.border = true;
         e.target.parent.textField.borderColor = 0x000000;      
      }
      
      
      public function label_In(e:MouseEvent):void { 
         if (permitirMoverObjetos(true)) Mouse.cursor = MouseCursor.HAND 
         else Mouse.cursor = MouseCursor.ARROW;
      }
      public function label_Out(e:MouseEvent):void { Mouse.cursor = MouseCursor.ARROW; }
      
      private function Label_Mover(e:MouseEvent) {
         dadesDetallGuardades = false;      
      }
      
      public function label_Drag(e:MouseEvent):void { 
         if ((e.target is TextField) && (permitirMoverObjetos(true))) {
            My_Var_In_sEditor.getInstance().Moviendo_Objeto = true;
            e.target.parent.parent.startDrag(); 
            if (!My_Var_In_sEditor.getInstance().Vista_Recinto) {
               e.target.parent.addEventListener(MouseEvent.MOUSE_MOVE, Label_Mover);
            }
         }
      }
      
      public function label_Drop(e:MouseEvent):void {
            if (!My_Var_In_sEditor.getInstance().Vista_Recinto) {
            e.target.parent.removeEventListener(MouseEvent.MOUSE_MOVE, Label_Mover);
         }
         
         My_Var_In_sEditor.getInstance().Moviendo_Objeto = false;
         e.target.parent.parent.stopDrag(); 
      }

      public function graphic_In(e:MouseEvent):void { 
         if (permitirMoverObjetos(true)) Mouse.cursor = MouseCursor.HAND 
         else Mouse.cursor = MouseCursor.ARROW;
      }
      public function graphic_Out(e:MouseEvent):void { Mouse.cursor = MouseCursor.ARROW; }
      
      private function Graphic_Mover(e:MouseEvent) {
         dadesDetallGuardades = false;      
      }
      
      public function graphic_Drag(e:MouseEvent):void { 
         if (permitirMoverObjetos(true)) {
            My_Var_In_sEditor.getInstance().Moviendo_Objeto = true;
            e.target.startDrag(); 
            if (!My_Var_In_sEditor.getInstance().Vista_Recinto) {
               e.target.addEventListener(MouseEvent.MOUSE_MOVE, Graphic_Mover);
            }
         }
      }
      
      public function graphic_Drop(e:MouseEvent):void {
         if (!My_Var_In_sEditor.getInstance().Vista_Recinto) {
            e.target.removeEventListener(MouseEvent.MOUSE_MOVE, Graphic_Mover);
         }
         
         My_Var_In_sEditor.getInstance().Moviendo_Objeto = false;
         e.target.stopDrag(); 
      }
      
      public function Mini_Mapa_Crear():void {
         var snapshot:BitmapData = new BitmapData(2490, 2490, true, 0x00000000);
         var scaleMatrix:Matrix = new Matrix();
         scaleMatrix.scale(0.5, 0.5);
         scaleMatrix.tx = 1245;
         scaleMatrix.ty = 1245;
         snapshot.draw(Board, scaleMatrix);

         if (!thumb) {
            thumb = new Bitmap(snapshot);
            thumb.width = 200.5;
            thumb.height = 200;
            Board_Mini.Mini_Pan.addChild(thumb);
         } else {
            thumb.bitmapData = snapshot;
         }
      }
   
      public function Buscar_en_Arreglo(Arreglo:Array, Valor:String) {
         for (var i:Number = 0; i < Arreglo.length; i++) {
            if (Arreglo[i].name==Valor) {
               return i;
            }
         }
      }

      /* @Evento llamado al pulsar el boton de matriz de butacas */
      public function Form_But_C_Matriz(e:MouseEvent, Board_Dise:Object,Marco_Dise:Object, But_Arreglo:Array, Index:int, No_Butacas:int) {
         But_C_M_Form = new Form_But_C_M();
         But_C_M_Form.Err_FilaColNumericos.visible = false;
         _Block = new Block();
         _Block.alpha = 0.9;
         stage.addChild(_Block);
         stage.addChild(But_C_M_Form);
         centrar_Alerta(But_C_M_Form);

         function _But_C_M_Form_Aceptar() {
            dadesDetallGuardades = false;
            But_C_M_Form.Err_FilaColNumericos.visible = false;

            if ((But_C_M_Form.Filas_Inp.text.length > 0) && !isNaN(Number(But_C_M_Form.Filas_Inp.text)) && (But_C_M_Form.Columnas_Inp.text.length > 0) && !isNaN(Number(But_C_M_Form.Columnas_Inp.text))) {
               if ((Number(But_C_M_Form.Filas_Inp.text) > 0) && (Number(But_C_M_Form.Columnas_Inp.text) > 0)) {
                  var N_Filas:int=int(But_C_M_Form.Filas_Inp.text);
                  var N_Columnas:int=int(But_C_M_Form.Columnas_Inp.text);
                  No_Butacas=2;
                  stage.removeChild(_Block);
                  stage.removeChild(But_C_M_Form);
            
                  Butacas_Diseño(e,Board_Dise,Marco_Dise, But_Arreglo, Index, No_Butacas,N_Filas, N_Columnas);
               }
               else But_C_M_Form.Err_FilaColNumericos.visible = true;
            }
            else But_C_M_Form.Err_FilaColNumericos.visible = true;
         }
         
         function _But_C_M_Form_Cancelar() {
            stage.removeChild(_Block);
            stage.removeChild(But_C_M_Form);
         }
         
         But_C_M_Form.Btn_Aceptar.addEventListener(MouseEvent.MOUSE_DOWN, _But_C_M_Form_Aceptar);
         But_C_M_Form.Btn_Cancelar.addEventListener(MouseEvent.MOUSE_DOWN, _But_C_M_Form_Cancelar);
      }

      private function pintarPoligonos() {
         var index:int;
         var lblheight:int;
         var lblEtiqueta:Label;
         var lblEtiquetaText:Label;
         var i:int;
         var j:int;
         var preciosUtilizados:Array=[];
         var precioEncontrado:Boolean;
         var count:int;
         
         for (i = 0; i < Herramientas_Ppal.numChildren; i++) {
            if (Herramientas_Ppal.getChildAt(i).name == "LegendColors") {
               Herramientas_Ppal.removeChildAt(i);
            }
         }
         
         LegendColors = new MovieClip();
         LegendColors.name = "LegendColors";
         LegendColors.y = 0;
         LegendColors.x = 0;
         
         for (i = 0; i < Polygon_Arreglo.length; i++) {
            if (Polygon_Arreglo[i].Polygon_But_Libres > 0) {
               index = getIndexPrecioDesc(Polygon_Arreglo[i].Polygon_But_Precio);               
               preciosUtilizados.push(Polygon_Arreglo[i].Polygon_But_Precio);
            }
            else index = 0;
            
            if (index > (_Est.Format_ColoresPoligonos().length - 1)) index = _Est.Format_ColoresPoligonos().length - 1;
            Polygon_Arreglo[i].drawLines(_Est.Format_ColoresPoligonos()[index]);
            Polygon_Arreglo[i].Polygon_Color = _Est.Format_ColoresPoligonos()[index];
         }
         
         /* Reseteamos todos los precios */
         for (i = 0; (i < preciosDesc.length); i++) { preciosDesc[i].repetido = false; }
                                              
         /* Dibujamos los colores en la leyenda */
         lblheight = 60;
         count = 0;

         for(i = 0; (i < preciosDesc.length); i++) {
            precioEncontrado = false;
            for (j = 0; ((j < preciosUtilizados.length) && (!precioEncontrado)); j++) {
               if ((preciosDesc[i].precio == Number(preciosUtilizados[j])) && (preciosDesc[i].repetido == false)) {
                  precioEncontrado = true;
                  preciosDesc[i].repetido = true;
               }
            }

            if (precioEncontrado) {
               lblEtiqueta = new Label();
               lblEtiquetaText = new Label();
               
               if (count % 2 == 0) lblEtiqueta.x = 10;
               else lblEtiqueta.x = 85;
               
               lblEtiqueta.name = "color";
               lblEtiqueta.y = lblheight;
               lblEtiqueta.width = 12;
               lblEtiqueta.height = 12;

               lblEtiqueta.textField.background = true; 
               lblEtiqueta.textField.backgroundColor = _Est.Format_ColoresPoligonos()[i + 1];

               lblEtiqueta.alpha = 0.2;
               lblEtiqueta.text = "";
               
               lblEtiquetaText.name = "colorEtiq";
               lblEtiquetaText.x = lblEtiqueta.x + 16;
               lblEtiquetaText.y = lblheight - 3;
               lblEtiquetaText.width = 50;
               lblEtiquetaText.height = 24;
               lblEtiquetaText.setStyle("textFormat", _Est.Format_EtiqColoresLeyenda());
               
               lblEtiquetaText.text = preciosDesc[i].precio.toFixed(2).toString() + " €"; 
               
               if (count % 2 == 1) lblheight += 25;
               LegendColors.addChild(lblEtiqueta);
               LegendColors.addChild(lblEtiquetaText);
               count++;
            }
         }
            
         var tmp:int;
            
         if (lblEtiquetaText != null) tmp = lblEtiquetaText.y;
         else tmp = 60;
            
         lblEtiqueta = new Label();
         lblEtiquetaText = new Label();
            
         lblEtiqueta.name = "color";
         lblEtiqueta.x = 10;
               
         lblEtiqueta.y = tmp + 35;
         lblEtiqueta.width = 24;
         lblEtiqueta.height = 12;
         lblEtiqueta.alpha = 0.6;
            
         lblEtiqueta.textField.border = true;
         lblEtiqueta.textField.borderColor = 0x000000;
         lblEtiqueta.textField.background = true; 
         lblEtiqueta.textField.backgroundColor = _Est.Format_ColoresPoligonos()[0];
            
         lblEtiqueta.text = "";
               
         lblEtiquetaText.name = "color";
         lblEtiquetaText.x = lblEtiqueta.x + 30;
         lblEtiquetaText.y = lblEtiqueta.y - 3;
         lblEtiquetaText.width = 100;
         lblEtiquetaText.height = 24;
         lblEtiquetaText.setStyle("textFormat", _Est.Format_EtiqColoresLeyenda());
               
         lblEtiquetaText.text = "Sección agotada"; 

         LegendColors.addChild(lblEtiqueta);
         LegendColors.addChild(lblEtiquetaText);

         Herramientas_Ppal.addChild(LegendColors);
      }

      private function getIndexPrecioDesc(precio:Number) {
         var i:int;
         var index:int = 0;
         
         for(i = 0; ((i < preciosDesc.length) && (index == 0)); i++) {
            if (precio == preciosDesc[i].precio) index = i + 1;
         }
         return index;
      }

      private function introducirPrecioDesc(precio:Number) {
         var minPrecio:Number;
         var tmpPrecio:Number;
         var i:int;
         var j:int;
         var index:int;
         
         if (preciosDesc.length > 0) {
            /* Los precios iguales no los introducimos */
            if (!precioEstaIntroducido(precio)) {
               /* Buscamos la posición a insertar el precio nuevo */
                  index = 0;
               for(i = 0; (i < preciosDesc.length); i++) {
                  if (precio > preciosDesc[i].precio) { index = i + 1; }
               }

               /* Insertamos un elemento dummy */
               preciosDesc.push({precio: 0.00, repetido: false});
                  
               /* Movemos todos los elementos restantes una posición mas */
               for(j = 0, i = preciosDesc.length - 1; j < (preciosDesc.length - (index + 1)); i--, j++) {
                  preciosDesc[i].precio = preciosDesc[i - 1].precio;
                  preciosDesc[i].repetido = preciosDesc[i - 1].repetido;
               }
                  
               preciosDesc[index].precio = precio;
               preciosDesc[index].repetido = false;
            }
         }
         else preciosDesc.push({precio: precio, repetido: false});
      }
      
      private function eliminarPrecioDesc(precio:Number) {
         var i:int;
         var count:int;
         var index:int;
         var trobat:Boolean;
         
         count = 0;
         for(i = 0; i < Polygon_Arreglo.length; i++) {
            if (Number(Polygon_Arreglo[i].Polygon_But_Precio) == precio) {
               count++;
            }
         }
         
         if (count == 1) {
            /* Eliminamos el precio de la lista de precios solo si existe una sola instancia */
            index = 0;
            trobat = false;
            for(i = 0; ((i < preciosDesc.length) && (!trobat)); i++) {
               if (preciosDesc[i].precio == precio) { index = i; trobat = true; }
            }
            
            if (trobat) {
               for(i = index; (i < preciosDesc.length); i++) {
                     if ((i + 1) < preciosDesc.length) {
                        preciosDesc[i].precio = preciosDesc[i + 1].precio;
                     preciosDesc[i].repetido = preciosDesc[i + 1].repetido;
                  }
               }
               preciosDesc.pop();            
            }
         }
      }
      
      private function cambiarPrecioDesc(precioAnterior:Number, precioNuevo:Number) {
         eliminarPrecioDesc(precioAnterior);
         introducirPrecioDesc(precioNuevo);
      }
      
      private function precioEstaIntroducido(precio: Number) {
         var resultado:Boolean;
         
         resultado = false;
         
         for(var i:int = 0; ((i < preciosDesc.length) && (resultado == false)); i++) {
            if (preciosDesc[i].precio == precio) resultado = true;
         }
         return resultado;
      }
      
      public function actualize_mainInformation() {
         var totalBut:int;
         var totalFreeBut:int;
         var i:int;
         
         totalBut = 0;
         totalFreeBut = 0;
         for(i = 0; i < Polygon_Arreglo.length; i++) {
            totalFreeBut += Polygon_Arreglo[i].Polygon_But_Libres;
            totalBut += Polygon_Arreglo[i].Polygon_But_Totales;
         }
         
         mainInformation.MainInformation_RecintoNombre.setStyle("textFormat", _Est.Format_MainInformationRecinto());
         mainInformation.MainInformation_RecintoNombre.text = Recinto_Inf[0].Nombre;
         mainInformation.MainInformation_NSec.text = Polygon_Arreglo.length.toString() + " secciones";
         mainInformation.MainInformation_TotalBut.text = totalBut.toString() + " localidades";
         mainInformation.MainInformation_FreeBut.text = totalFreeBut.toString() + " libres";
         mainInformation.MainInformation_BusyBut.text = (totalBut - totalFreeBut).toString() + " ocupadas";
         if (totalBut == 0) mainInformation.MainInformation_Statistic.text = "0.00% ocupación";
         else mainInformation.MainInformation_Statistic.text = (((totalBut - totalFreeBut)/totalBut) * 100).toFixed(2) + "% ocupación";
      }
      
      public function actualize_diseInformation(Board_Dise:Object, Marco_Dise:Object, index:int, iniEnter:Boolean) {
         var totalBut:int;
         var totalFreeBut:int;
         var i:int;
         
         totalBut = 0;
         totalFreeBut = 0;
         if (iniEnter == true) {
            totalFreeBut = Polygon_Arreglo[index].Polygon_But_Libres;
            totalBut = Polygon_Arreglo[index].Polygon_But_Totales;
         }
         else {
            for (i = 0; i < Board_Dise.numChildren; i++) {
               if (Board_Dise.getChildAt(i).name=="But") {
                  totalBut++;
                  if (Board_Dise.getChildAt(i).Estado == "Libre") totalFreeBut++; 
               }
            }
         }
         
         Marco_Dise.Dise_Information.DiseInformation_SeccionNombre.setStyle("textFormat", _Est.Format_DiseInformationSeccion());
         Marco_Dise.Dise_Information.DiseInformation_SeccionNombre.text = Polygon_Arreglo[index].name;
         Marco_Dise.Dise_Information.DiseInformation_Price.text = Number(Polygon_Arreglo[index].Polygon_But_Precio).toFixed(2) + " €";
         Marco_Dise.Dise_Information.DiseInformation_TotalBut.text = totalBut.toString() + " localidades";
         Marco_Dise.Dise_Information.DiseInformation_FreeBut.text = totalFreeBut.toString() + " libres";
         Marco_Dise.Dise_Information.DiseInformation_BusyBut.text = (totalBut - totalFreeBut).toString() + " ocupadas";
         if (totalBut == 0) Marco_Dise.Dise_Information.DiseInformation_Statistic.text = "0.00% ocupación";
         else Marco_Dise.Dise_Information.DiseInformation_Statistic.text = (((totalBut - totalFreeBut)/totalBut) * 100).toFixed(2) + "% ocupación";
      }
      
      public function centrar_vistaRecinto(Board:Object) {
         var Xmin:int;
         var Xmax:int;
         var Ymin:int;
         var Ymax:int;
         var Xcentro:Number;
         var Ycentro:Number;
         var segX:Number;
         var segY:Number;
         var segViewportX:int;
         var segViewportY:int;
         var i:int;
         var j:int;

         Board.x = 2550;
         Board.y = 2495;
         Board_Zoom_Point.scaleX = 1;
         Board_Zoom_Point.scaleY = 1;
         segViewportX = stage.stageWidth - 180;
         segViewportY = stage.stageHeight - 60;
         
         /* Buscamos el Xmin, Xmax, Ymin, Ymax para crear un viewport */
         Xmin = int.MAX_VALUE;
         Ymin = int.MAX_VALUE;
         Xmax = int.MIN_VALUE;
         Ymax = int.MIN_VALUE;
         
         if ((Polygon_Arreglo.length > 0) || (Polygon_Arreglo_Formas.length > 0)) {
            
            for (i = 0; i<Polygon_Arreglo.length; i++) {
               for (j = 0; j<Polygon_Arreglo[i].numChildren; j++) {
                  if (Polygon_Arreglo[i].getChildAt(j).name == "P") {
                     if ((Polygon_Arreglo[i].getChildAt(j).x + (Polygon_Arreglo[i].x)) < Xmin) Xmin = Polygon_Arreglo[i].getChildAt(j).x + (Polygon_Arreglo[i].x);
                     if ((Polygon_Arreglo[i].getChildAt(j).x + (Polygon_Arreglo[i].x)) > Xmax) Xmax = Polygon_Arreglo[i].getChildAt(j).x + (Polygon_Arreglo[i].x);
                     if ((Polygon_Arreglo[i].getChildAt(j).y + (Polygon_Arreglo[i].y)) < Ymin) Ymin = Polygon_Arreglo[i].getChildAt(j).y + (Polygon_Arreglo[i].y);
                     if ((Polygon_Arreglo[i].getChildAt(j).y + (Polygon_Arreglo[i].y)) > Ymax) Ymax = Polygon_Arreglo[i].getChildAt(j).y + (Polygon_Arreglo[i].y);
                  }
               }
            }            

            for (i = 0; i<Polygon_Arreglo_Formas.length; i++) {
               for (j = 0; j<Polygon_Arreglo_Formas[i].numChildren; j++) {
                  if (Polygon_Arreglo_Formas[i].getChildAt(j).name == "P") {
                     if ((Polygon_Arreglo_Formas[i].getChildAt(j).x + (Polygon_Arreglo_Formas[i].x)) < Xmin) Xmin = Polygon_Arreglo_Formas[i].getChildAt(j).x + (Polygon_Arreglo_Formas[i].x);
                     if ((Polygon_Arreglo_Formas[i].getChildAt(j).x + (Polygon_Arreglo_Formas[i].x)) > Xmax) Xmax = Polygon_Arreglo_Formas[i].getChildAt(j).x + (Polygon_Arreglo_Formas[i].x);
                     if ((Polygon_Arreglo_Formas[i].getChildAt(j).y + (Polygon_Arreglo_Formas[i].y)) < Ymin) Ymin = Polygon_Arreglo_Formas[i].getChildAt(j).y + (Polygon_Arreglo_Formas[i].y);
                     if ((Polygon_Arreglo_Formas[i].getChildAt(j).y + (Polygon_Arreglo_Formas[i].y)) > Ymax) Ymax = Polygon_Arreglo_Formas[i].getChildAt(j).y + (Polygon_Arreglo_Formas[i].y);
                  }
               }
            }
            
            /* Buscamos el centro del rectángulo */
            Xcentro = Xmin + ((Xmax - Xmin)/2);
            Ycentro = Ymin + ((Ymax - Ymin)/2);
            
            Board.x -= Xcentro;
            Board.y -= Ycentro;
            
            /* Calculamos el área del rectángulo para realizar el Zoom */
            Xmin = Xmin - 14;
            Xmax = Xmax + 14;
            Ymin = Ymin - 14;
            Ymax = Ymax + 14;

            segX = (Xmax - Xmin);
            segY = (Ymax - Ymin);
            if ((segX > segViewportX) || (segY > segViewportY)) {
               while ((segX > segViewportX) || (segY > segViewportY)) {
                  Board_Zoom_Point.scaleX = Board_Zoom_Point.scaleX/1.02;
                  Board_Zoom_Point.scaleY = Board_Zoom_Point.scaleY/1.02;
                  segX = segX/1.02;
                  segY = segY/1.02;
               }
            }
         }
      }
      
      public function centrar_vistaButacas(Board_Dise:Object, Marco_Dise:Object) {
         var Xmin:int;
         var Xmax:int;
         var Ymin:int;
         var Ymax:int;
         var Xcentro:Number;
         var Ycentro:Number;
         var segX:Number;
         var segY:Number;
         var segViewportX:int;
         var segViewportY:int;
         var i:int;
         var j:int;
         var tieneButacas:Boolean;
         var tieneFormas:Boolean;
         
         Board_Dise_Zoom_Point.scaleX = 1;
         Board_Dise_Zoom_Point.scaleY = 1;
         segViewportX = stage.stageWidth - 180;
         segViewportY = stage.stageHeight - 60;
         tieneButacas = false;
         tieneFormas = false;
         
         /* Buscamos el Xmin, Xmax, Ymin, Ymax para crear un viewport */
         Xmin = int.MAX_VALUE;
         Ymin = int.MAX_VALUE;
         Xmax = int.MIN_VALUE;
         Ymax = int.MIN_VALUE;
         
         if (Board_Dise.numChildren > 0) {
            
            for (i=0; i<Board_Dise.numChildren; i++) {
               if (Board_Dise.getChildAt(i).name == "But") {
                  tieneButacas = true;
                  if (Board_Dise.getChildAt(i).x < Xmin) Xmin = Board_Dise.getChildAt(i).x;
                  if (Board_Dise.getChildAt(i).x > Xmax) Xmax = Board_Dise.getChildAt(i).x;
                  if (Board_Dise.getChildAt(i).y < Ymin) Ymin = Board_Dise.getChildAt(i).y;
                  if (Board_Dise.getChildAt(i).y > Ymax) Ymax = Board_Dise.getChildAt(i).y;
               }
            }

            for (i = 0; i<Polygon_Arreglo_Formas_Dise.length; i++) {
               tieneFormas = true;
               for (j = 0; j<Polygon_Arreglo_Formas_Dise[i].numChildren; j++) {
                  if (Polygon_Arreglo_Formas_Dise[i].getChildAt(j).name == "P") {
                     if ((Polygon_Arreglo_Formas_Dise[i].getChildAt(j).x + (Polygon_Arreglo_Formas_Dise[i].x)) < Xmin) Xmin = Polygon_Arreglo_Formas_Dise[i].getChildAt(j).x + (Polygon_Arreglo_Formas_Dise[i].x);
                     if ((Polygon_Arreglo_Formas_Dise[i].getChildAt(j).x + (Polygon_Arreglo_Formas_Dise[i].x)) > Xmax) Xmax = Polygon_Arreglo_Formas_Dise[i].getChildAt(j).x + (Polygon_Arreglo_Formas_Dise[i].x);
                     if ((Polygon_Arreglo_Formas_Dise[i].getChildAt(j).y + (Polygon_Arreglo_Formas_Dise[i].y)) < Ymin) Ymin = Polygon_Arreglo_Formas_Dise[i].getChildAt(j).y + (Polygon_Arreglo_Formas_Dise[i].y);
                     if ((Polygon_Arreglo_Formas_Dise[i].getChildAt(j).y + (Polygon_Arreglo_Formas_Dise[i].y)) > Ymax) Ymax = Polygon_Arreglo_Formas_Dise[i].getChildAt(j).y + (Polygon_Arreglo_Formas_Dise[i].y);
                  }
               }
            }
            
            if ((tieneButacas) || (tieneFormas)) {
               /* Buscamos el centro del rectángulo */
               Xcentro = Xmin + ((Xmax - Xmin)/2);
               Ycentro = Ymin + ((Ymax - Ymin)/2);
               
               Board_Dise.x -= Xcentro;
               Board_Dise.y -= Ycentro;
               
               /* Calculamos el área del rectángulo para realizar el Zoom */
               Xmin = Xmin - 14;
               Xmax = Xmax + 14;
               Ymin = Ymin - 14;
               Ymax = Ymax + 14;
         
               segX = (Xmax - Xmin);
               segY = (Ymax - Ymin);
               if ((segX > segViewportX) || (segY > segViewportY)) {
                  while ((segX > segViewportX) || (segY > segViewportY)) {
                     Board_Dise_Zoom_Point.scaleX = Board_Dise_Zoom_Point.scaleX/1.02;
                     Board_Dise_Zoom_Point.scaleY = Board_Dise_Zoom_Point.scaleY/1.02;
                     segX = segX/1.02;
                     segY = segY/1.02;
                  }
               }
            }
         }
      }

      private function rotarPoligono(poligono:Object, grados:int) {
         var nv:int;
         var vertex1X:int;
         var vertex1Y:int;
         var centroPolX:int;
         var centroPolY:int;
         
         centroPolX = getCentroPoligonoX(poligono);
         centroPolY = getCentroPoligonoY(poligono);
         for (nv = 0; nv < poligono.numChildren; nv++) {
            if (poligono.getChildAt(nv).name == "P") {
               vertex1X = poligono.getChildAt(nv).x;
               vertex1Y = poligono.getChildAt(nv).y;
               
               /* Realizamos el cálculo de rotación */
               poligono.getChildAt(nv).x = centroPolX + (((vertex1X - centroPolX)*Math.cos((grados*Math.PI)/180)) + ((vertex1Y - centroPolY)*Math.sin((grados*Math.PI)/180)));
               poligono.getChildAt(nv).y = centroPolY - (((vertex1X - centroPolX)*Math.sin((grados*Math.PI)/180)) - ((vertex1Y - centroPolY)*Math.cos((grados*Math.PI)/180)));
            }
         }
      }

      private function getCentroPoligonoX(Polygon:Object) {
         var minX:int;
         var maxX:int;
         var numVertex:int;
         
         numVertex = 0;
         minX = int.MAX_VALUE;
         maxX = int.MIN_VALUE;
         
         for (var i:int=0; i<Polygon.numChildren; i++) {
            if (Polygon.getChildAt(i).name == "P") {
               if (minX > Polygon.getChildAt(i).x) minX = Polygon.getChildAt(i).x;
               if (maxX < Polygon.getChildAt(i).x) maxX = Polygon.getChildAt(i).x;
         
               numVertex++;
            }
         }
         if (numVertex > 1) return (minX + ((maxX - minX)/2));
         else if (numVertex == 1) return minX;
         else return 0;
      }

      private function getCentroPoligonoY(Polygon:Object) {
         var minY:int;
         var maxY:int;
         var numVertex:int;
         
         numVertex = 0;
         minY = int.MAX_VALUE;
         maxY = int.MIN_VALUE;
         
         for (var i:int=0; i<Polygon.numChildren; i++) {
            if (Polygon.getChildAt(i).name == "P") {
               if (minY > Polygon.getChildAt(i).y) minY = Polygon.getChildAt(i).y;
               if (maxY < Polygon.getChildAt(i).y) maxY = Polygon.getChildAt(i).y;
               numVertex++;
            }
         }
         if (numVertex > 1) return (minY + ((maxY - minY)/2));
         else if (numVertex == 1) return minY;
         else return 0;
      }

      private function reiniciarVariablesGlobales() {
         My_Var_In_sEditor.getInstance().Dibujando_Forma = false;
         My_Var_In_sEditor.getInstance().Dibujando_Seccion = false;
         My_Var_In_sEditor.getInstance().Insertar_Label = false;
         My_Var_In_sEditor.getInstance().Escribir_Label = false;
         My_Var_In_sEditor.getInstance().Insertando_Grafico = false; 
         My_Var_In_sEditor.getInstance().Insertando_Grafico_Tipo = 0;
         My_Var_In_sEditor.getInstance().Insertando_Grafico_Rotacion = 0;
         My_Var_In_sEditor.getInstance().Insertando_Grafico_Anchura = 0;
         My_Var_In_sEditor.getInstance().Insertando_Grafico_Altura = 0;
         My_Var_In_sEditor.getInstance().Mover_But = false;
         My_Var_In_sEditor.getInstance().Mover_Recinto = false;
         My_Var_In_sEditor.getInstance().Mover_Seccion = false;
         My_Var_In_sEditor.getInstance().Editando_Pol = false;
         My_Var_In_sEditor.getInstance().Editando_Pol_Secc = false;
         My_Var_In_sEditor.getInstance().Editando_Pol_Index = -1;
         My_Var_In_sEditor.getInstance().Marcar_Butaca = false;
         My_Var_In_sEditor.getInstance().Moviendo_Objeto = false;
         My_Var_In_sEditor.getInstance().Creando_Objeto = false;         
         My_Var_In_sEditor.getInstance().Butacas_Marcadas = 0;
      }
      
      private function reiniciarVariables() {
         sEditor_DB = new Array();
         Recinto_Inf = new Array();
         preciosDesc = new Array();
         Recinto_Array_Cargar = new Array();
         Recinto_Array_Cargar_Figuras = new Array();
         vertex_Array_Cargar_Figuras = new Array();
         Recinto_Array_Cargar_Figuras_Dise = new Array();
         Cargar_Labels_Dise = new Array();
         Cargar_Graficos_Dise = new Array();
         vertex_Array_Cargar_Figuras_Dise = new Array();
         Cargar_Labels = new Array();
         Cargar_Graficos = new Array();
         vertex_Array_Cargar = new Array();
         Butacas_Array_Cargar = new Array();
         Cliente_Array = new Array();
         Board_Dise_Array = new Array();
         Polygon_Vertex = new Array();
         Polygon_Vertex_Actual = new Array();
         Polygon_Vertex_Eval = new Array();
         Polygon_Arreglo = new Array();
         Polygon_Arreglo_Formas = new Array();
         Label_Arreglo = new Array();
         Graphic_Arreglo = new Array();
         Polygon_Secciones = new Array();
         Vertices_Array = new Array();
         Butacas_Array = new Array();
         
         polygon_mouseOver = false;
         
         Polygon_Count = 0;
         Polygon_Count_Formas = 0;
         Label_Count = 0;
         Graphic_Count = 0;
         
         bloqueadoDesplazamientoVista = true;
         bloqueadoDesplazamientoVistaDiseño = true;
         
         Polygon_Crear = false;
         Polygon_Crear_Temp_Point0 = false;
         Polygon_Move = false;
         Polygon_Renomb = false;
         
         resetearTextoPropiedades(false);
         resetearTextoPropiedades(true);
      }
      
      private function refrescar_numButacasSeleccionadas(Board_Dise:Object) {
         But_Acciones = new AccionesButacas();
         But_Acciones.Contar_Butacas(Board_Dise);
      }
      
      private function cambiarMainEstadoBotones(estado:Boolean, boton:Object = null) {
         if (boton != Herramientas_Ppal.btn_Nuevo) Herramientas_Ppal.btn_Nuevo.enabled = estado;
         if (boton != Herramientas_Ppal.btn_Imagen) Herramientas_Ppal.btn_Imagen.enabled = estado;
         if (boton != Herramientas_Ppal.btn_Mover) Herramientas_Ppal.btn_Mover.enabled = estado;
         if (boton != Herramientas_Ppal.btn_Salvar) Herramientas_Ppal.btn_Salvar.enabled = estado;
         if (boton != Herramientas_Ppal.btn_Formas) Herramientas_Ppal.btn_Formas.enabled = estado;
         if (boton != Herramientas_Ppal.btn_Texto) Herramientas_Ppal.btn_Texto.enabled = estado;
         if (boton != Herramientas_Ppal.btn_Grafico) Herramientas_Ppal.btn_Grafico.enabled = estado;
      }
      
      private function cambiarDiseEstadoBotones(estado:Boolean, boton:Object = null) {
         if (boton != btn_seccionVolver) btn_seccionVolver.enabled = estado;
         if (boton != btn_seccionButaca) btn_seccionButaca.enabled = estado;
         if (boton != btn_seccionMover) btn_seccionMover.enabled = estado;
         if (boton != btn_seccionButacas) btn_seccionButacas.enabled = estado;
         if (boton != btn_seccionNumeracion) btn_seccionNumeracion.enabled = estado;
         if (boton != btn_seccionSalvar) btn_seccionSalvar.enabled = estado;
         if (boton != btn_seccionFormas) btn_seccionFormas.enabled = estado;
         if (boton != btn_seccionTexto) btn_seccionTexto.enabled = estado;
         if (boton != btn_seccionGrafico) btn_seccionGrafico.enabled = estado;
      }
      
      private function mostrarPropiedadesTexto(formAtrTexto: Form_Atributos_Texto) {
         var objLabel:Object;
         var i:int;
         
         formAtrTexto.visible = true;
         
         if (My_Var_In_sEditor.getInstance().Label_Objeto_Seleccionado != null) {
            objLabel = My_Var_In_sEditor.getInstance().Label_Objeto_Seleccionado;
            
            formAtrTexto.cb_fontname.selectedIndex = getIndexFromCombobox(formAtrTexto.cb_fontname, objLabel.atr_fontName);
            formAtrTexto.cb_fontsize.selectedIndex = getIndexFromCombobox(formAtrTexto.cb_fontsize, objLabel.atr_fontSize);
            formAtrTexto.chk_fontbold.selected = objLabel.atr_bold;
            formAtrTexto.chk_fontitalic.selected = objLabel.atr_italic;
            formAtrTexto.txt_fontrotate.text = "";
            formAtrTexto.sel_fontcolor.selectedColor = objLabel.atr_color;
         }
      }
      
      private function getIndexFromCombobox(objcb:Object, str:String):int {
         var i:int;
         var findValue:Boolean;
         var index:int;
         
         index = 0;
         findValue = false;
         for(i = 0; ((i < objcb.length) && (!findValue)); i++) {
            if (objcb.getItemAt(i).label == str) { index = i; findValue = true; }
         }
         return index;
      }
      
      private function crearEventosPropiedadesTexto(formAtrTexto: Form_Atributos_Texto) {
         formAtrTexto.cb_fontname.addEventListener(Event.CHANGE, cb_change_fontname);
         formAtrTexto.cb_fontsize.addEventListener(Event.CHANGE, cb_change_fontsize);
         formAtrTexto.chk_fontbold.addEventListener(Event.CHANGE, chk_change_fontbold);
         formAtrTexto.chk_fontitalic.addEventListener(Event.CHANGE, chk_change_fontitalic);
         formAtrTexto.sel_fontcolor.addEventListener(Event.CHANGE, sel_change_fontcolor);
         formAtrTexto.txt_fontrotate.addEventListener(Event.CHANGE, txt_change_fontrotate);
         
         function cb_change_fontname(event:Event):void { My_Var_In_sEditor.getInstance().Label_Objeto_Seleccionado.atr_fontName = event.target.selectedItem.data; actualizarTexto(); formAtrTexto.Dummy.setFocus(); }
         function cb_change_fontsize(event:Event):void { My_Var_In_sEditor.getInstance().Label_Objeto_Seleccionado.atr_fontSize = event.target.selectedItem.data; actualizarTexto();  formAtrTexto.Dummy.setFocus(); }
         function chk_change_fontbold(event:Event):void { My_Var_In_sEditor.getInstance().Label_Objeto_Seleccionado.atr_bold = int(event.target.selected); actualizarTexto(); formAtrTexto.Dummy.setFocus(); }
         function chk_change_fontitalic(event:Event):void { My_Var_In_sEditor.getInstance().Label_Objeto_Seleccionado.atr_italic = int(event.target.selected); actualizarTexto(); formAtrTexto.Dummy.setFocus(); }
         function sel_change_fontcolor(event:Event):void { My_Var_In_sEditor.getInstance().Label_Objeto_Seleccionado.atr_color = event.target.selectedColor; actualizarTexto(); formAtrTexto.Dummy.setFocus(); }
         function txt_change_fontrotate(event:Event):void { 
            if (!isNaN(Number(event.target.text))) { My_Var_In_sEditor.getInstance().Label_Objeto_Seleccionado.atr_rotate = event.target.text; actualizarTexto(); }
         }
      }
      
      private function actualizarTexto() {
         var objLabel:Object;
         var myFormat:TextFormat;
         
         if (My_Var_In_sEditor.getInstance().Label_Objeto_Seleccionado != null) {
            myFormat = new TextFormat();
            objLabel = My_Var_In_sEditor.getInstance().Label_Objeto_Seleccionado;
            
            myFormat.font = objLabel.atr_fontName;
            myFormat.color = objLabel.atr_color;
            myFormat.size = objLabel.atr_fontSize;
            myFormat.bold = objLabel.atr_bold;
            myFormat.italic = objLabel.atr_italic;
            
            objLabel.Objeto.setStyle("textFormat", myFormat);
            objLabel.Objeto.height = objLabel.atr_fontSize * 1.3;
            
            if (objLabel.atr_rotate > 360) objLabel.atr_rotate %= 360;
            else if (objLabel.atr_rotate < -360) objLabel.atr_rotate %= -360;
            
            objLabel.Objeto.rotationZ = -objLabel.atr_rotate;
         }
      }
      
      private function resetearTextoPropiedades(mainWindow:Boolean) {
         var i:int;
         
         My_Var_In_sEditor.getInstance().Insertar_Label = false;
         My_Var_In_sEditor.getInstance().Escribir_Label = false;
         if (mainWindow) {
            if (My_Var_In_sEditor.getInstance().Label_Objeto_Seleccionado != null) {
               for(i = 0; i < Label_Arreglo.length; i++) {
                  if (Label_Arreglo[i].atr_nombre == My_Var_In_sEditor.getInstance().Label_Objeto_Seleccionado.atr_nombre) {
                     My_Var_In_sEditor.getInstance().Label_Objeto_Seleccionado.Objeto.textField.border = false;
                  }
               }
            }
         }
         else {
            if (My_Var_In_sEditor.getInstance().Label_Objeto_Seleccionado != null) {
               for(i = 0; i < Label_Arreglo_Dise.length; i++) {
                  if (Label_Arreglo_Dise[i].atr_nombre == My_Var_In_sEditor.getInstance().Label_Objeto_Seleccionado.atr_nombre) {
                     My_Var_In_sEditor.getInstance().Label_Objeto_Seleccionado.Objeto.textField.border = false;
                  }
               }
            }
         }
         My_Var_In_sEditor.getInstance().Label_Objeto_Seleccionado = null;
      }
      
      public function crearFormAtributosTexto(Ancho:Number) {
         formAtributosTexto = new Form_Atributos_Texto();
            formAtributosTexto.Dummy.visible = false;
         formAtributosTexto.x = Ancho - formAtributosTexto.width - 150;
         formAtributosTexto.y = 60;
         parent.addChild(formAtributosTexto);
         
         var formAtributosTexto_In:Function = function(e:MouseEvent):void { Mouse.cursor = MouseCursor.HAND; }
         var formAtributosTexto_Out:Function = function(e:MouseEvent):void { Mouse.cursor = MouseCursor.ARROW; }
         
         var formAtributosTexto_Drag:Function = function(e:MouseEvent):void { e.target.parent.startDrag(); }
         var formAtributosTexto_Drop:Function = function(e:MouseEvent):void { e.target.parent.stopDrag(); }
         
         formAtributosTexto.BorderWindow.addEventListener(MouseEvent.MOUSE_MOVE, formAtributosTexto_In);
         formAtributosTexto.BorderWindow.addEventListener(MouseEvent.MOUSE_OUT, formAtributosTexto_Out);
         
         formAtributosTexto.BorderWindow.addEventListener(MouseEvent.MOUSE_DOWN, formAtributosTexto_Drag);
         formAtributosTexto.BorderWindow.addEventListener(MouseEvent.MOUSE_UP, formAtributosTexto_Drop);      
      }
      
      private function mostrarMenusObjetos(mainWindow:Boolean, showMenu:Boolean) {
         var i:int;
         var j:int;
         var k:int;
         var l:int;
         
         if (mainWindow) {
            if (showMenu) {
               for (j=0; j<Polygon_Arreglo.length; j++) Polygon_Arreglo[j].contextMenu = Menu_Pol;
               for (k=0; k<Polygon_Arreglo_Formas.length; k++) Polygon_Arreglo_Formas[k].contextMenu = Menu_Pol_Formas;
               for (i=0; i<Label_Arreglo.length; i++) Label_Arreglo[i].contextMenu = Menu_Pol_Labels;
               for (l=0; l<Graphic_Arreglo.length; l++) Graphic_Arreglo[l].contextMenu = Menu_Pol_Graphics;
            }
            else {
               for (j=0; j<Polygon_Arreglo.length; j++) Polygon_Arreglo[j].contextMenu = null;
               for (k=0; k<Polygon_Arreglo_Formas.length; k++) Polygon_Arreglo_Formas[k].contextMenu = null;
               for (i=0; i<Label_Arreglo.length; i++) Label_Arreglo[i].contextMenu = null;
               for (l=0; l<Graphic_Arreglo.length; l++) Graphic_Arreglo[l].contextMenu = null;
            }
         } else {
            if (showMenu) {
               Board_Dise.contextMenu = Menu_Board_Dise;
               for (k=0; k<Polygon_Arreglo_Formas_Dise.length; k++) Polygon_Arreglo_Formas_Dise[k].contextMenu = Menu_Pol_Formas;
               for (i=0; i<Label_Arreglo_Dise.length; i++) Label_Arreglo_Dise[i].contextMenu = Menu_Pol_Labels;
               for (l=0; l<Graphic_Arreglo_Dise.length; l++) Graphic_Arreglo_Dise[l].contextMenu = Menu_Pol_Graphics;               
            }
            else {
               Board_Dise.contextMenu = null;
               for (k=0; k<Polygon_Arreglo_Formas_Dise.length; k++) Polygon_Arreglo_Formas_Dise[k].contextMenu = null;
               for (i=0; i<Label_Arreglo_Dise.length; i++) Label_Arreglo_Dise[i].contextMenu = null;
               for (l=0; l<Graphic_Arreglo_Dise.length; l++) Graphic_Arreglo_Dise[l].contextMenu = null;            
            }
         }
      }
      
      public function permitirMoverObjetos(mainWindow:Boolean):Boolean {
         if (mainWindow) {
            return ((bloqueadoDesplazamientoVista) && (My_Var_In_sEditor.getInstance().Dibujando_Seccion == false) && (My_Var_In_sEditor.getInstance().Dibujando_Forma == false) && (My_Var_In_sEditor.getInstance().Insertar_Label == false)  && (My_Var_In_sEditor.getInstance().Escribir_Label == false) && (My_Var_In_sEditor.getInstance().Insertando_Grafico == false));   
         }
         return false;
      }
      
      public function centrar_Alerta(e:Object) {
         e.x = (stage.stageWidth/2)-(e.width/2);
         e.y = (stage.stageHeight/2)-(e.height/2);
      }
   }
}