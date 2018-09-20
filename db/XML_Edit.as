package db {
	import flash.display.*;
	import flash.display.Stage;
	import flash.display.DisplayObject;
	import flash.events.*;
	import flash.display.MovieClip
	import flash.filters.*;
	import flash.ui.ContextMenu;
	import flash.ui.ContextMenuItem;
	import flash.ui.ContextMenuBuiltInItems;

	import flash.display.Sprite;
	import flash.net.navigateToURL;
	import flash.net.URLRequest;
	import flash.net.URLVariables;
	import flash.net.*;
	import flash.xml.*;
	import flash.events.*;
	import PolygonTest;
	import PointTest;
	import Estilos;
	import Variables;
	
	public class XML_Edit extends MovieClip {
		public var myXML:XML;
		public var XML_URL:String;
		public var myXMLURL:URLRequest;
		public var myLoader:URLLoader;
		public var Recinto_Array_Cargar:Array=[];
		public var vertex_Array_Cargar:Array=[];
		public var Butacas_Array_Cargar:Array=[];
		public var My_Var_In_XML:Variables=new Variables();
		public var Recinto_DB_Salvar:SharedObject;
		
		public var Polygon_Objeto:PolygonTest;
		public var mainFormEditor:Object;
		
		public function XML_Edit(mainForm:Object) { mainFormEditor = mainForm; }
		
		public function Save_Recinto(Herramientas:Object, Seccion_Array:Array, myXML:XML) { 
			var request:URLRequest = new URLRequest(My_Var_In_XML.getInstance().HTTP_SEditor + "flash_saveXML.php");
         request.method = URLRequestMethod.POST;
         
			var vars:URLVariables = new URLVariables();
           	
			vars.vlocked = My_Var_In_XML.getInstance().lockedRecinto;
         	vars.xmlstr = myXML.toString();           
			request.data = vars;
			
			Herramientas.btn_Nuevo.enabled = false;
			Herramientas.btn_Imagen.enabled = false;
			Herramientas.btn_Salvar.enabled = false;
			Herramientas.btn_Mover.enabled = false;
			
         var loader:URLLoader = new URLLoader(request);
			loader.dataFormat = URLLoaderDataFormat.TEXT;
			loader.addEventListener(Event.COMPLETE, onCompleteSaveXML);
			loader.load(request);

			function onCompleteSaveXML(event:Event):void {
				var output:URLVariables = new URLVariables(event.target.data);
				
				Herramientas.btn_Nuevo.enabled = true;
				Herramientas.btn_Imagen.enabled = true;
				Herramientas.btn_Salvar.enabled = true;
				Herramientas.btn_Mover.enabled = true;
				
				if (output.savedb.length == 0) { mainFormEditor.msgRecintoSalvado(); }
				else {
					mainFormEditor.msgErrRecintoSalvar(output.savedb);
				}
			} 
		}
		
		public function Insert_Label(Etiq:Object, myXML:XML) {
			var i:int=0;
			var nodeXML_Etiq:XML=new XML();
		    
			myXML = Delete_Label(Etiq, myXML);
			
			nodeXML_Etiq=<Etiqueta Id_Rec={Etiq.atr_idRec} id_Etiq={Etiq.atr_id} Nombre={Etiq.atr_nombre} x={int(Etiq.x)} y={int(Etiq.y)} Fuente={Etiq.atr_fontName} FuenteTam={Etiq.atr_fontSize} FuenteBold={Etiq.atr_bold} FuenteItalic={Etiq.atr_italic} FuenteColor={Etiq.atr_color} FuenteRotacion={Etiq.atr_rotate} Texto={Etiq.Objeto.text} />
					
			myXML.Recinto[0].Etiquetas[0] = myXML.Recinto[0].Etiquetas[0].appendChild(nodeXML_Etiq);
			return myXML;
		}

		public function Insert_Label_Dise(indexSecc:int, Etiq:Object, myXML:XML) {
			var nodeXML_Etiq:XML=new XML();
			
			myXML = Delete_Label_Dise(indexSecc, Etiq, myXML);
			
			nodeXML_Etiq=<Etiqueta Id_Rec={Etiq.atr_idRec} id_Etiq={Etiq.atr_id} Nombre={Etiq.atr_nombre} x={int(Etiq.x)} y={int(Etiq.y)} Fuente={Etiq.atr_fontName} FuenteTam={Etiq.atr_fontSize} FuenteBold={Etiq.atr_bold} FuenteItalic={Etiq.atr_italic} FuenteColor={Etiq.atr_color} FuenteRotacion={Etiq.atr_rotate} Texto={Etiq.Objeto.text} />	
						 
			myXML.Recinto[0].Secciones[0].Seccion[indexSecc].Etiquetas[0].appendChild(nodeXML_Etiq);
			return myXML;
		}

		public function Insert_Graphic_Dise(indexSecc:int, Graphic:Object, myXML:XML) {
			var nodeXML_Graphic:XML=new XML();
			
			myXML = Delete_Graphic_Dise(indexSecc, Graphic, myXML);
			
			nodeXML_Graphic=<Grafico id_Graf={Graphic.atr_id} Id_Rec={Graphic.atr_idRec} Nombre={Graphic.atr_nombre} x={int(Graphic.x)} y={int(Graphic.y)} Ancho={int(Graphic.width)} Alto={int(Graphic.height)} Tipo={int(Graphic.atr_tipo)} Rotacion={Graphic.atr_rotate} />

			myXML.Recinto[0].Secciones[0].Seccion[indexSecc].Graficos[0].appendChild(nodeXML_Graphic);
			return myXML;
		}
		
		public function Insert_Graphic(Graphic:Object, myXML:XML) {
			var i:int=0;
			var nodeXML_Graphic:XML=new XML();
		    
			myXML = Delete_Graphic(Graphic, myXML);
			
			nodeXML_Graphic=<Grafico id_Graf={Graphic.atr_id} Id_Rec={Graphic.atr_idRec} Nombre={Graphic.atr_nombre} x={int(Graphic.x)} y={int(Graphic.y)} Ancho={int(Graphic.width)} Alto={int(Graphic.height)} Tipo={int(Graphic.atr_tipo)} Rotacion={Graphic.atr_rotate} />
					
			myXML.Recinto[0].Graficos[0] = myXML.Recinto[0].Graficos[0].appendChild(nodeXML_Graphic);
			return myXML;
		}
		
		public function Insert_Secc(Seccion:Object, myXML:XML){
			var nodeXML_Secc:XML=new XML();
			var nodeXML_Vert:XML=new XML();
			var nodeXML_But:XML=new XML();
			var nodeXML_Fig:XML=new XML();
			var nodeXML_Etiq:XML=new XML();
			var nodeXML_Graf:XML=new XML();
			var nodeXML_Vert_Point:XML=new XML();
			var nodeXML_But_Point:XML=new XML();
		   
			nodeXML_Secc=<Seccion Id_Rec={Seccion.Polygon_Recinto_Array[0].Id} id_Secc={Seccion.Polygon_Nombre_Array[0].id} Nombre={Seccion.name} x={Seccion.x} y={Seccion.y} xEt={Seccion.getChildAt(Seccion.getChildIndex(Seccion.getChildByName("Etiqueta"))).x} yEt={Seccion.getChildAt(Seccion.getChildIndex(Seccion.getChildByName("Etiqueta"))).y} But_Libres={Seccion.Polygon_But_Libres} But_Precio={Seccion.Polygon_But_Precio} Num_Inv={int(Seccion.Polygon_Num_Inv)}>
				        </Seccion>;
		
			nodeXML_But= <Butacas />;
			nodeXML_Secc=nodeXML_Secc.appendChild(nodeXML_But);
			for (var j:int=0; j<Seccion.Polygon_Vertex_Array.length; j++) {
				nodeXML_Vert_Point=<_Point x={Seccion.Polygon_Vertex_Array[j].x} y={Seccion.Polygon_Vertex_Array[j].y} />;
				nodeXML_Vert=nodeXML_Vert.appendChild(nodeXML_Vert_Point);
			}
			
			nodeXML_Fig=<Figuras />;
			nodeXML_Secc=nodeXML_Secc.appendChild(nodeXML_Fig);
		
			nodeXML_Etiq=<Etiquetas />;
			nodeXML_Secc=nodeXML_Secc.appendChild(nodeXML_Etiq);
			
			nodeXML_Graf=<Graficos />;
			nodeXML_Secc=nodeXML_Secc.appendChild(nodeXML_Graf);
			
			nodeXML_Vert=<Vertices />;
			nodeXML_Secc=nodeXML_Secc.appendChild(nodeXML_Vert);
			
			myXML.Recinto[0].Secciones[0]=myXML.Recinto[0].Secciones[0].appendChild(nodeXML_Secc);
			return myXML;
		}
		
		public function Insert_Shape(Figura:Object, myXML:XML) {
			var nodeXML_Fig:XML=new XML();
			var nodeXML_Vert:XML=new XML();
			var nodeXML_Vert_Point:XML=new XML();
			
			nodeXML_Fig=<Figura Id_Rec={Figura.Polygon_Recinto_Array[0].Id} id_Fig={Figura.Polygon_Nombre_Array[0].id} Nombre={Figura.name} x={Figura.x} y={Figura.y} >
				         </Figura>;	
			nodeXML_Vert = <Vertices id_Fig={Figura.Polygon_Nombre_Array[0].id} />;
			nodeXML_Fig = nodeXML_Fig.appendChild(nodeXML_Vert);

			for (var j:int=0; j < Figura.Polygon_Vertex_Array.length; j++) {
				nodeXML_Vert_Point=<_Point x={Figura.Polygon_Vertex_Array[j].x} y={Figura.Polygon_Vertex_Array[j].y} />;
				nodeXML_Vert=nodeXML_Vert.appendChild(nodeXML_Vert_Point);
			}
			myXML.Recinto[0].Figuras[0]=myXML.Recinto[0].Figuras[0].appendChild(nodeXML_Fig);
			return myXML;
		}

		public function Insert_Shape_Dise(indexSecc:int, Figura:Object, myXML:XML) {
			var nodeXML_Fig:XML=new XML();
			var nodeXML_Vert:XML=new XML();
			var nodeXML_Vert_Point:XML=new XML();
			
			myXML = Delete_Shape_Dise(indexSecc, Figura, myXML);
			
			nodeXML_Fig=<Figura Id_Rec={Figura.Polygon_Recinto_Array[0].Id} id_Fig={Figura.Polygon_Nombre_Array[0].id} Nombre={Figura.name} x={Figura.x} y={Figura.y} >
				         </Figura>;	
			nodeXML_Vert = <Vertices id_Fig={Figura.Polygon_Nombre_Array[0].id} />;
			nodeXML_Fig = nodeXML_Fig.appendChild(nodeXML_Vert);

			for (var j:int=0; j < Figura.Polygon_Vertex_Array.length; j++) {
				nodeXML_Vert_Point=<_Point x={Figura.Polygon_Vertex_Array[j].x} y={Figura.Polygon_Vertex_Array[j].y} />;
				nodeXML_Vert=nodeXML_Vert.appendChild(nodeXML_Vert_Point);
			}
			myXML.Recinto[0].Secciones[0].Seccion[indexSecc].Figuras[0].appendChild(nodeXML_Fig);
			return myXML;
		}
		
		public function Insert_But(Seccion:Object, Butaca:Object, myXML:XML){
			var nodeXML_But_Point:XML=new XML();
			for (var i:int=0; i<myXML.Recinto[0].Secciones[0].children().length();i++){
				if (myXML.Recinto[0].Secciones[0].Seccion[i].@id_Secc==Seccion.Polygon_Nombre_Array[0].id){
					nodeXML_But_Point= <_Butaca Id_But={Butaca.Id_Butaca} id_Secc={Seccion.Polygon_Nombre_Array[0].id} F={Butaca.Fila} C={Butaca.Columna} E={Butaca.Estado} Q={(int(Butaca.Calidad)/100).toFixed(2)} A={Butaca.Angulo} x={Number(Butaca.x)} y={Number(Butaca.y)}/>;
					myXML.Recinto[0].Secciones[0].Seccion[i].Butacas=myXML.Recinto[0].Secciones[0].Seccion[i].Butacas.appendChild(nodeXML_But_Point);
				}
			}
		   
			return myXML;
		}
		
		public function Delete_Secc(Seccion:Object, myXML:XML){
			for (var i:int=0; i<myXML.Recinto[0].Secciones[0].children().length(); i++ ){
				if (myXML.Recinto[0].Secciones[0].Seccion[i].@id_Secc==Seccion.Polygon_Nombre_Array[0].id){
					delete myXML.Recinto[0].Secciones[0].Seccion[i];
				}
			}
			return myXML;
		}
		
		public function Delete_Shape(Figura:Object, myXML:XML){
			for (var i:int=0; i<myXML.Recinto[0].Figuras[0].children().length(); i++ ){
				if (myXML.Recinto[0].Figuras[0].Figura[i].@id_Fig==Figura.Polygon_Nombre_Array[0].id){
					delete myXML.Recinto[0].Figuras[0].Figura[i];
				}
			}
			return myXML;
		}

		public function Delete_Shape_Dise(indexSecc:int, Figura:Object, myXML:XML){
			for (var i:int=0; i<myXML.Recinto[0].Secciones[0].Seccion[indexSecc].Figuras[0].children().length(); i++ ){
				if (myXML.Recinto[0].Secciones[0].Seccion[indexSecc].Figuras[0].Figura[i].@id_Fig==Figura.Polygon_Nombre_Array[0].id){
					delete myXML.Recinto[0].Secciones[0].Seccion[indexSecc].Figuras[0].Figura[i];
				}
			}
			return myXML;
		}
		
		public function Delete_Label(Etiq:Object, myXML:XML) {
			var i:int;
			
			/* Debemos ver primero si existe la etiqueta, en caso afirmativo la borramos */
			for (i = 0; i < myXML.Recinto[0].Etiquetas[0].children().length(); i++) {
				if (myXML.Recinto[0].Etiquetas[0].Etiqueta[i].@id_Etiq == Etiq.atr_id) {
					delete myXML.Recinto[0].Etiquetas[0].Etiqueta[i];
				}
			}
			return myXML;
		}

		public function Delete_Label_Dise(indexSecc:int, Etiq:Object, myXML:XML){
			for (var i:int=0; i<myXML.Recinto[0].Secciones[0].Seccion[indexSecc].Etiquetas[0].children().length(); i++) {
				if (myXML.Recinto[0].Secciones[0].Seccion[indexSecc].Etiquetas[0].Etiqueta[i].@id_Etiq == Etiq.atr_id) {
					delete myXML.Recinto[0].Secciones[0].Seccion[indexSecc].Etiquetas[0].Etiqueta[i];
				}
			}
			return myXML;
		}
		
		public function Delete_Graphic_Dise(indexSecc:int, Graphic:Object, myXML:XML){
			for (var i:int=0; i<myXML.Recinto[0].Secciones[0].Seccion[indexSecc].Graficos[0].children().length(); i++) {
				if (myXML.Recinto[0].Secciones[0].Seccion[indexSecc].Graficos[0].Grafico[i].@id_Graf == Graphic.atr_id) {
					delete myXML.Recinto[0].Secciones[0].Seccion[indexSecc].Graficos[0].Grafico[i];
				}
			}
			return myXML;
		}
		
		public function Delete_Graphic(Graphic:Object, myXML:XML) {
			var i:int;
			
			/* Debemos ver primero si existe el gráfico, en caso afirmativo la borramos */
			for (i = 0; i < myXML.Recinto[0].Graficos[0].children().length(); i++) {
				if (myXML.Recinto[0].Graficos[0].Grafico[i].@id_Graf == Graphic.atr_id) {
					delete myXML.Recinto[0].Graficos[0].Grafico[i];
				}
			}
			return myXML;
		}
		
	}
}