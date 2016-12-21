package com.comsenz.camera.v4.utils
{
    import flash.display.*;
    import flash.geom.*;

    public class BasicGeom extends Sprite
    {

        public function BasicGeom()
        {
            return;
        }// end function

        public static function drawRoundRectSprite(param1:uint, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number, param7:Number, param8:Number, param9:Boolean = false, param10:Number = 0, param11:Number = 1, param12:Number = 1) : Sprite
        {
            var _loc_13:* = new Sprite();
            _loc_13.addChild(drawRoundRect(param1, param2, param3, param4, param5, param6, param7, param8, param9, param10, param11, param12));
            return _loc_13;
        }// end function

        public static function drawCircle(param1:Number, param2:Number, param3:Number, param4:Number = 0, param5:Number = 1, param6:Boolean = false, param7:Number = 0, param8:Number = 1, param9:Number = 1) : Shape
        {
            var _loc_10:* = new Shape();
            if (param6)
            {
                _loc_10.graphics.lineStyle(param9, param7, param8);
            }
            else
            {
                _loc_10.graphics.lineStyle(0, param7, 0);
            }
            _loc_10.graphics.beginFill(param4, param5);
            _loc_10.graphics.drawCircle(param1, param2, param3);
            _loc_10.graphics.endFill();
            return _loc_10;
        }// end function

        public static function drawMutiLine(param1:Array, param2:Number = 0, param3:Number = 1, param4:Number = 1) : Shape
        {
            var _loc_5:* = new Shape();
            var _loc_6:Array = [];
            var _loc_7:uint = 0;
            while (_loc_7 < (param1.length - 1))
            {
                
                _loc_6.push([param1[_loc_7], param1[(_loc_7 + 1)]]);
                _loc_7 = _loc_7 + 1;
            }
            var _loc_8:uint = 0;
            while (_loc_8 < _loc_6.length)
            {
                
                _loc_5.graphics.lineStyle(param4, param2, param3);
                _loc_5.graphics.moveTo(Point(_loc_6[_loc_8][0]).x, Point(_loc_6[_loc_8][0]).y);
                _loc_5.graphics.lineTo(Point(_loc_6[_loc_8][1]).x, Point(_loc_6[_loc_8][1]).y);
                _loc_8 = _loc_8 + 1;
            }
            return _loc_5;
        }// end function

        public static function drawRect(param1:uint, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number, param7:Boolean = false, param8:Number = 0, param9:Number = 1, param10:Number = 1) : Shape
        {
            var _loc_11:* = new Shape();
            if (param7)
            {
                _loc_11.graphics.lineStyle(param10, param8, param9);
            }
            else
            {
                _loc_11.graphics.lineStyle(0, param8, 0);
            }
            _loc_11.graphics.beginFill(param1, param2);
            _loc_11.graphics.drawRect(param3, param4, param5, param6);
            _loc_11.graphics.endFill();
            return _loc_11;
        }// end function

        public static function drawCircleSprite(param1:Number, param2:Number, param3:Number, param4:Number = 0, param5:Number = 1, param6:Boolean = false, param7:Number = 0, param8:Number = 1, param9:Number = 1) : Sprite
        {
            var _loc_10:* = new Sprite();
            _loc_10.addChild(drawCircle(param1, param2, param3, param4, param5, param6, param7, param8, param9));
            return _loc_10;
        }// end function

        public static function drawRectSprite(param1:uint, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number, param7:Boolean = false, param8:Number = 0, param9:Number = 1, param10:Number = 1) : Sprite
        {
            var _loc_11:* = new Sprite();
            _loc_11.addChild(drawRect(param1, param2, param3, param4, param5, param6, param7, param8, param9, param10));
            return _loc_11;
        }// end function

        public static function drawRoundRect(param1:uint, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number, param7:Number, param8:Number, param9:Boolean = false, param10:Number = 0, param11:Number = 1, param12:Number = 1) : Shape
        {
            var _loc_13:* = new Shape();
            if (param9)
            {
                _loc_13.graphics.lineStyle(param12, param10, param11);
            }
            else
            {
                _loc_13.graphics.lineStyle(0, param10, 0);
            }
            _loc_13.graphics.beginFill(param1, param2);
            _loc_13.graphics.drawRoundRect(param3, param4, param5, param6, param7, param8);
            _loc_13.graphics.endFill();
            return _loc_13;
        }// end function

        public static function drawLine(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number = 0, param6:Number = 1, param7:Number = 1) : Shape
        {
            var _loc_8:* = new Shape();
            _loc_8.graphics.lineStyle(param7, param5, param6);
            _loc_8.graphics.moveTo(param1, param2);
            _loc_8.graphics.lineTo(param3, param4);
            return _loc_8;
        }// end function

    }
}
