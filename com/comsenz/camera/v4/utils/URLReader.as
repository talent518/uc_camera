package com.comsenz.camera.v4.utils
{
    import flash.events.*;
    import flash.net.*;

    public class URLReader extends EventDispatcher
    {
        private var _data:Object;
        private var _progress:Number;
        private var _loader:URLLoader;

        public function URLReader()
        {
            this._loader = new URLLoader();
            return;
        }// end function

        private function onIOErr(event:IOErrorEvent) : void
        {
            this._loader.removeEventListener(IOErrorEvent.IO_ERROR, this.onIOErr);
            this.dispatchEvent(event);
            return;
        }// end function

        public function set dataFormat(param1:String) : void
        {
            this._loader.dataFormat = param1;
            return;
        }// end function

        public function get data()
        {
            return this._data;
        }// end function

        public function get progress() : Number
        {
            return this._progress;
        }// end function

        private function onOpen(event:Event) : void
        {
            this.dispatchEvent(event);
            return;
        }// end function

        public function read(param1:String, param2:String = "get", param3:String = "") : void
        {
            var _loc_6:Array = null;
            var _loc_7:String = null;
            var _loc_8:Array = null;
            var _loc_9:String = null;
            var _loc_10:String = null;
            var _loc_4:* = new URLVariables();
            if (param3 != "" && param3.indexOf("=") > -1)
            {
                _loc_6 = param3.split("&");
                for each (_loc_7 in _loc_6)
                {
                    
                    _loc_8 = _loc_7.split("=");
                    _loc_9 = _loc_8[0];
                    _loc_10 = _loc_8[1];
                    _loc_4[_loc_9] = _loc_10;
                }
            }
            _loc_4.urlReaderTS = new Date().getTime();
            var _loc_5:* = new URLRequest(param1);
            _loc_5.method = param2;
            _loc_5.data = _loc_4;
            this._loader.load(_loc_5);
            this._loader.addEventListener(Event.COMPLETE, this.onComplete);
            this._loader.addEventListener(IOErrorEvent.IO_ERROR, this.onIOErr);
            this._loader.addEventListener(Event.OPEN, this.onOpen);
            this._loader.addEventListener(ProgressEvent.PROGRESS, this.onProgress);
            return;
        }// end function

        public function get loader() : URLLoader
        {
            return this._loader;
        }// end function

        private function onProgress(event:ProgressEvent) : void
        {
            this._progress = this._loader.bytesLoaded / this._loader.bytesTotal;
            this.dispatchEvent(event);
            return;
        }// end function

        private function onComplete(event:Event) : void
        {
            this._loader.removeEventListener(Event.COMPLETE, this.onComplete);
            this._data = this._loader.data;
            this.dispatchEvent(event);
            return;
        }// end function

    }
}
