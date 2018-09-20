package {
   import flash.ui.*;
   import flash.display.*;
   import flash.events.*;
   import flash.filters.*;
   import flash.geom.*;
   import Variables;
   
   public class AccionesButacas extends MovieClip {
      public var But_C_M_Form:Form_But_C_M;
      public var sombra:DropShadowFilter=new DropShadowFilter();
      public var _Block:Block;
      public var Angulo_Valor:int;
      public var Marca_Temp:Sprite;
      public var My_Var_In_Acciones:Variables= new Variables();
      private var Point_Ini:Point=new Point(0,0);
      private var Point_End:Point=new Point(0,0);
      private var Marca_But_Temp:Sprite;
      private var But_C_M_Form_Cancelar:Function;
      private var But_Array:Array=[];
      private var ini_marcar_butacas:Boolean = false;
      private var My_Var_In_sEditor:Variables;
      
      public function AccionesButacas() { }
      
      /* Creamos los eventos principales para poder seleccionar butacas */
      public function Marcar_Butacas(Board_Dise:Object, Global_vars:Variables) {
         My_Var_In_sEditor = Global_vars;
         Marca_But_Temp = new Sprite();
         Desmarcar_Butacas(Board_Dise);
         
         var Metodo_Marcar_Butacas_End:Function = function(e:MouseEvent){Ventana_Marcar_Butacas_End(e,Board_Dise, Metodo_Marcar_Butacas_End, Metodo_Ventana_Crear)};
         Board_Dise.addEventListener(MouseEvent.MOUSE_UP, Metodo_Marcar_Butacas_End);
         
         var Metodo_Marcar_Butacas_Ini:Function = function(e:MouseEvent){Ventana_Marcar_Butacas_Ini(e,Board_Dise)};
         Board_Dise.addEventListener(MouseEvent.MOUSE_DOWN, Metodo_Marcar_Butacas_Ini);
         
         var Metodo_Ventana_Crear:Function = function (e:MouseEvent){Ventana_Crear(e,Board_Dise, Metodo_Ventana_Crear)};
         Board_Dise.addEventListener(MouseEvent.MOUSE_MOVE, Metodo_Ventana_Crear);
      }
      
      /* @Evento inicial para crear una ventana de selección, capturamos el punto inicial para crear la ventana */
      public function Ventana_Marcar_Butacas_Ini(e:MouseEvent, Board_Dise:Object) {
         if ((My_Var_In_Acciones.getInstance().Mover_Seccion == false) && (My_Var_In_Acciones.getInstance().Dibujando_Forma == false) && (My_Var_In_Acciones.getInstance().Moviendo_Objeto == false) && (My_Var_In_Acciones.getInstance().Creando_Objeto == false)) {
            if (e.target.name != "But") {
               My_Var_In_Acciones.getInstance().Marcar_Butaca = true;
               if (My_Var_In_Acciones.getInstance().ControlKey_Pressed == false) Desmarcar_Butacas(Board_Dise);
               ini_marcar_butacas = true;
               Point_Ini.x = Board_Dise.mouseX;
               Point_Ini.y = Board_Dise.mouseY;
               Board_Dise.addChild(Marca_But_Temp);
            }
         }
      }
      
      /* @Evento llamado cuando se mueve el ratón para poder redimensionar la ventana de selección */
      private function Ventana_Crear(e:MouseEvent, Board_Dise:Object, Metodo_Marcar_Crear:Function) {
         if ((My_Var_In_Acciones.getInstance().Mover_Seccion == false) && (My_Var_In_Acciones.getInstance().Dibujando_Forma == false) && (My_Var_In_Acciones.getInstance().Moviendo_Objeto == false) && (My_Var_In_Acciones.getInstance().Creando_Objeto == false)) {
            if (ini_marcar_butacas) {
               Marca_But_Temp.graphics.clear();
               Marca_But_Temp.graphics.lineStyle(1, 0x808080, 1);
               Marca_But_Temp.graphics.beginFill(0x808080, 0.2);
               Marca_But_Temp.graphics.drawRect(Point_Ini.x, Point_Ini.y, Board_Dise.mouseX-Point_Ini.x, Board_Dise.mouseY-Point_Ini.y);
               Point_End.x = Board_Dise.mouseX;
               Point_End.y = Board_Dise.mouseY;
            }
         }
         else if (My_Var_In_Acciones.getInstance().Mover_Seccion) { Mouse.cursor = MouseCursor.HAND; }   
      }
      
      /* @Evento de finalización de creación de una ventana de selección */
      public function Ventana_Marcar_Butacas_End(e:MouseEvent, Board_Dise:Object, Metodo_Marcar_Butacas:Function, Metodo_Marcar_Crear:Function) {
         if ((My_Var_In_Acciones.getInstance().Mover_Seccion == false) && (My_Var_In_Acciones.getInstance().Dibujando_Forma == false) && (My_Var_In_Acciones.getInstance().Moviendo_Objeto == false) && (My_Var_In_Acciones.getInstance().Creando_Objeto == false)) {
            if (ini_marcar_butacas) {
               ini_marcar_butacas = false;
                  
               for (var i:int=0; i<Board_Dise.numChildren; i++) {
                  if (Board_Dise.getChildAt(i).name != undefined && Board_Dise.getChildAt(i).name == "But") {
                     if (Board_Dise.getChildAt(i).hitTestObject(Marca_But_Temp) == true) {
                        Resaltar_Butaca(Board_Dise.getChildAt(i));
                        Board_Dise.getChildAt(i).But_Marcada=true;
                     }
                  }
               }
               Contar_Butacas(Board_Dise);
               
               Marca_But_Temp.graphics.clear();
               My_Var_In_Acciones.getInstance().Marcar_Butaca = false;
               Board_Dise.removeChild(Marca_But_Temp);
            }
         }
      }
      
      /* @Evento llamado al pulsar la opción del menú contextual de desmarcar todas las butacas */
      public function Desmarcar_Butacas(Board_Dise:Object) {
         for (var i:int=0; i<Board_Dise.numChildren; i++) {
            if (Board_Dise.getChildAt(i).name!=undefined&&Board_Dise.getChildAt(i).name=="But") {
               Resaltar_Del_Butaca(Board_Dise.getChildAt(i));
               Board_Dise.getChildAt(i).But_Marcada=false;
            }
         }
         My_Var_In_Acciones.getInstance().Butacas_Marcadas=0;
      } 
      
      /* @Evento llamado al cambiar los estados de las butacas */
      public function Marcar_Butacas_Modificadas(Board_Dise:Object) {
         for (var i:int=0; i<Board_Dise.numChildren; i++) {
            if (Board_Dise.getChildAt(i).name != undefined && Board_Dise.getChildAt(i).name == "But" && Board_Dise.getChildAt(i).But_Marcada == true) {
               Board_Dise.getChildAt(i).But_Modificada = true;
            }
         }
      }
      
      /* @Evento llamado al pulsar la opción del menú contextual de marcar todas las butacas */
      public function Marcar_Todas_Butacas(Board_Dise:Object) {
         for (var i:int=0; i<Board_Dise.numChildren; i++) {
            if (Board_Dise.getChildAt(i).name!=undefined&&Board_Dise.getChildAt(i).name=="But") {
               Resaltar_Butaca(Board_Dise.getChildAt(i));
               Board_Dise.getChildAt(i).But_Marcada=true;
            }
         }
         Contar_Butacas(Board_Dise);
      }
      
      /* Snap de la butaca */
      public function Resaltar_Butaca(Butaca:Object) {
         if (Butaca.Estado == "Libre") { Butaca.gotoAndStop(4); }
         if (Butaca.Estado == "Ocupada") { Butaca.gotoAndStop(5); }
         if (Butaca.Estado == "Asignada") { Butaca.gotoAndStop(6); }
         if (Butaca.Estado == "Averiada") { Butaca.gotoAndStop(8); }
         if (Butaca.Estado == "Reservada") { Butaca.gotoAndStop(10); }
         if (Butaca.Estado == "EnReserva") { Butaca.gotoAndStop(12); }
         
         if (Butaca.Estado == "Cia") { Butaca.gotoAndStop(14); }
         if (Butaca.Estado == "Invitacion") { Butaca.gotoAndStop(16); }
         if (Butaca.Estado == "Prensa") { Butaca.gotoAndStop(18); }
         if (Butaca.Estado == "Sorteo") { Butaca.gotoAndStop(20); }
         if (Butaca.Estado == "Tecnico") { Butaca.gotoAndStop(22); }
         if (Butaca.Estado == "Gestor") { Butaca.gotoAndStop(24); }
         if (Butaca.Estado == "NoVenta") { Butaca.gotoAndStop(26); }
      }
      
      /* Snap de la butaca */
      public function Resaltar_Del_Butaca(Butaca:Object) {
         if (Butaca.Estado == "Libre") { Butaca.gotoAndStop(1); }
         if (Butaca.Estado == "Ocupada") { Butaca.gotoAndStop(2); }
         if (Butaca.Estado == "Asignada") { Butaca.gotoAndStop(3); }
         if (Butaca.Estado == "Averiada") { Butaca.gotoAndStop(7); }
         if (Butaca.Estado == "Reservada") { Butaca.gotoAndStop(9); }
         if (Butaca.Estado == "EnReserva") { Butaca.gotoAndStop(11); }
         
         if (Butaca.Estado == "Cia") { Butaca.gotoAndStop(13); }
         if (Butaca.Estado == "Invitacion") { Butaca.gotoAndStop(15); }
         if (Butaca.Estado == "Prensa") { Butaca.gotoAndStop(17); }
         if (Butaca.Estado == "Sorteo") { Butaca.gotoAndStop(19); }
         if (Butaca.Estado == "Tecnico") { Butaca.gotoAndStop(21); }
         if (Butaca.Estado == "Gestor") { Butaca.gotoAndStop(23); }
         if (Butaca.Estado == "NoVenta") { Butaca.gotoAndStop(25); }
      }

      /* @Evento llamado al pulsar la opción de colocar matriz de butacas */
      public function Form_But_C_Matriz(Board_Dise:Object) {
         var Info_F_C:Array=[];
         But_C_M_Form= new Form_But_C_M();
         _Block = new Block();
         Board_Dise.stage.addChild(_Block);
         Board_Dise.stage.addChild(But_C_M_Form);
         centrar_Alerta(But_C_M_Form);

         function _But_C_M_Form_Cancelar() {
            Info_F_C.push({F:1, C:1});
            Board_Dise.stage.removeChild(_Block);
            Board_Dise.stage.removeChild(But_C_M_Form);
            return Info_F_C;
         }
         
         But_C_M_Form.Btn_Cancelar.addEventListener(MouseEvent.MOUSE_DOWN, _But_C_M_Form_Cancelar);
      }

      /* Cuenta el número de butacas seleccionadas */
      public function Contar_Butacas(Board_Dise:Object) {
         My_Var_In_Acciones.getInstance().Butacas_Marcadas=0;
         for (var i:int=0; i<Board_Dise.numChildren; i++) {
            if (Board_Dise.getChildAt(i).name!=undefined&&Board_Dise.getChildAt(i).name=="But"&&Board_Dise.getChildAt(i).But_Marcada==true) {
               My_Var_In_Acciones.getInstance().Butacas_Marcadas = My_Var_In_Acciones.getInstance().Butacas_Marcadas+1;
               My_Var_In_Acciones.getInstance().Ultima_Butaca_Marcada = Board_Dise.getChildAt(i);
            }
         }
      }
      
      /* Comprueba la selección de las butacas */   
      public function Comprobar(Board_Dise:Object) {
         var X:Array=[];
         var Y:Array=[];
         var Valor:Array=[]
         var Count:int=0;
         Valor.push({F:"N", C:"N"});
         for (var i:int=0; i<Board_Dise.numChildren; i++) {
            if (Board_Dise.getChildAt(i).name!=undefined&&Board_Dise.getChildAt(i).name=="But"&&Board_Dise.getChildAt(i).But_Marcada==true) {
                    Count=0;
               for (var J:int=0; J<X.length; J++){
                  if (Board_Dise.getChildAt(i).x==X[J]){
                     Count++;
                  }
               }
               if (Count==0){
                  X.push(Board_Dise.getChildAt(i).x);   
               } else {
                  Valor[0].F="Y"
               }
               Count=0;
               for (var H:int=0; H<X.length; H++){
                  if (Board_Dise.getChildAt(i).y==Y[H]){
                     Count++;
                  }
               }
                     if (Count==0){
                  Y.push(Board_Dise.getChildAt(i).y);   
               } else {
                  Valor[0].C="Y"
               }
            }
         }
         return Valor;
      }
      
      /* Modificar un rango de butacas - sus propiedades: filas, columnas, angulo... */
      public function Cambiar(Board_Dise:Object, Cambiar:Array) {
         var pasos_fila:int = 0;
         var pasos_columna:int = 0;
         var gridSizeFila:Number = My_Var_In_Acciones.getInstance().Numero_MaxElem_Propiedades_Fila;
         var gridSizeColumna:Number = My_Var_In_Acciones.getInstance().Numero_MaxElem_Propiedades_Columna;
         var matriz:Array = new Array(gridSizeFila);
         var minX:int = int.MAX_VALUE;
         var minY:int = int.MAX_VALUE;
         var i:int;
         var j:int;
         var fil:int;
         var col:int;
         var ascii_val:int;
         
         /* Inicializamos la matriz a elementos vacios */
         for (i = 0; i < gridSizeFila; i++) {
             matriz[i] = new Array(gridSizeColumna);
             for (j = 0; j < gridSizeColumna; j++) {
                 matriz[i][j] = null;
             }
         }
         
         /* Seleccionamos de todos los elementos marcados los dos ejes con coordenada mas cercana al (0,0) */
         for (i = 0; i < Board_Dise.numChildren; i++) {
            if (Board_Dise.getChildAt(i).name != undefined && Board_Dise.getChildAt(i).name == "But" && Board_Dise.getChildAt(i).But_Marcada == true) {
               if (((2490 + Board_Dise.getChildAt(i).x)/30) < minX) minX = ((2490 + Board_Dise.getChildAt(i).x)/30);
               if (((2490 + Board_Dise.getChildAt(i).y)/30) < minY) minY = ((2490 + Board_Dise.getChildAt(i).y)/30);
            }
         }
         
         /* Mapeamos la matriz con las butacas seleccionadas */
         for (i = 0; i < Board_Dise.numChildren; i++) {
            if (Board_Dise.getChildAt(i).name != undefined && Board_Dise.getChildAt(i).name == "But" && Board_Dise.getChildAt(i).But_Marcada == true) {
               fil = ((2490 + Board_Dise.getChildAt(i).y)/30) - minY;
               col = ((2490 + Board_Dise.getChildAt(i).x)/30) - minX;
               matriz[fil][col] = Board_Dise.getChildAt(i);
            }
         }
         
         /* Ejecutamos los cambios */
         for (i = 0; i < gridSizeFila; i++) {
             for (j = 0; j < gridSizeColumna; j++) {
                 if (matriz[i][j] != null) {
                  if ((Cambiar[0].F).length > 0) {
                     if (!isNaN(Number(Cambiar[0].F))) {
                        if (Cambiar[0].I == false) {
                           matriz[i][j].Fila = Number(Cambiar[0].F) + pasos_fila;
                           if (matriz[i][j].Fila <= 0) matriz[i][j].Fila = 1;
                        }
                        else {
                           matriz[i][j].Fila = Number(Cambiar[0].C) + pasos_columna;
                           if (matriz[i][j].Fila <= 0) matriz[i][j].Fila = 1;
                        }
                     }
                     else {
                        if (Cambiar[0].I == false) {
                           ascii_val = ((Cambiar[0].F).charCodeAt(0) + pasos_fila - 13) % 26;
                           ascii_val += 65;
                           matriz[i][j].Fila = String.fromCharCode(ascii_val);
                        }
                        else {
                           ascii_val = ((Cambiar[0].C).charCodeAt(0) + pasos_columna - 13) % 26;
                           ascii_val += 65;
                           matriz[i][j].Fila = String.fromCharCode(ascii_val);               
                        }
                     }
                  }
                  if ((Cambiar[0].C).length > 0) {
                     if (!isNaN(Number(Cambiar[0].C))) {
                        if (Cambiar[0].I == false) {
                           matriz[i][j].Columna = Number(Cambiar[0].C) + pasos_columna;
                           if (matriz[i][j].Columna <= 0) matriz[i][j].Columna = 1;
                        }
                        else {
                           matriz[i][j].Columna = Number(Cambiar[0].F) + pasos_fila;
                           if (matriz[i][j].Columna <= 0) matriz[i][j].Columna = 1;
                        }
                     }
                     else {
                        if (Cambiar[0].I == false) {
                           ascii_val = ((Cambiar[0].C).charCodeAt(0) + pasos_columna - 13) % 26;
                           ascii_val += 65;
                           matriz[i][j].Columna = String.fromCharCode(ascii_val);
                        }
                        else {
                           ascii_val = ((Cambiar[0].F).charCodeAt(0) + pasos_fila - 13) % 26;
                           ascii_val += 65;
                           matriz[i][j].Columna = String.fromCharCode(ascii_val);
                        }
                     }
                  }
                   matriz[i][j].Estado = Cambiar[0].E;
                    matriz[i][j].Angulo = Cambiar[0].A;
                  if ((Cambiar[0].Q).length > 0) matriz[i][j].Calidad = int(Cambiar[0].Q);
                  matriz[i][j].rotation = int(Cambiar[0].A)*-1;

                  if (matriz[i][j].Estado == "Libre") matriz[i][j].gotoAndStop(4);
                     if (matriz[i][j].Estado == "Ocupada") matriz[i][j].gotoAndStop(5);
                     if (matriz[i][j].Estado == "Asignada") matriz[i][j].gotoAndStop(6);
                  if (matriz[i][j].Estado == "Averiada") matriz[i][j].gotoAndStop(8);
                  if (matriz[i][j].Estado == "Reservada") matriz[i][j].gotoAndStop(10);
                  if (matriz[i][j].Estado == "EnReserva") matriz[i][j].gotoAndStop(12);
                  
                  if (matriz[i][j].Estado == "Cia") { matriz[i][j].gotoAndStop(14); }
                  if (matriz[i][j].Estado == "Invitacion") { matriz[i][j].gotoAndStop(16); }
                  if (matriz[i][j].Estado == "Prensa") { matriz[i][j].gotoAndStop(18); }
                  if (matriz[i][j].Estado == "Sorteo") { matriz[i][j].gotoAndStop(20); }
                  if (matriz[i][j].Estado == "Tecnico") { matriz[i][j].gotoAndStop(22); }
                  if (matriz[i][j].Estado == "Gestor") { matriz[i][j].gotoAndStop(24); }
                  if (matriz[i][j].Estado == "NoVenta") { matriz[i][j].gotoAndStop(26); }
               }
               pasos_columna = pasos_columna + Number(Cambiar[0].CP);
             }
            pasos_fila = pasos_fila + Number(Cambiar[0].FP);
            pasos_columna = 0;
         }
      }
      
      /* Obtener las coordenadas de las butacas mas cercanas al punto (0,0) */
      public function get_ButacaMin(Board_Dise:Object):Array {
         var minX:int = int.MAX_VALUE;
         var minY:int = int.MAX_VALUE;
         var i:int;
         
         for (i = 0; i < Board_Dise.numChildren; i++) {
            if (Board_Dise.getChildAt(i).name != undefined && Board_Dise.getChildAt(i).name == "But" && Board_Dise.getChildAt(i).But_Marcada == true) {
               if (((2490 + Board_Dise.getChildAt(i).x)/30) < minX) minX = ((2490 + Board_Dise.getChildAt(i).x)/30);
               if (((2490 + Board_Dise.getChildAt(i).y)/30) < minY) minY = ((2490 + Board_Dise.getChildAt(i).y)/30);
            }
         }
         
         var array:Array = new Array(2);
         array[0] = minX;
         array[1] = minY;
         return array;
      }

      /* Obtener las coordenadas de las butacas mas lejanas del punto (0,0) */
      public function get_ButacaMax(Board_Dise:Object):Array {
         var maxX:int = int.MIN_VALUE;
         var maxY:int = int.MIN_VALUE;
         var i:int;
         
         for (i = 0; i < Board_Dise.numChildren; i++) {
            if (Board_Dise.getChildAt(i).name != undefined && Board_Dise.getChildAt(i).name == "But" && Board_Dise.getChildAt(i).But_Marcada == true) {
               if (((2490 + Board_Dise.getChildAt(i).x)/30) > maxX) maxX = ((2490 + Board_Dise.getChildAt(i).x)/30);
               if (((2490 + Board_Dise.getChildAt(i).y)/30) > maxY) maxY = ((2490 + Board_Dise.getChildAt(i).y)/30);
            }
         }
         
         var array:Array = new Array(2);
         array[0] = maxX;
         array[1] = maxY;
         return array;
      }
      
      /* Centrar un popup de alerta */
      public function centrar_Alerta(e:Object) {
         e.filters=[sombra];
         e.x=(e.stage.stageWidth/2)-(e.width/2);
         e.y=(e.stage.stageHeight/2)-(e.height/2);
      }
   }
}