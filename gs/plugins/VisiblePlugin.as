package gs.plugins
{
    import gs.*;

    public class VisiblePlugin extends TweenPlugin
    {
        protected var _target:Object;
        protected var _visible:Boolean;
        protected var _tween:TweenLite;
        public static const VERSION:Number = 1;
        public static const API:Number = 1;

        public function VisiblePlugin()
        {
            this.propName = "visible";
            this.overwriteProps = ["visible"];
            this.onComplete = this.onCompleteTween;
            return;
        }// end function

        public function onCompleteTween() : void
        {
            if (this._tween.vars.runBackwards != true && this._tween.ease == this._tween.vars.ease)
            {
                this._target.visible = this._visible;
            }
            return;
        }// end function

        override public function onInitTween(param1:Object, param2, param3:TweenLite) : Boolean
        {
            this._target = param1;
            this._tween = param3;
            this._visible = Boolean(param2);
            return true;
        }// end function

        override public function set changeFactor(param1:Number) : void
        {
            if (this._target.visible != true)
            {
                this._target.visible = true;
            }
            return;
        }// end function

    }
}
