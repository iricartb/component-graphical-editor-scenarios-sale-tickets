package {
   import flash.display.Sprite;
   import flash.utils.Timer;
   import flash.events.TimerEvent;

   public class Delay {
      private static var _ruta:Sprite;
      private static var _tiempo:Number;
      private static var _timer:Timer;
      private static var _accion:String;

      public static function action(tiempo:Number,segundos:Boolean,ruta:Sprite,accion:String) {
         _ruta = ruta;
         _accion = accion;
         _tiempo = (segundos == true) ? tiempo * 1000 : tiempo / _ruta.stage.frameRate * 1000 ;
         _timer = new Timer(_tiempo, 1);
         _timer.addEventListener(TimerEvent.TIMER, ejecuta);
         _timer.start();
      }

      private static function ejecuta(event:TimerEvent) {
         _ruta[_accion]();
      }

      public static function reset() {
         _timer.reset();
      }
   }
}