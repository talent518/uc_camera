package com.comsenz.camera.v4.view
{
    import com.comsenz.camera.v4.events.*;
    import com.comsenz.camera.v4.view.components.*;
    import org.puremvc.as3.interfaces.*;
    import org.puremvc.as3.patterns.mediator.*;

    public class CamDrawerMediator extends Mediator implements IMediator
    {
        public static const NAME:String = "CamDrawerMediator";

        public function CamDrawerMediator(param1:Object)
        {
            super(NAME, param1);
            this.drawer.addEventListener(SubpaneUpdateEvent.UPDATE, this.onSubUpdate);
            return;
        }// end function

        override public function listNotificationInterests() : Array
        {
            return [];
        }// end function

        public function get drawer() : CamDrawer
        {
            return viewComponent as CamDrawer;
        }// end function

        override public function handleNotification(param1:INotification) : void
        {
            switch(param1.getName())
            {
                default:
                {
                    break;
                    break;
                }
            }
            return;
        }// end function

        private function onSubUpdate(event:SubpaneUpdateEvent) : void
        {
            sendNotification(BasePaneMediator.UPDATE_BITMAPDATA, event.bitmapdata);
            return;
        }// end function

    }
}
