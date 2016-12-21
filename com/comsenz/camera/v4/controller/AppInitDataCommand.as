package com.comsenz.camera.v4.controller
{
    import com.comsenz.camera.v4.controller.dataCommands.*;
    import com.comsenz.camera.v4.model.*;
    import org.puremvc.as3.patterns.command.*;

    public class AppInitDataCommand extends MacroCommand
    {

        public function AppInitDataCommand()
        {
            return;
        }// end function

        override protected function initializeMacroCommand() : void
        {
            addSubCommand(AppInitParamsCommand);
            addSubCommand(AppLoadXDPolicyCommand);
            addSubCommand(AppInitLocaleCommand);
            facade.registerCommand(LocaleProxy.FILL_DATA, AppFillLocaleDataCommand);
            return;
        }// end function

    }
}
