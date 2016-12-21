package com.comsenz.camera.v4.view.components
{
	import flash.utils.*;

    public interface IDrawer
    {

        public function IDrawer();

        function snapshoot() : void;

        function importData(type:uint,data:ByteArray) : void;

    }
}
