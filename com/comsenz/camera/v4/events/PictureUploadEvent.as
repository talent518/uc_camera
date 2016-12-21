package com.comsenz.camera.v4.events
{
    import flash.events.*;

    public class PictureUploadEvent extends Event
    {
        private var _picType:uint;
        private var _data:Object;
        public static const ANIMATER_PICTURE:uint = 2;
        public static const UPLOAD_COMPLETE:String = "uploadCompleteEvent";
        public static const STATIC_PICTURE:uint = 1;

        public function PictureUploadEvent(param1:String, param2:uint, param3)
        {
            super(param1, false, false);
            this._picType = param2;
            this._data = param3;
            return;
        }// end function

        public function get data()
        {
            return this._data;
        }// end function

        public function get picType() : uint
        {
            return this._picType;
        }// end function

    }
}
