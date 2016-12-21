package com.comsenz.camera.v4.controller
{
    import com.comsenz.camera.v4.*;
    import com.comsenz.camera.v4.controller.logicCommands.*;
    import com.comsenz.camera.v4.controller.uiCommands.*;
    import com.comsenz.camera.v4.view.*;
    import org.puremvc.as3.interfaces.*;
    import org.puremvc.as3.patterns.command.*;

    public class AppInitUICommand extends SimpleCommand
    {

        public function AppInitUICommand()
        {
            return;
        }// end function

        override public function execute(param1:INotification) : void
        {
            var _loc_2:* = param1.getBody() as CameraMain;
            facade.registerMediator(new RootMediator(_loc_2));
            sendNotification(NotiNames.APP_UI_INIT);
            facade.registerCommand(NotiNames.APP_BASEPAN_INIT, InitBasePaneCommand);
            facade.registerCommand(NotiNames.APP_SUBMIT_DATA, SubmitCommand);
            return;
        }// end function

    }
}
