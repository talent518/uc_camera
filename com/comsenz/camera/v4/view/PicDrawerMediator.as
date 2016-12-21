package com.comsenz.camera.v4.view
{
    import com.comsenz.camera.v4.*;
    import com.comsenz.camera.v4.events.*;
    import com.comsenz.camera.v4.model.vo.*;
    import com.comsenz.camera.v4.view.components.*;
    import flash.events.*;
    import org.puremvc.as3.interfaces.*;
    import org.puremvc.as3.patterns.mediator.*;

    public class PicDrawerMediator extends Mediator implements IMediator
    {
        public static const NAME:String = "PicDrawerMediator";

        public function PicDrawerMediator(param1:Object)
        {
            super(NAME, param1);
            this.drawer.addEventListener(Event.INIT, this.onDrawerInit);
            this.drawer.addEventListener(GifFrameCountErrorEvent.GIF_FRAME_COUNT_ERROR, this.onGifFrameCountErr);
            this.drawer.addEventListener(SubpaneUpdateEvent.UPDATE, this.onSubUpdate);
            this.drawer.addEventListener(UsingAnimationEvent.IFUSE, this.onUseAnimationChg);
            this.drawer.addEventListener(Event.SELECT, this.onSelect);
            return;
        }// end function

        override public function listNotificationInterests() : Array
        {
            return [NotiNames.SLIDER_VALUE_CHANGE];
        }// end function

        public function get drawer() : PicDrawer
        {
            return viewComponent as PicDrawer;
        }// end function

        override public function handleNotification(param1:INotification) : void
        {
            switch(param1.getName())
            {
                case NotiNames.SLIDER_VALUE_CHANGE:
                {
                    this.drawer.snapshoot();
                    break;
                }
                default:
                {
                    break;
                    break;
                }
            }
            return;
        }// end function

        private function onUseAnimationChg(event:UsingAnimationEvent) : void
        {
            sendNotification(BasePaneMediator.ANIMATION_USE, event.usingAnimation);
            if (event.usingAnimation)
            {
                facade.removeMediator(GifAssetMediator.NAME);
                facade.registerMediator(new GifAssetMediator(this.drawer.asset as GifAsset));
            }
            return;
        }// end function

        private function onSubUpdate(event:SubpaneUpdateEvent) : void
        {
            sendNotification(BasePaneMediator.UPDATE_BITMAPDATA, event.bitmapdata);
            return;
        }// end function

        private function onSelect(event:Event) : void
        {
            sendNotification(NotiNames.SENT_NOTE_MSG, LocaleObject.getInstance().getKey("please_select_region"));
            return;
        }// end function

        private function onGifFrameCountErr(event:GifFrameCountErrorEvent) : void
        {
            sendNotification(NotiNames.GIF_FRAMES_OVERFLOW);
            return;
        }// end function

        private function onDrawerInit(event:Event) : void
        {
            sendNotification(NotiNames.INIT_SLIDER);
            this.drawer.snapshoot();
            return;
        }// end function

    }
}
