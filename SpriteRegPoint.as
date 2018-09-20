// SpriteRegPoint 1.00: Registration Point control for AS3 - pcthomatos.com
// Copyright (c) 2009 Peterangelo C. Thomatos (pcthomatos.com) and is released under the MIT License <http://www.opensource.org/licenses/mit-license.php>
package  {
    import flash.display.DisplayObject;
    import flash.display.Graphics;
    import flash.display.Sprite;

    /**
     * A Sprite wrapper class that allows one to programatically set a registration point on a display object without the use of the flash IDE. <br/>
     * Options: <br/>
     * <ul>
     * <li>TL - Top Left</li>
     * <li>TC - Top Center</li>
     * <li>TR - Top Right</li>
     * <li>CL - Center Left</li>
     * <li>C - Center</li>
     * <li>CR - Center Right</li>
     * <li>BL - Bottom Left</li>
     * <li>BC - Bottom Center</li>
     * <li>BR - Bottom Right</li>
     * <li>x/y - x/y coordinates</li>
     * </ul>
     * Usage:  <br/>
     <listing version="3.0">
            var squareBox:Sprite = new Sprite();
            squareBox.graphics.beginFill(0xFF0000);
            squareBox.graphics.drawRect(0,0,100,100);

            var centeredSprite:Sprite = new SpriteRegPoint("C");
            centeredSprite.addChild(squareBox);
            addChild(centeredSprite);
            centeredSprite.rotation = 45;
     </listing>
     */
    public class SpriteRegPoint extends Sprite {
        private var registeredSprite:Sprite;
        private var autoReg:Boolean = false;
        private var _registrationPoint:String = null;
        /**
         * If the registrationPoint parameter is set, sets a registration point similar to the way it is set in the flash ide. <br/>
         * If xReg and yReg, sets X,Y registration coordinates. Does not auto update, since hardcoded coordinates are used.<br/>
         * Note: When using graphics classes call this after you're done drawing, call updateRegistrationPoint to update the registration point.
         *
         * @param	registrationPoint - Options are "TL", "TC", "TR", "CL", "C", "CR", "BL", "BC", and "BR"
         * @param	xReg - x registration point coordinate
         * @param	yReg - y registration point coordinate
         */

        public function SpriteRegPoint(registrationPoint:String = null, xReg:Number = NaN, yReg:Number = NaN) {
            super();
            registeredSprite = new Sprite();
            super.addChild(registeredSprite);

            if (registrationPoint && validateRegistrationPoint(registrationPoint)) setRegistrationPoint(registrationPoint.toUpperCase());
            else if (!isNaN(xReg) && !isNaN(yReg)) setRegistrationCoords(xReg, yReg);
        }
        /**
         * Sets a registration point similar to the way it is set in the flash ide.
         * @param	registrationPoint Options are "TL", "TC", "TR", "CL", "C", "CR", "BL", "BC", and "BR"
         * @default null
         */
        public function setRegistrationPoint(registrationPoint:String):void {
            autoReg = true;
            _registrationPoint = registrationPoint;
            updateRegistrationPoint();
        }
        /**
         * Sets X,Y registration coordinates. Does not auto update, since hardcoded coordinates are used.
         * @param	xReg - x registration point coordinate
         * @param	yReg - y registration point coordinate
         */
        public function setRegistrationCoords(xReg:int, yReg:int):void {
            autoReg = false;
            registeredSprite.x = xReg * -1;
            registeredSprite.y = yReg * -1;
        }
        /**
         * When using graphics classes call this after you're done drawing to update the registration point.
         *
         */
        public function updateRegistrationPoint():void {
            switch(_registrationPoint){
                case "TL":
                    registeredSprite.x = 0;
                    registeredSprite.y = 0;
                    break;
                case "TC":
                    registeredSprite.x = registeredSprite.width * -.5;
                    registeredSprite.y = 0;
                    break;
                case "TR":
                    registeredSprite.x = registeredSprite.width;
                    registeredSprite.y = 0;
                    break;
                case "CL":
                    registeredSprite.x = 0;
                    registeredSprite.y = registeredSprite.height * -.5;
                    break;
                case "C":
                    registeredSprite.x = registeredSprite.width * -.5;
                    registeredSprite.y = registeredSprite.height * -.5;
                    break;
                case "CR":
                    registeredSprite.x = registeredSprite.width;
                    registeredSprite.y = registeredSprite.height * -.5;
                    break;
                case "BL":
                    registeredSprite.x = 0;
                    registeredSprite.y = registeredSprite.height;
                    break;
                case "BC":
                    registeredSprite.x = registeredSprite.width * -.5;
                    registeredSprite.y = registeredSprite.height;
                    break;
                case "BR":
                    registeredSprite.x = registeredSprite.width;
                    registeredSprite.y = registeredSprite.height;
                    break;
                default:
                    registeredSprite.x = registeredSprite.width * -.5;
                    registeredSprite.y = registeredSprite.height * -.5;
                    break;
            }

        }

        override public function get graphics():Graphics {
            return registeredSprite.graphics;
        }
        override public function addChild(child:DisplayObject):DisplayObject {
            if(registeredSprite.addChild(child)){
                if(autoReg) updateRegistrationPoint();
                return child;
            }
            return null;
        }
        override public function removeChild(child:DisplayObject):DisplayObject{
            if(registeredSprite.removeChild(child)){
                if(autoReg) updateRegistrationPoint();
                return child;
            }
            return null;
        }
        override public function get numChildren():int {
            return registeredSprite.numChildren;
        }
        override public function addChildAt(child:DisplayObject, index:int):DisplayObject {
            if(registeredSprite.addChildAt(child, index)){
                if(autoReg) updateRegistrationPoint();
                return child;
            }
            return null;
        }
        override public function contains(child:DisplayObject):Boolean {
            return registeredSprite.contains(child);
        }
        override public function getChildAt(index:int):DisplayObject {
            return registeredSprite.getChildAt(index);
        }
        override public function getChildByName(name:String):DisplayObject {
            return registeredSprite.getChildByName(name);
        }
        override public function getChildIndex(child:DisplayObject):int {
            return registeredSprite.getChildIndex(child);
        }
        override public function removeChildAt(index:int):DisplayObject {
            var dObj:DisplayObject = registeredSprite.removeChildAt(index);
            if(autoReg) updateRegistrationPoint();
            return dObj;
        }
        override public function setChildIndex(child:DisplayObject, index:int):void {
            registeredSprite.setChildIndex(child, index);
        }
        override public function swapChildren(child1:DisplayObject, child2:DisplayObject):void {
            registeredSprite.swapChildren(child1, child2);
        }
        override public function swapChildrenAt(index1:int, index2:int):void {
            registeredSprite.swapChildrenAt(index1, index2);
        }

        private function validateRegistrationPoint(registrationPoint:String):Boolean{
            registrationPoint = registrationPoint.toUpperCase();
            if (registrationPoint != "TL" &&
            registrationPoint != "TC" &&
            registrationPoint != "TR" &&
            registrationPoint != "CL" &&
            registrationPoint != "C" &&
            registrationPoint != "CR" &&
            registrationPoint != "BL" &&
            registrationPoint != "BC" &&
            registrationPoint != "BR"){
                trace("Warning: Registration Point Entered is not valid. \n Options are \"TL\", \"TC\", \"TR\", \"CL\", \"C\", \"CR\", \"BL\", \"BC\", and \"BR\"");
                return false;
            }
            return true;
        }
    }

}