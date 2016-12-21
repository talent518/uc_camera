package com.comsenz.camera.v4.utils
{
    import flash.display.*;
    import flash.geom.*;

    public class PictureUtil extends Object
    {

        public function PictureUtil()
        {
            return;
        }// end function

        public static function moveBitmapData(param1:BitmapData, param2:int = 0, param3:int = 0) : BitmapData
        {
            var _loc_4:* = new BitmapData(param1.width, param1.height, true, 0);
            _loc_4.copyPixels(param1, param1.rect, new Point(param2, param3));
            return _loc_4;
        }// end function

        public static function adaptBitmapData(param1:BitmapData, param2:Number, param3:Number, param4:Boolean = false) : BitmapData
        {
            var _loc_5:Number = NaN;
            if (!param4)
            {
                _loc_5 = Math.max(param2 / param1.width, param3 / param1.height);
            }
            else
            {
                _loc_5 = Math.min(param2 / param1.width, param3 / param1.height);
            }
            var _loc_6:* = new BitmapData(param1.width * _loc_5, param1.height * _loc_5, true, 0);
            var _loc_7:* = new Matrix();
            _loc_7.scale(_loc_5, _loc_5);
            _loc_6.draw(param1, _loc_7, null, null, null, true);
            return _loc_6;
        }// end function

        public static function adaptSizeByKeepingScale(param1:DisplayObject, param2:Number, param3:Number, param4:Boolean = false) : void
        {
            var _loc_5:* = param1.width / param2;
            var _loc_6:* = param1.height / param3;
            var _loc_7:* = param4 ? (Math.max(_loc_5, _loc_6)) : (Math.min(_loc_5, _loc_6));
            _loc_7 = (param4 ? (Math.max(_loc_5, _loc_6)) : (Math.min(_loc_5, _loc_6))) < 1 ? (1) : (_loc_7);
            param1.scaleX = param1.scaleX / _loc_7;
            param1.scaleY = param1.scaleY / _loc_7;
            return;
        }// end function

    }
}
