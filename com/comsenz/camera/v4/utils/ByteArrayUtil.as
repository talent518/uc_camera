package com.comsenz.camera.v4.utils
{
    import flash.utils.*;

    public class ByteArrayUtil extends Object
    {

        public function ByteArrayUtil()
        {
            return;
        }// end function

        private static function $toHexNum(param1:uint) : String
        {
            return (param1 <= 15 ? ("0" + param1.toString(16)) : (param1.toString(16))).toUpperCase();
        }// end function

        public static function slice(param1:ByteArray, param2:IDataOutput = null, param3:int = 0, param4:int = -1) : IDataOutput
        {
            if (!param1)
            {
                throw new ArgumentError("Param:<bytes> must not be null.");
            }
            var _loc_5:* = param1.length;
            if (!param2)
            {
                param2 = new ByteArray();
            }
            if (param3 < 0)
            {
                param3 = _loc_5 + param3;
            }
            if (param4 < 0)
            {
                param4 = _loc_5 + param4;
            }
            var _loc_6:* = param4 - param3 + 1;
            param2.writeBytes(param1, param3, _loc_6);
            return param2;
        }// end function

        public static function concat(param1:IDataOutput, ... args) : IDataOutput
        {
            var _loc_4:int = 0;
            while (_loc_4 < args.length)
            {
                
                param1.writeBytes(args[_loc_4]);
                _loc_4++;
            }
            return param1;
        }// end function

        public static function bytesToHexString(param1:ByteArray) : String
        {
            var _loc_3:String = null;
            var _loc_2:* = new StringBuilder();
            var _loc_4:int = 0;
            while (_loc_4 < param1.length)
            {
                
                _loc_3 = $toHexNum(param1[_loc_4]);
                if (_loc_3.length < 2)
                {
                    _loc_2.append("0");
                }
                _loc_2.append(_loc_3.toUpperCase());
                _loc_4++;
            }
            return _loc_2.toString();
        }// end function

        public static function equals(param1:ByteArray, param2:ByteArray) : Boolean
        {
            var _loc_6:int = 0;
            if (param1 === param2)
            {
                return true;
            }
            if (param1.length != param2.length)
            {
                return false;
            }
            var _loc_3:* = param1.position;
            var _loc_4:* = param2.position;
            var _loc_5:Boolean = true;
            var _loc_7:int = 0;
            param2.position = 0;
            param1.position = _loc_7;
            while (param1.bytesAvailable >= 4)
            {
                
                if (param1.readUnsignedInt() != param2.readUnsignedInt())
                {
                    _loc_5 = false;
                    break;
                }
            }
            if (_loc_5 && param1.bytesAvailable != 0)
            {
                _loc_6 = param1.bytesAvailable;
                _loc_5 = _loc_6 == 1 ? (param1.readByte() == param2.readByte()) : (_loc_6 == 2 ? (param1.readShort() == param2.readShort()) : (_loc_6 == 3 ? (param1.readShort() == param2.readShort() && param1.readByte() == param2.readByte()) : (true)));
            }
            param1.position = _loc_3;
            param2.position = _loc_4;
            return _loc_5;
        }// end function

    }
}
