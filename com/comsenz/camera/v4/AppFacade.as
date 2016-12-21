package com.comsenz.camera.v4
{
    import com.comsenz.camera.v4.controller.*;
    import org.puremvc.as3.patterns.facade.*;
	import org.puremvc.as3.interfaces.*;
	
    public class AppFacade extends Facade implements IFacade
    {
		static var instance:IFacade;

        public function AppFacade()
        {
            return;
        }// end function

        override protected function initializeController() : void
        {
            super.initializeController();
            registerCommand(NotiNames.APP_STARTUP, AppStartupCommand);
            return;
        }// end function

        public function startup(param1:CameraMain) : void
        {
            sendNotification(NotiNames.APP_STARTUP, param1);
            return;
        }// end function

        public static function getInstance() : AppFacade
        {
            if (instance == null)
            {
                instance = new AppFacade;
            }
            return instance as AppFacade;
        }// end function

    }
}
