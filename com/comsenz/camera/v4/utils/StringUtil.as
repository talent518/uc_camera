package com.comsenz.camera.v4.utils
{

    public class StringUtil extends Object
    {

        public function StringUtil()
        {
            return;
        }// end function

        public static function trim(param1:String) : String
        {
            return rtrim(ltrim(param1));
        }// end function

        public static function rtrim(param1:String) : String
        {
            var _loc_2:* = /\s*$/;
            return param1.replace(_loc_2, "");
        }// end function

        public static function unicodeToChinese(param1:String) : String
        {
            return unescape(param1.replace(/\\/g, "%"));
        }// end function

        public static function isWhitespace(param1:String) : Boolean
        {
            return trim(param1).length == 0;
        }// end function

        public static function getRandomString(param1:int) : String
        {
            var _loc_2:Array = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0", "q", "w", "e", "r", "t", "y", "u", "i", "o", "p", "a", "s", "d", "f", "g", "h", "j", "k", "l", "z", "x", "c", "v", "b", "n", "m"];
            var _loc_3:* = new StringBuilder();
            var _loc_4:int = 0;
            while (_loc_4 < param1)
            {
                
                _loc_3.append(_loc_2[Math.abs(Math.random() * _loc_2.length) % _loc_2.length]);
                _loc_4++;
            }
            return _loc_3.toString();
        }// end function

        public static function ltrim(param1:String) : String
        {
            var _loc_2:* = /^\s*/;
            return param1.replace(_loc_2, "");
        }// end function

    }
}
