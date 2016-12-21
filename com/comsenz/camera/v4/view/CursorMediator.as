package com.comsenz.camera.v4.view
{
    import com.comsenz.camera.v4.*;
    import com.comsenz.camera.v4.view.components.*;
    import org.puremvc.as3.interfaces.*;
    import org.puremvc.as3.patterns.mediator.*;

    public class CursorMediator extends Mediator implements IMediator
    {
        public static const NAME:String = "CursorMediator";

        public function CursorMediator(param1:Object)
        {
            super(NAME, param1);
            return;
        }// end function

        override public function listNotificationInterests() : Array
        {
            return [NotiNames.SHOW_CURSOR];
        }// end function

        override public function handleNotification(param1:INotification) : void
        {
            var _loc_2:String = null;
            switch(param1.getName())
            {
                case NotiNames.SHOW_CURSOR:
                {
                    _loc_2 = param1.getBody() as String;
                    this.cursor.show(_loc_2);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        public function get cursor() : Cursor
        {
            return viewComponent as Cursor;
        }// end function

    }
}
