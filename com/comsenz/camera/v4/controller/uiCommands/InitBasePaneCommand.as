package com.comsenz.camera.v4.controller.uiCommands
{
    import com.comsenz.camera.v4.view.*;
    import org.puremvc.as3.interfaces.*;
    import org.puremvc.as3.patterns.command.*;

    public class InitBasePaneCommand extends SimpleCommand
    {

        public function InitBasePaneCommand()
        {
            return;
        }// end function

        override public function execute(param1:INotification) : void
        {
            sendNotification(RootMediator.ADD_BASEPANE);
            return;
        }// end function

    }
}
