package com.comsenz.camera.v4.events
{
    import flash.events.*;

    public class PreLoaderMessageEvent extends Event
    {
        public var msg:String;
        public static const SEQUENCE:String = "preLoaderMsgSeq";
        public static const ERR:String = "preLoaderError";
        public static const MSG:String = "preLoaderMessage";

        public function PreLoaderMessageEvent(param1:String, param2:String)
        {
            super(param1, false, false);
            this.msg = param2;
            return;
        }// end function

        override public function toString() : String
        {
            return formatToString("PreLoaderMessageEvent", "type", "bubbles", "cancelable", "eventPhase");
        }// end function

        override public function clone() : Event
        {
            return new PreLoaderMessageEvent(type, this.msg);
        }// end function

    }
}
