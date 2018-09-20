package {
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import flash.text.*;
   import fl.controls.*;
   import Estilos;
   import Variables;

   public class PolygonTest extends Sprite {
      private var _lineContainer:Sprite;
      private var _pointList:Array;
      public var Polygon_Act_Mod:Boolean=false;
      public var Polygon_Renombrar:Boolean=false;
      public var Polygon_Marca:String="P_Marca";
      public var Polygon_Id:String;
      public var _Est:Estilos;
      
      public var Polygon_Vertex_Array:Array=[];
      public var Polygon_Posicion_Array:Array=[];
      public var Polygon_Nombre_Array:Array=[];      
      public var Polygon_Recinto_Array:Array=[];      
      public var Polygon_But_Array:Array=[];
      public var Polygon_But_Escala:int;
      public var Polygon_But_Post_Array:Array=[];
      public var Polygon_But_FC_Array:Array=[];
      public var Polygon_But_Libres:Number = 0.0;
      public var Polygon_But_Totales:int = 0;
      public var Polygon_But_Precio:String="0.0";
      public var Polygon_Eliminado:Boolean=false;
      public var Puntos_Ocultos:Boolean=false;
      public var Global_Variables:Variables;
      public var esSeccion:Boolean = true;
      public var Polygon_Color:uint;
      public var Polygon_Num_Inv:Boolean;
      
      public function PolygonTest(vertex:Array, Polygon_Etiqueta_text:String, Global_Vars:Variables, locked:Boolean = false, Secc:Boolean = true) {
         this._pointList = new Array();
         this._lineContainer = new Sprite();
         addChild(this._lineContainer);
         Global_Variables = Global_Vars;
         esSeccion = Secc;
         _Est=new Estilos;
         this.createPoints(vertex,Polygon_Etiqueta_text, locked);
         this.drawLines(_Est.Polygonos_St()[0]);
         return;
      }
      
      private function createPoints(_loc_1:Array,Etiqueta_text:String, locked:Boolean = false):void {
         var _loc_2:PointTest = null;
         var _loc_3:Object = null;
         for each (_loc_3 in _loc_1) {
            _loc_2 = new PointTest();
            _loc_2.x = _loc_3.x;
            _loc_2.y = _loc_3.y;
            this._pointList.push(_loc_2);
            _loc_2.name="P";
            addChild(_loc_2);
         }
         
         var _Pol_Marco:* = null;
         _Pol_Marco=new PolygonEtiq(_loc_1,Etiqueta_text, Global_Variables, locked);
         var i:int=0;
         var SumX:int=0;
         var SumY:int=0;
         for (i=0; i<_loc_1.length; i++) {
            SumX=SumX+_loc_1[i].x;
            SumY=SumY+_loc_1[i].y;
         }
         
         SumX=SumX/_loc_1.length;
         SumY=SumY/_loc_1.length;
         _Pol_Marco.x = SumX;
         _Pol_Marco.y = SumY;
         addChild(_Pol_Marco);
         return;
      }

      public function drawLines(backgroundColorPol:uint):void {
         var _loc_2:* = null;
         var _loc_1:* = this._lineContainer.graphics;
         _loc_1.clear();
         _loc_1.lineStyle( _Est.Polygonos_St()[4], _Est.Polygonos_St()[2],1);
         _loc_1.beginFill(backgroundColorPol,_Est.Polygonos_St()[1]);
         _loc_1.moveTo(this._pointList[0].x, this._pointList[0].y);
         
         for each (_loc_2 in this._pointList) {
            _loc_1.lineTo(_loc_2.x, _loc_2.y);
         }
         
         _loc_1.lineTo(this._pointList[0].x, this._pointList[0].y);
         return;
      }

      public function drawLinesOver(backgroundColorPol:uint):void {
         var _loc_2:* = null;
         var _loc_1:* = this._lineContainer.graphics;
         _loc_1.clear();
         _Est=new Estilos;

         _loc_1.lineStyle(_Est.Polygonos_St()[4], _Est.Polygonos_St()[2],1);
         _loc_1.beginFill(backgroundColorPol,_Est.Polygonos_St()[6]);
         _loc_1.moveTo(this._pointList[0].x, this._pointList[0].y);
         
         for each (_loc_2 in this._pointList) {
            _loc_1.lineTo(_loc_2.x, _loc_2.y);
         }
         
         _loc_1.lineTo(this._pointList[0].x, this._pointList[0].y);
         return;
      }
   }
}