package com.comsenz.camera.v4.controller.logicCommands
{
    import com.comsenz.camera.v4.*;
    import com.comsenz.camera.v4.model.*;
    import com.comsenz.camera.v4.model.vo.*;
    import com.comsenz.camera.v4.utils.*;
    import com.comsenz.camera.v4.view.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.net.*;
    import flash.utils.*;
    import org.gif.encoder.*;
    import org.puremvc.as3.interfaces.*;
    import org.puremvc.as3.patterns.command.*;

    public class SubmitCommand extends SimpleCommand
    {
        private var _encoder2:GIFEncoder;
        private var _hex1:String;
        private var _hex2:String;
        private var _hex3:String;
        private var _appBD:BitmapData;
        private var _bd1:BitmapData;
        private var _bd2:BitmapData;
        private var _bd3:BitmapData;
        private var _encoder1:GIFEncoder;
        private var _encoder3:GIFEncoder;
        private var _basePaneMed:BasePaneMediator;

        public function SubmitCommand()
        {
            return;
        }// end function

        private function _onSubmitGifHelper() : void
        {
            var _loc_1:* = facade.retrieveMediator(PicDrawerMediator.NAME) as PicDrawerMediator;
            var _loc_2:* = _loc_1.drawer.currRect;
            var _loc_3:* = facade.retrieveMediator(GifAssetMediator.NAME) as GifAssetMediator;
            var _loc_4:* = this._appBD.width < Constants.OUT1_WIDTH ? (this._appBD.rect) : (new Rectangle(0, 0, Constants.OUT1_WIDTH, Constants.OUT1_HEIGHT));
            var _loc_5:* = this._appBD.width < Constants.OUT2_WIDTH ? (this._appBD.rect) : (new Rectangle(0, 0, Constants.OUT2_WIDTH, Constants.OUT2_HEIGHT));
            this._hex1 = this._bytesToHexString(_loc_3.asset.snapshoot(_loc_2, false, _loc_4) as ByteArray);
            this._hex2 = this._bytesToHexString(_loc_3.asset.snapshoot(_loc_2, false, _loc_5) as ByteArray);
            this._hex3 = this._bytesToHexString(_loc_3.asset.snapshoot(_loc_2, false, new Rectangle(0, 0, Constants.OUT3_WIDTH, Constants.OUT3_HEIGHT), true) as ByteArray);
            this._post();
            return;
        }// end function

        private function _bytesToHexString(param1:ByteArray) : String
        {
            return ByteArrayUtil.bytesToHexString(param1);
        }// end function

        private function onComplete(event:Event) : void
        {
            var ret:String;
            var e:* = event;
            e.target.removeEventListener(Event.COMPLETE, this.onComplete);
            ret = String(XML(URLReader(e.target).data).face.@success);
            setTimeout(function () : void
            {
                _handleReturn.apply(null, [ret]);
                return;
            }// end function
            , 3200);
            return;
        }// end function

        private function onOpen(event:Event) : void
        {
            sendNotification(NotiNames.START_MSG_SUQUENCE);
            return;
        }// end function

        private function onProgress(event:ProgressEvent) : void
        {
            sendNotification(NotiNames.APPEND_MSG_SUQUENCE, LocaleObject.getInstance().getKey("face_saving"));
            return;
        }// end function

        private function _handleReturn(param1:String) : void
        {
            switch(param1)
            {
                case "1":
                {
                    sendNotification(NotiNames.SENT_NOTE_MSG, LocaleObject.getInstance().getKey("face_save_success"));
                    sendNotification(BasePaneMediator.MODE_CHANGE, BasePaneMediator.MODE_IDX_FINISH);
                    break;
                }
                case "2":
                case "0":
                {
                    sendNotification(NotiNames.SENT_ERROR_MSG, "" + LocaleObject.getInstance().getKey("face_save_error") + ", error code:" + param1);
                    sendNotification(BasePaneMediator.MODE_CHANGE, BasePaneMediator.MODE_IDX_UPLOAD);
                    break;
                }
                default:
                {
                    sendNotification(NotiNames.SENT_ERROR_MSG, "unexpected error");
                    sendNotification(BasePaneMediator.MODE_CHANGE, BasePaneMediator.MODE_IDX_UPLOAD);
                    break;
                    break;
                }
            }
            return;
        }// end function

        private function onIOErr(event:IOErrorEvent) : void
        {
            sendNotification(NotiNames.SENT_ERROR_MSG, LocaleObject.getInstance().getKey("face_save_ioerror"));
            return;
        }// end function

        private function _submit() : void
        {
            var _loc_2:JPGEncoder = null;
            var _loc_1:* = this._basePaneMed.isUsingAnimation;
            sendNotification(NotiNames.APPEND_MSG_SUQUENCE, "");
            sendNotification(NotiNames.START_MSG_SUQUENCE);
            if (!_loc_1)
            {
                _loc_2 = new JPGEncoder(85);
                this._hex1 = this._bytesToHexString(_loc_2.encode(this._bd1));
                this._hex2 = this._bytesToHexString(_loc_2.encode(this._bd2));
                this._hex3 = this._bytesToHexString(_loc_2.encode(this._bd3));
                sendNotification(NotiNames.APPEND_MSG_SUQUENCE, LocaleObject.getInstance().getKey("upload_uploading"));
                setTimeout(this._post, 1200);
            }
            else
            {
                sendNotification(NotiNames.APPEND_MSG_SUQUENCE, LocaleObject.getInstance().getKey("gif_submitting"));
                setTimeout(this._onSubmitGifHelper, 1200);
            }
            return;
        }// end function

        private function _getQuery(param1:String, param2:String, param3:String) : String
        {
            return "avatar1=" + param1 + "&avatar2=" + param2 + "&avatar3=" + param3;
        }// end function

        override public function execute(param1:INotification) : void
        {
            this._init();
            return;
        }// end function

        private function _init() : void
        {
            this._basePaneMed = facade.retrieveMediator(BasePaneMediator.NAME) as BasePaneMediator;
            this._appBD = this._basePaneMed.currBitmapdata;
            this._bd1 = AppOutput.getAppOutput(this._appBD, 1);
            this._bd2 = AppOutput.getAppOutput(this._appBD, 2);
            this._bd3 = AppOutput.getAppOutput(this._appBD, 3);
            this._submit();
            return;
        }// end function

        private function _post() : void
        {
            var _loc_1:* = facade.retrieveProxy(ParamsProxy.NAME) as ParamsProxy;
            var _loc_2:* = new URLReader();
            _loc_2.addEventListener(Event.OPEN, this.onOpen);
            _loc_2.addEventListener(Event.COMPLETE, this.onComplete);
            _loc_2.addEventListener(IOErrorEvent.IO_ERROR, this.onIOErr);
            _loc_2.addEventListener(ProgressEvent.PROGRESS, this.onProgress);
            _loc_2.read(_loc_1.getActionParams(Params.SAVE), URLRequestMethod.POST, this._getQuery(this._hex1, this._hex2, this._hex3));
            return;
        }// end function

    }
}
