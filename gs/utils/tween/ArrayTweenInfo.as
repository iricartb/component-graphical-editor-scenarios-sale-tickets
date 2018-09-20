package gs.utils.tween
{

    public class ArrayTweenInfo extends Object
    {
        public var change:Number;
        public var start:Number;
        public var index:uint;

        public function ArrayTweenInfo(param1:uint, param2:Number, param3:Number)
        {
            this.index = param1;
            this.start = param2;
            this.change = param3;
            return;
        }// end function

    }
}
