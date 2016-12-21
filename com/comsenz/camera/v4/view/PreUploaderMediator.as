package com.comsenz.camera.v4.view
{
    import com.comsenz.camera.v4.*;
    import com.comsenz.camera.v4.events.*;
    import com.comsenz.camera.v4.view.components.*;
    import flash.events.*;
    import org.puremvc.as3.interfaces.*;
    import org.puremvc.as3.patterns.mediator.*;

    public class PreUploaderMediator extends Mediator implements IMediator
    {
        public static const NAME:String = "PreUploaderMediator";

        public function PreUploaderMediator(param1:Object)
        {
            super(NAME, param1);
            this.preUploader.addEventListener(Event.SELECT, this.onSelect);
            this.preUploader.addEventListener(PreLoaderMessageEvent.MSG, this.onMsg);
            this.preUploader.addEventListener(PreLoaderMessageEvent.ERR, this.onErr);
            this.preUploader.addEventListener(PreLoaderMessageEvent.SEQUENCE, this.onSeq);
            this.preUploader.addEventListener(Event.INIT, this.onSeqStart);
            this.preUploader.addEventListener(Event.CLOSE, this.onSeqEnd);
            this.preUploader.addEventListener(PictureUploadEvent.UPLOAD_COMPLETE, this.onUploadComp);
            return;
        }// end function

        override public function listNotificationInterests() : Array
        {
            return [];
        }// end function

        private function onSeqStart(event:Event) : void
        {
            sendNotification(NotiNames.START_MSG_SUQUENCE);
            return;
        }// end function

        private function onErr(event:PreLoaderMessageEvent) : void
        {
            sendNotification(NotiNames.SENT_ERROR_MSG, event.msg);
            sendNotification(NotiNames.ERR_WHEN_PRELOADER);
            return;
        }// end function

        private function onMsg(event:PreLoaderMessageEvent) : void
        {
            sendNotification(NotiNames.SENT_NOTE_MSG, event.msg);
            return;
        }// end function

        private function onSeqEnd(event:Event) : void
        {
            sendNotification(NotiNames.END_MSG_SUQUENCE);
            return;
        }// end function

        private function onSeq(event:PreLoaderMessageEvent) : void
        {
            sendNotification(NotiNames.APPEND_MSG_SUQUENCE, event.msg);
            return;
        }// end function

        public function get preUploader() : PreUploader
        {
            return viewComponent as PreUploader;
        }// end function

        private function onUploadComp(event:PictureUploadEvent) : void
        {
            sendNotification(NotiNames.PREUPLOAD_COMPLETE, [event.picType, event.data]);
            return;
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

        private function onSelect(event:Event) : void
        {
            sendNotification(NotiNames.SELECT_WHEN_PRELOADER);
            return;
        }// end function

    }
}
