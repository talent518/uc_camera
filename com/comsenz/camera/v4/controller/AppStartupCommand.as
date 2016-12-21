package com.comsenz.camera.v4.controller
{
    import org.puremvc.as3.patterns.command.*;

    public class AppStartupCommand extends MacroCommand
    {

        public function AppStartupCommand()
        {
            return;
        }// end function

        override protected function initializeMacroCommand() : void
        {
            addSubCommand(AppInitDataCommand);
            addSubCommand(AppInitUICommand);
            return;
        }// end function

    }
}
