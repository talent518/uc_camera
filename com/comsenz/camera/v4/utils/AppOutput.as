package com.comsenz.camera.v4.utils
{
    import flash.display.*;
    import flash.geom.*;

    public class AppOutput extends Object
    {

        public function AppOutput()
        {
            return;
        }// end function

        public static function getAppOutput(param1:BitmapData, param2:uint) : BitmapData
        {
            var _loc_3:BitmapData = null;
            var _loc_4:BitmapData = null;
            switch(param2)
            {
                case 1:
                {
                    return param1.width > Constants.OUT1_WIDTH || param1.height > Constants.OUT1_HEIGHT ? (PictureUtil.adaptBitmapData(param1, Constants.OUT1_WIDTH, Constants.OUT1_HEIGHT, true)) : (param1);
                }
                case 2:
                {
                    return param1.width > Constants.OUT2_WIDTH || param1.height > Constants.OUT2_HEIGHT ? (PictureUtil.adaptBitmapData(param1, Constants.OUT2_WIDTH, Constants.OUT2_HEIGHT, true)) : (param1);
                }
                case 3:
                {
                    _loc_3 = PictureUtil.adaptBitmapData(param1, Constants.OUT3_WIDTH, Constants.OUT3_HEIGHT, false);
                    _loc_4 = new BitmapData(Constants.OUT3_WIDTH, Constants.OUT3_HEIGHT);
                    _loc_4.copyPixels(_loc_3, new Rectangle(0.5 * (_loc_3.width - _loc_4.width), 0.5 * (_loc_3.height - _loc_4.height), _loc_4.width, _loc_4.height), new Point(), null, null, true);
                    return _loc_4;
                }
                default:
                {
                    return null;
                    break;
                }
            }
        }// end function

    }
}
