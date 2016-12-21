package com.comsenz.camera.v4.utils
{
    import flash.media.*;
    import flash.system.*;

    public class CameraUtil extends Object
    {

        public function CameraUtil()
        {
            return;
        }// end function

        public static function getCamera() : Camera
        {
            var _loc_2:Camera = null;
            var _loc_3:String = null;
            var _loc_4:* = undefined;
            var _loc_1:* = Capabilities.manufacturer;
            if (_loc_1.indexOf("Macintosh") > -1)
            {
                _loc_3 = "";
                for (_loc_4 in Camera.names)
                {
                    
                    if (Camera.names[_loc_4] == "USB Video Class Video")
                    {
                        _loc_3 = _loc_4.toString();
                        break;
                    }
                }
                _loc_2 = Camera.getCamera(_loc_3);
            }
            else
            {
                _loc_2 = Camera.getCamera();
            }
            return _loc_2;
        }// end function

    }
}
