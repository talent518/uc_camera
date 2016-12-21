package com.comsenz.camera.v4.events
{
    import flash.events.*;

    public class BasePaneChgEvent extends Event
    {
        private var _idx:uint;
        public static const CHANGE:String = "BasePaneChg";
        public static const CAM_STATE:uint = 2;
        public static const PRE_STATE:uint = 3;
        public static const PIC_STATE:uint = 1;

        public function BasePaneChgEvent(param1:String, param2:uint)
        {
            super(param1, false, false);
            this._idx = param2;
            return;
        }// end function

        public function get idx() : uint
        {
            return this._idx;
        }// end function

    }
}
