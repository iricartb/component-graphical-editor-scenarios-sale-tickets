package {
	import flash.display.Sprite;
	import flash.filters.BitmapFilter;
	import flash.filters.BitmapFilterQuality;
	import flash.filters.DropShadowFilter;
	//------------------------------------------
	public class Sombra extends Sprite {
		private var _ruta:Sprite;
		private var _clip:Object;
		//------------------------------------------
		public function Sombra(clip:Object) {
			_ruta = clip.parent;
			_clip = clip;
		}
	}
}