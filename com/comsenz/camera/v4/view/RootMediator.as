package com.comsenz.camera.v4.view
{
    import com.comsenz.camera.v4.*;
    import com.comsenz.camera.v4.model.*;
    import com.comsenz.camera.v4.utils.*;
    import com.comsenz.camera.v4.view.components.*;
    import flash.display.*;
    import flash.utils.*;
    import org.puremvc.as3.interfaces.*;
    import org.puremvc.as3.patterns.mediator.*;

    public class RootMediator extends Mediator
    {
        private var _loadingBar:LoadingBar;
        public static const NAME:String = "rootSpriteMediator";
        public static const ADD_BASEPANE:String = "rootAddBasepane";

        public function RootMediator(param1:CameraMain)
        {
            super(NAME, param1);
            this.root.stage.quality = StageQuality.BEST;
            return;
        }// end function

        override public function listNotificationInterests() : Array
        {
            return [NotiNames.APP_UI_INIT, NotiNames.APP_DATA_COMPLETE, LocaleProxy.COMPLETE, LocaleProxy.IO_ERROR, ADD_BASEPANE];
        }// end function

        public function get root() : CameraMain
        {
            return viewComponent as CameraMain;
        }// end function

        override public function handleNotification(param1:INotification) : void
        {
            var lProxy:LocaleProxy;
            var xml:XML;
            var keys:XMLList;
            var values:XMLList;
            var dic:Dictionary;
            var pane:BasePane;
            var i:uint;
            var vStr:String;
            var notification:* = param1;
            switch(notification.getName())
            {
                case NotiNames.APP_UI_INIT:
                {
                    this._loadingBar = new LoadingBar();
                    this.root.addChild(this._loadingBar);
                    this._loadingBar.beCenterTo(this.root.stage);
                    break;
                }
                case NotiNames.APP_DATA_COMPLETE:
                {
                    this._loadingBar.removeFrom(this.root);
                    sendNotification(NotiNames.APP_BASEPAN_INIT, this.root);
                    break;
                }
                case LocaleProxy.COMPLETE:
                {
                    lProxy = facade.retrieveProxy(LocaleProxy.NAME) as LocaleProxy;
                    try
                    {
                        var _loc_5:* = lProxy.locale.xml.language;
                        for each (var _loc_6:* in _loc_5)
                        {
                           if (_loc_6.@using == "true"){
                                xml = _loc_6;
								break;
                           }
                        }
                    }
                    catch (e:Error)
                    {
                        root.removeChild(_loadingBar);
                        _showErrMessage("Locale file data error.");
                        return;
                    }
                    keys = xml.item.@key;
                    values = xml.item.@value;
                    dic = new Dictionary();
                    i=0;
                    while (i < keys.length())
                    {
                        
                        if (values[i])
                        {
                            vStr = values[i].toString();
                        }
                        else
                        {
                            vStr = xml.item[i].value;
                        }
                        dic[keys[i].toString()] = StringUtil.unicodeToChinese(vStr);
                        i++;
                    }
                    sendNotification(LocaleProxy.FILL_DATA, dic);
                    break;
                }
                case LocaleProxy.IO_ERROR:
                {
                    this._loadingBar.removeFrom(this.root);
                    this._showErrMessage("Locale file load error.");
                    break;
                }
                case ADD_BASEPANE:
                {
                    pane = BasePane.getInstance();
                    facade.registerMediator(new BasePaneMediator(pane));
                    this.root.addChild(pane);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function _showErrMessage(param1:String) : void
        {
            var msg:* = param1;
            /*var eName:String;
            try
            {
                this.root.removeChild(this.root.getChildByName(eName));
            }
            catch (e:Error)
            {
            }*/
            var lb:* = new Label("<font color=\'#ff0000\'>" + msg + "</font>", 14);
            //lb.name = eName;
            lb.x = 0.5 * (this.root.stage.stageWidth - lb.width);
            lb.y = 0.5 * (this.root.stage.stageHeight - lb.height);
            this.root.addChild(lb);
            return;
        }// end function

    }
}
