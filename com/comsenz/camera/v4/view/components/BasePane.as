package com.comsenz.camera.v4.view.components
{
    import com.comsenz.camera.v4.events.*;

    public class BasePane extends BaseTabbedPane
    {
        private static var _instance:BasePane = new BasePane;

        public function BasePane()
        {
            if (_instance)
            {
                throw new Error("BasePane can only be accessed through BasePane.getInstance()");
            }
            return;
        }// end function

        override public function setVisibleIndex(param1:uint) : void
        {
            super.setVisibleIndex(param1);
            this.dispatchEvent(new BasePaneChgEvent(BasePaneChgEvent.CHANGE, param1));
            return;
        }// end function

        public static function getInstance() : BasePane
        {
            return _instance;
        }// end function

    }
}
