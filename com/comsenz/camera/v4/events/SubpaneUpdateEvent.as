package com.comsenz.camera.v4.events
{
    import flash.display.*;
    import flash.events.*;

    public class SubpaneUpdateEvent extends Event
    {
        public var bitmapdata:BitmapData;
        public static const UPDATE:String = "subpaneUpdate";

        public function SubpaneUpdateEvent(param1:String, param2:BitmapData)
        {
            super(param1, false, false);
            this.bitmapdata = param2;
            return;
        }// end function

        override public function toString() : String
        {
            return formatToString("SubpaneUpdateEvent", "type", "bubbles", "cancelable", "eventPhase");
        }// end function

        override public function clone() : Event
        {
            return new SubpaneUpdateEvent(type, this.bitmapdata.clone());
        }// end function

    }
}
