package com.comsenz.camera.v4.view.components
{
    import com.comsenz.camera.v4.events.*;
    import com.comsenz.camera.v4.model.vo.*;
    import com.comsenz.camera.v4.utils.*;
    import flash.display.*;
    import flash.events.*;
    import flash.net.*;
    import flash.utils.*;

    public class PreUploader extends Sprite
    {
        private var pcMC:Class;
        private var _pc:DisplayObject;
        private var _path:String = "";
        private var _type:uint;
        private var _reader:URLReader;
        private var _fr:FileReference;
        private var _typeFilter:FileFilter;

        public function PreUploader()
        {
            this.pcMC = PreUploader_pcMC;
            this._pc = new this.pcMC();
            this.addChild(this._pc);
            this.visible = false;
            return;
        }// end function

        private function onReaderComp(event:Event) : void
        {
            this.dispatchEvent(new PictureUploadEvent(PictureUploadEvent.UPLOAD_COMPLETE, this._type, this._reader.loader.data as ByteArray));
            this.dispatchEvent(new Event(Event.CLOSE));
            this.visible = false;
            return;
        }// end function

        private function onFRCancel(event:Event) : void
        {
            this._sendMsg(this._key("browse_file_cancel"));
            return;
        }// end function

        private function onFRSelect(event:Event) : void
        {
            var _loc_2:String = null;
            var _loc_3:String = null;
            if (/\.((j|J)(p|P)(g|G)|(g|G)(i|I)(f|F)|(p|P)(n|N)(g|G))$/.test(this._fr.name))
            {
                _loc_2 = Params.getInstance().getParam("uploadSize");
                if (this._fr.size > (_loc_2 ? (Number(_loc_2)) : (1024)) * 1024)
                {
                    this._sendErr(this._key("upload_volume_1M"));
                }
                else
                {
                    _loc_3 = Params.getInstance().getActionParams(Params.UPLOAD);
                    this._fr.upload(new URLRequest(_loc_3), "Filedata");
                    this.dispatchEvent(event);
                }
            }
            else
            {
                this._sendErr(this._key("upload_type_error"));
            }
            return;
        }// end function

        public function browse() : void
        {
            this._typeFilter = new FileFilter(this._key("upload_type_label"), "*.jpg;*.png;*.gif");
            this._fr = new FileReference();
            this._fr.addEventListener(Event.SELECT, this.onFRSelect);
            this._fr.addEventListener(Event.COMPLETE, this.onFRComplete);
            this._fr.addEventListener(DataEvent.UPLOAD_COMPLETE_DATA, this.onFRUploadComplete);
            this._fr.addEventListener(Event.CANCEL, this.onFRCancel);
            this._fr.addEventListener(Event.OPEN, this.onFROpen);
            this._fr.addEventListener(ProgressEvent.PROGRESS, this.onFRProgress);
            this._fr.addEventListener(IOErrorEvent.IO_ERROR, this.onFRIOError);
            this._fr.addEventListener(HTTPStatusEvent.HTTP_STATUS, this.onFRHTTPError);
            this._fr.addEventListener(SecurityErrorEvent.SECURITY_ERROR, this.onFRSecurityError);
            this._fr.browse([this._typeFilter]);
            return;
        }// end function

        private function onFRComplete(event:Event) : void
        {
            this.dispatchEvent(new Event(Event.CLOSE));
            return;
        }// end function

        private function onFRHTTPError(event:HTTPStatusEvent) : void
        {
            this._sendErr(this._key("upload_httperror"));
            return;
        }// end function

        private function _sendMsg(param1:String) : void
        {
            dispatchEvent(new PreLoaderMessageEvent(PreLoaderMessageEvent.MSG, param1));
            this.visible = false;
            return;
        }// end function

        private function onFROpen(event:Event) : void
        {
            this.dispatchEvent(new Event(Event.INIT));
            this._pc["p"].text = 0;
            this._sendSeq(this._key("upload_uploading"));
            return;
        }// end function

        private function onReaderIOErr(event:IOErrorEvent = null) : void
        {
            this._sendErr(this._key("callback_uploaded_ioerror"));
            return;
        }// end function

        private function onFRUploadComplete(event:DataEvent) : void
        {
            switch(event.data)
            {
                case "":
                {
                    this.onFRIOError(null);
                    return;
                }
                case "-1":
                {
                    this._sendErr("Invalid identity!");
                    return;
                }
                case "-2":
                {
                    this._sendErr("Invalid photograph!");
                    return;
                }
                case "-3":
                {
                    this._sendErr("No photograph be upload!");
                    return;
                }
                case "-4":
                {
                    this._sendErr("Can not write to the data/tmp folder!");
                    return;
                }
                case "-5":
                {
                    this._sendErr("Server can not upload!");
                    return;
                }
                default:
                {
                    if (!new RegExp("^https?://", "i").test(event.data as String))
                    {
                        this._sendErr(event.data);
                        return;
                    }
                    break;
                }
            }
            this._path = event.data;
            this._reader = new URLReader();
            this._reader.dataFormat = URLLoaderDataFormat.BINARY;
            if (/\.((g|G)(i|I)(f|F))$/.test(this._path))
            {
                this._type = PictureUploadEvent.ANIMATER_PICTURE;
            }
            else if (/\.(jpg|png)$/.test(this._path.toLowerCase()))
            {
                this._type = PictureUploadEvent.STATIC_PICTURE;
            }
            else
            {
                this._sendErr("Server error: Invalid photograph path!");
                return;
            }
            this._reader.addEventListener(Event.COMPLETE, this.onReaderComp);
            this._reader.addEventListener(Event.OPEN, this.onReaderOpen);
            this._reader.addEventListener(ProgressEvent.PROGRESS, this.onReaderProg);
            this._reader.addEventListener(IOErrorEvent.IO_ERROR, this.onReaderIOErr);
            this._reader.read(this._path);
            return;
        }// end function

        private function _key(param1:String) : String
        {
            return LocaleObject.getInstance().getKey(param1);
        }// end function

        private function onReaderOpen(event:Event) : void
        {
            this.dispatchEvent(new Event(Event.INIT));
            this._pc["p"].text = 0;
            this._sendSeq(this._key("upload_downing"));
            return;
        }// end function

        private function onFRIOError(event:IOErrorEvent) : void
        {
            this._sendErr(this._key("upload_ioerror"));
            return;
        }// end function

        private function onFRProgress(event:ProgressEvent) : void
        {
            var _loc_2:* = Math.floor(event.bytesLoaded / event.bytesTotal * 100) + "";
            this._pc["p"].text = _loc_2;
            this.visible = true;
            return;
        }// end function

        private function onReaderProg(event:ProgressEvent) : void
        {
            var _loc_2:* = Math.floor(event.bytesLoaded / event.bytesTotal * 100) + "";
            this._pc["p"].text = _loc_2;
            return;
        }// end function

        private function onFRSecurityError(event:SecurityErrorEvent) : void
        {
            this._sendErr(this._key("upload_securityerror"));
            return;
        }// end function

        private function _sendErr(param1:String) : void
        {
            dispatchEvent(new PreLoaderMessageEvent(PreLoaderMessageEvent.ERR, param1));
            return;
        }// end function

        private function _sendSeq(param1:String) : void
        {
            dispatchEvent(new PreLoaderMessageEvent(PreLoaderMessageEvent.SEQUENCE, param1));
            return;
        }// end function

    }
}
