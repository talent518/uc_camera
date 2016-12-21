package com.comsenz.camera.v4.view.components
{
    import flash.display.*;
    import flash.geom.*;
    import flash.utils.*;

    public class AbstractAsset extends Sprite implements IAsset
    {

        public function AbstractAsset()
        {
            return;
        }// end function

        public function beCenterTo(param1:Rectangle) : void
        {
            return;
        }// end function

        protected function _beCenterTo(param1:Rectangle) : void
        {
            this.x = 0.5 * (param1.width - this.width);
            this.y = 0.5 * (param1.height - this.height);
            return;
        }// end function

        protected function _toLocalRect(param1:Rectangle) : Rectangle
        {
            var _loc_2:Object = {};
            _loc_2.x = (param1.x - this.x) / this.scaleX;
            _loc_2.w = param1.width / this.scaleX;
            _loc_2.y = (param1.y - this.y) / this.scaleY;
            _loc_2.h = param1.height / this.scaleY;
            return new Rectangle(_loc_2.x, _loc_2.y, _loc_2.w, _loc_2.h);
        }// end function

        public function importAsset(param1:ByteArray) : void
        {
            return;
        }// end function

        public function snapshoot(param1:Rectangle, param2:Boolean, param3:Rectangle, param4:Boolean = false)
        {
            return;
        }// end function

    }
}
