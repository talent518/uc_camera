package com.comsenz.camera.v4.events
{
    import flash.events.*;

    public class UsingAnimationEvent extends Event
    {
        public var usingAnimation:Boolean;
        public static const IFUSE:String = "ifUsingAnimationNow";

        public function UsingAnimationEvent(param1:String, param2:Boolean = true)
        {
            super(param1, false, false);
            this.usingAnimation = param2;
            return;
        }// end function

        override public function toString() : String
        {
            return formatToString("UsingAnimationEvent", "type", "bubbles", "cancelable", "eventPhase");
        }// end function

        override public function clone() : Event
        {
            return new UsingAnimationEvent(type, this.usingAnimation);
        }// end function

    }
}
