package com.comsenz.camera.v4.controller.dataCommands
{
    import com.comsenz.camera.v4.model.*;
    import com.comsenz.camera.v4.model.vo.*;
    import org.puremvc.as3.interfaces.*;
    import org.puremvc.as3.patterns.command.*;

    public class AppInitParamsCommand extends SimpleCommand
    {

        public function AppInitParamsCommand()
        {
            return;
        }// end function

        override public function execute(param1:INotification) : void
        {
            var _loc_2:* = param1.getBody() as CameraMain;
            var _loc_3:* = new ParamsProxy(Params.getInstance());
            facade.registerProxy(_loc_3);
            _loc_3.init(_loc_2);
            return;
        }// end function

    }
}
