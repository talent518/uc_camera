package com.comsenz.camera.v4.view
{
    import com.comsenz.camera.v4.view.components.*;
    import org.puremvc.as3.interfaces.*;
    import org.puremvc.as3.patterns.mediator.*;

    public class GifAssetMediator extends Mediator implements IMediator
    {
        public static const NAME:String = "GifAssetMediator";

        public function GifAssetMediator(param1:Object)
        {
            super(NAME, param1);
            return;
        }// end function

        public function get asset() : GifAsset
        {
            return viewComponent as GifAsset;
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

        override public function listNotificationInterests() : Array
        {
            return [];
        }// end function

    }
}
