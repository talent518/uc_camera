package com.comsenz.camera.v4.events
{
    import flash.events.*;

    public class GifFrameCountErrorEvent extends Event
    {
        public static const GIF_FRAME_COUNT_ERROR:String = "gifFrameCountError";

        public function GifFrameCountErrorEvent()
        {
            super(GIF_FRAME_COUNT_ERROR, false, false);
            return;
        }// end function

        override public function toString() : String
        {
            return formatToString("GifFrameCountErrorEvent", "type", "bubbles", "cancelable", "eventPhase");
        }// end function

        override public function clone() : Event
        {
            return new GifFrameCountErrorEvent();
        }// end function

    }
}
