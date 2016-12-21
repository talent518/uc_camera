package com.comsenz.camera.v4.view.components
{
    import flash.geom.*;
    import flash.utils.*;

    public interface IAsset
    {

        public function IAsset();

        function importAsset(param1:ByteArray) : void;

        function snapshoot(param1:Rectangle, param2:Boolean, param3:Rectangle, param4:Boolean = false);

    }
}
