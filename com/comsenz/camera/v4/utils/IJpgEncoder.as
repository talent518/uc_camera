package com.comsenz.camera.v4.utils
{
    import flash.display.*;
    import flash.utils.*;

    public interface IJpgEncoder
    {

        public function IJpgEncoder();

        function encode(param1:BitmapData) : ByteArray;

    }
}
