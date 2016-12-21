package com.comsenz.camera.v4.model
{
    import com.comsenz.camera.v4.model.vo.*;
    import com.comsenz.camera.v4.utils.*;
    import flash.display.*;
    import flash.events.*;
    //import flash.utils.*;
	import flash.utils.Dictionary;
    import org.puremvc.as3.patterns.proxy.*;
	import org.puremvc.as3.interfaces.*;

    public class LocaleProxy extends Proxy
    {
        private var _app:Sprite;
        private var _lObj:LocaleObject;
        public static const COMPLETE:String = "LocaleProxyComplete";
        public static const NAME:String = "LocaleProxy";
        public static const FILL_DATA:String = "LocaleProxyFillData";
        public static const IO_ERROR:String = "LocaleProxyIOError";

        public function LocaleProxy(param1:XMLReader, param2:Sprite)
        {
            super(NAME, param1);
            this._lObj = LocaleObject.getInstance();
            this._app = param2;
            return;
        }// end function

        private function onIOErr(event:IOErrorEvent) : void
        {
            sendNotification(LocaleProxy.IO_ERROR);
            return;
        }// end function

        public function get locale() : XMLReader
        {
            return data as XMLReader;
        }// end function

        public function load(param1:String, param2:String = "get", param3:String = "") : void
        {
            var _loc_4:XMLList = null;
            if (facade.hasProxy(PreLocaleProxy.NAME))
            {
                _loc_4 = facade.retrieveProxy(PreLocaleProxy.NAME).getData as XMLList;
                sendNotification(LocaleProxy.COMPLETE, _loc_4);
                return;
            }
            this.locale.read(param1, param2, param3);
            this.locale.addEventListener(Event.COMPLETE, this.onComplete);
            this.locale.addEventListener(IOErrorEvent.IO_ERROR, this.onIOErr);
            return;
        }// end function

        private function onComplete(event:Event) : void
        {
            sendNotification(LocaleProxy.COMPLETE, this.locale.xml);
            return;
        }// end function

        public function getKey(param1:String) : String
        {
            return this._lObj.getKey(param1);
        }// end function

        public function fillData(param1:Dictionary) : void
        {
            this._lObj.fillData(param1);
            return;
        }// end function

    }
}
