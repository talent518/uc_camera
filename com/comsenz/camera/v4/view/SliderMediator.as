package com.comsenz.camera.v4.view
{
    import com.comsenz.camera.v4.*;
    import com.comsenz.camera.v4.view.components.slider.*;
    import flash.events.*;
    import org.puremvc.as3.interfaces.*;
    import org.puremvc.as3.patterns.mediator.*;

    public class SliderMediator extends Mediator implements IMediator
    {
        public static const NAME:String = "SliderMediator";

        public function SliderMediator(param1:Object)
        {
            super(NAME, param1);
            this.slider.addEventListener(Event.CHANGE, this.onSliderChange);
            return;
        }// end function

        override public function listNotificationInterests() : Array
        {
            return [NotiNames.INIT_SLIDER];
        }// end function

        public function get slider() : Slider
        {
            return viewComponent as Slider;
        }// end function

        override public function handleNotification(param1:INotification) : void
        {
            switch(param1.getName())
            {
                case NotiNames.INIT_SLIDER:
                {
                    this.slider.value = 0.5;
                    this.slider.enabled = true;
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function onSliderChange(event:Event) : void
        {
            sendNotification(NotiNames.SLIDER_VALUE_CHANGE, (this.slider.value - 0.5) / 0.5);
            return;
        }// end function

    }
}
