package {
   import flash.events.*;
   import fl.controls.Label;
   import flash.text.TextFormat;

   public class Estilos extends Label {

      public var Arreglo_Est:Array=[];

      public function Estilos() { }
      
      public function Butacas_St() { }
      
      // Personalizar Poligono
      public function Polygonos_St() {

         // Colores del Poligono
         var Color_Fondo:uint=0x666666;
         var Alpha_Fondo:Number=0.2;
         var Color_Linea:uint =0x000000;
         var Color_Puntos:uint=0xFF0000;
         var Grosor_Linea:uint = 1;
         var Alpha_Fondo_Over:Number=0.4;

         // Etiqueta del Poligono
         var myFormat:TextFormat = new TextFormat();
         myFormat.font = "Verdana";
         myFormat.color=0x000000;
         myFormat.size=11;
         myFormat.bold=true;

         // Arreglo con los Valores
         Arreglo_Est=Arreglo_Est.splice(Arreglo_Est.length);
         Arreglo_Est.push(Color_Fondo);
         Arreglo_Est.push(Alpha_Fondo);
         Arreglo_Est.push(Color_Linea);
         Arreglo_Est.push(Color_Puntos);
         Arreglo_Est.push(Grosor_Linea);
         Arreglo_Est.push(myFormat);
         Arreglo_Est.push(Alpha_Fondo_Over);
         return Arreglo_Est;
      }
      
      public function Herramientas_MPpal_St() {
         // Colores Menu Ppal
         var Color_Mppal:uint = 0x000000;
         var Alpha_Mppal:Number = 1.0;
         var Color_Estado=0x003366;
         var Alpha_Estado:Number = 0.4;
         var Botones_Width:int = 80;
         var Botones_Height:int = 25;
         var Botones_Width_Leyenda:int = 105;
         var Botones_Height_Leyenda:int = 20;
         var Zoom_Width:int=100;

         var myFormat:TextFormat = new TextFormat();
         myFormat.font = "Verdana";
         myFormat.color=0xFFFFFF;
         myFormat.size=11;
         myFormat.bold=false;

         var myFormat_Leyenda:TextFormat = new TextFormat();
         myFormat_Leyenda.font = "Verdana";
         myFormat_Leyenda.color=0x000000;
         myFormat_Leyenda.size=11;
         myFormat_Leyenda.bold=false;
         
         // Arreglo con los Valores
         Arreglo_Est=Arreglo_Est.splice(Arreglo_Est.length);
         Arreglo_Est.push(Color_Mppal);
         Arreglo_Est.push(Alpha_Mppal);
         Arreglo_Est.push(Color_Estado);
         Arreglo_Est.push(Alpha_Estado);
         Arreglo_Est.push(myFormat);
         Arreglo_Est.push(Botones_Width);
         Arreglo_Est.push(Botones_Height);
         Arreglo_Est.push(Zoom_Width);
         Arreglo_Est.push(myFormat_Leyenda);
         Arreglo_Est.push(Botones_Width_Leyenda);
         Arreglo_Est.push(Botones_Height_Leyenda);
         return Arreglo_Est;
      }
      
      public function Herramientas_Mmapa_St() {
         // Colores Menu Ppal
         var Color_Mmpal:uint = 0x993300;
         var Alpha_Mmpal:Number = 1.0;

         // Textos de todos los controles del Mppal
         var myFormat:TextFormat = new TextFormat();
         myFormat.font = "Verdana";
         myFormat.color = 0x000000;
         myFormat.size = 15;
         myFormat.bold = true;

         // Arreglo con los Valores
         Arreglo_Est=Arreglo_Est.splice(Arreglo_Est.length);
         Arreglo_Est.push(Color_Mmpal);
         Arreglo_Est.push(Alpha_Mmpal);
         Arreglo_Est.push(myFormat);
         return Arreglo_Est;
      }
      
      public function Herramientas_Prop_St() {
         // Colores Menu Ppal
         var Color_Prop_Cab:uint =0x993300;          // Color de la Cabecera
         var Color_Prop_Fondo_Cuerpo:uint =0xFFCC99; // Color del Fondo del cuerpo de la Paleta
         var Color_Prop_Borde_Cuerpo:uint =0x993300; // Color del Bore del cuerpo de la Paleta
         var Alpha_Prop:Number =0.6;                  // COlor Alpha de la Paleta

         // Textos de todos los controles del Mppal
         var myFormat:TextFormat = new TextFormat();
         myFormat.font = "Verdana";
         myFormat.color=0x000000;
         myFormat.size=15;
         myFormat.bold=true;

         // Arreglo con los Valores
         Arreglo_Est=Arreglo_Est.splice(Arreglo_Est.length);
         Arreglo_Est.push(Color_Prop_Cab);
         Arreglo_Est.push(Color_Prop_Fondo_Cuerpo);
         Arreglo_Est.push(Color_Prop_Borde_Cuerpo);
         Arreglo_Est.push(Alpha_Prop);
         Arreglo_Est.push(myFormat);
         return Arreglo_Est;
      }
      
      public function Format_PopupSection(bold:Boolean) {
         var myFormat:TextFormat = new TextFormat();
         myFormat.font = "Verdana";
         myFormat.color = 0x000000;
         myFormat.size = 11;
         myFormat.bold = bold;

         return myFormat;
      }
      
      public function Marco_Vista_Dise() {
         /* Formato texto de la barra de herramientas de la vista de diseño */
         var myFormat:TextFormat = new TextFormat();
         myFormat.font = "Verdana";
         myFormat.color = 0xFFFFFF;
         myFormat.size = 12;
         myFormat.bold = true;

         Arreglo_Est=Arreglo_Est.splice(Arreglo_Est.length);
         Arreglo_Est.push(myFormat);
         return Arreglo_Est;
      }

      public function Format_MainInformationRecinto() {
         var myFormat:TextFormat = new TextFormat();
         myFormat.font = "Arial";
         myFormat.color = 0x000000;
         myFormat.size = 11;
         myFormat.bold = true;

         return myFormat;
      }
      
      public function Format_DiseInformationSeccion() {
         var myFormat:TextFormat = new TextFormat();
         myFormat.font = "Arial";
         myFormat.color = 0x000000;
         myFormat.size = 11;
         myFormat.bold = true;

         return myFormat;
      }
      
      public function Format_EtiqColoresLeyenda() {
         var myFormat:TextFormat = new TextFormat();
         myFormat.font = "Arial";
         myFormat.color = 0x000000;
         myFormat.size = 11;
         myFormat.bold = false;

         return myFormat;
      }

      public function Format_defaultLabelFormat() {
         var myFormat:TextFormat = new TextFormat();
         myFormat.font = Variables.DEFAULT_LABEL_FONT;
         myFormat.color = Variables.DEFAULT_LABEL_COLOR;
         myFormat.size = Variables.DEFAULT_LABEL_SIZE;
         myFormat.bold = Variables.DEFAULT_LABEL_BOLD;
         myFormat.italic = Variables.DEFAULT_LABEL_ITALIC;
         
         return myFormat;
      }
      
      public function Format_InfoCoordCreatePolygon() {
         var myFormat:TextFormat = new TextFormat();
         myFormat.font = "Arial";
         myFormat.color = 0x000000;
         myFormat.size = 12;
         myFormat.bold = false;

         return myFormat;
      }
      
      public function Format_ColoresPoligonos() {
          var color0:uint = 0x666666;
         var color1:uint = 0xD0000F;
         var color2:uint = 0x005533;
         var color3:uint = 0x0053A7;
         var color4:uint = 0x8A00FF;
         var color5:uint = 0xFF9C00;
         var color6:uint = 0xFF6599;

         /* Define this colors */
         var color7:uint = 0x993300;
         var color8:uint = 0xFCFF00;
         var color9:uint = 0x23FB00;
         var color10:uint = 0x00CBFF;
         var color11:uint = 0xF1B05B;
         var color12:uint = 0xAA66AA;
         var color13:uint = 0x045E7B;
         var color14:uint = 0xC22000;
         var color15:uint = 0xFF00D2;

         Arreglo_Est = Arreglo_Est.splice(Arreglo_Est.length);
         Arreglo_Est.push(color0);
         Arreglo_Est.push(color1);
         Arreglo_Est.push(color2);
         Arreglo_Est.push(color3);
         Arreglo_Est.push(color4);
         Arreglo_Est.push(color5);
         Arreglo_Est.push(color6);
         Arreglo_Est.push(color7);
         Arreglo_Est.push(color8);
         Arreglo_Est.push(color9);
         Arreglo_Est.push(color10);
         Arreglo_Est.push(color11);
         Arreglo_Est.push(color12);
         Arreglo_Est.push(color13);
         Arreglo_Est.push(color14);
         Arreglo_Est.push(color15);
         
         return Arreglo_Est;
      }
   }
}