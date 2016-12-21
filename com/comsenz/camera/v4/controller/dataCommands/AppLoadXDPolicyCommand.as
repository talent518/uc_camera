package com.comsenz.camera.v4.controller.dataCommands
{
    import com.comsenz.camera.v4.model.*;
    import flash.system.*;
    import org.puremvc.as3.interfaces.*;
    import org.puremvc.as3.patterns.command.*;

    public class AppLoadXDPolicyCommand extends SimpleCommand
    {

        public function AppLoadXDPolicyCommand()
        {
            return;
        }// end function

        override public function execute(param1:INotification) : void
        {
            var note:* = param1;
            var pProxy:* = facade.retrieveProxy(ParamsProxy.NAME) as ParamsProxy;
            Security.allowDomain("*");
            try
            {
                Security.loadPolicyFile(pProxy.getCrossDomainFile());
            }
            catch (e:SecurityError)
            {
            }
            return;
        }// end function

    }
}
