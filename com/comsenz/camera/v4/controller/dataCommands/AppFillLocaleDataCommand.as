package com.comsenz.camera.v4.controller.dataCommands
{
    import com.comsenz.camera.v4.*;
    import com.comsenz.camera.v4.model.*;
    import flash.utils.*;
    import org.puremvc.as3.interfaces.*;
    import org.puremvc.as3.patterns.command.*;

    public class AppFillLocaleDataCommand extends SimpleCommand
    {

        public function AppFillLocaleDataCommand()
        {
            return;
        }// end function

        override public function execute(param1:INotification) : void
        {
            var _loc_2:* = param1.getBody() as Dictionary;
            var _loc_3:* = facade.retrieveProxy(LocaleProxy.NAME) as LocaleProxy;
            _loc_3.fillData(_loc_2);
            sendNotification(NotiNames.APP_DATA_COMPLETE);
            return;
        }// end function

    }
}
