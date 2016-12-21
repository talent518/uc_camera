package com.comsenz.camera.v4.view.components
{
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.utils.*;

    public class JpgAsset extends AbstractAsset
    {
        private var _loader:Loader;

        public function JpgAsset()
        {
            this._loader = new Loader();
            this._loader.contentLoaderInfo.addEventListener(Event.COMPLETE, this.onLoaderComp);
            this._loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, this.onLoaderIOErr);
            this.addChild(this._loader);
            return;
        }// end function

        private function onLoaderComp(event:Event) : void
        {
            dispatchEvent(event);
            return;
        }// end function

        override public function snapshoot(param1:Rectangle, param2:Boolean, param3:Rectangle, param4:Boolean = false)
        {
            var _loc_5:* = this._toLocalRect(param1);
            var _loc_6:* = (this._loader.content as Bitmap).bitmapData;
            var _loc_7:* = new BitmapData(_loc_5.width, _loc_5.height, true, 0);
            _loc_7.copyPixels(_loc_6, _loc_5, new Point(0, 0));
            return _loc_7;
        }// end function

        override public function get width() : Number
        {
            return this._loader.contentLoaderInfo.width * this.scaleX;
        }// end function

        override public function get height() : Number
        {
            return this._loader.contentLoaderInfo.height * this.scaleY;
        }// end function

        override public function beCenterTo(param1:Rectangle) : void
        {
            this._beCenterTo(param1);
            return;
        }// end function

        override public function importAsset(param1:ByteArray) : void
        {
            this._loader.unload();
            this._loader.loadBytes(param1 as ByteArray);
            return;
        }// end function

        private function onLoaderIOErr(event:IOErrorEvent) : void
        {
            this.dispatchEvent(event);
            return;
        }// end function

    }
}
