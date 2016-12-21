package com.comsenz.camera.v4.controller.dataCommands
{
    import com.comsenz.camera.v4.model.*;
    import com.comsenz.camera.v4.utils.*;
    import flash.display.*;
    import org.puremvc.as3.interfaces.*;
    import org.puremvc.as3.patterns.command.*;

    public class AppInitLocaleCommand extends SimpleCommand
    {

        public function AppInitLocaleCommand()
        {
            return;
        }// end function

        override public function execute(param1:INotification) : void
        {
            var _loc_2:* = new XMLReader();
            var _loc_3:* = facade.retrieveProxy(ParamsProxy.NAME) as ParamsProxy;
            var _loc_4:* = new LocaleProxy(_loc_2, param1.getBody() as Sprite);
            facade.registerProxy(_loc_4);
            _loc_4.load(_loc_3.getLocaleFile());
            return;
        }// end function

    }
}
