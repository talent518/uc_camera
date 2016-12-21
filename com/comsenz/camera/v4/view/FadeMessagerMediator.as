package com.comsenz.camera.v4.view
{
    import com.comsenz.camera.v4.*;
    import com.comsenz.camera.v4.view.components.*;
    import flash.filters.*;
    import org.puremvc.as3.interfaces.*;
    import org.puremvc.as3.patterns.mediator.*;

    public class FadeMessagerMediator extends Mediator implements IMediator
    {
        public static const NAME:String = "FadeMessagerMediator";

        public function FadeMessagerMediator(param1:Object)
        {
            super(NAME, param1);
            return;
        }// end function

        override public function listNotificationInterests() : Array
        {
            return [NotiNames.SENT_NOTE_MSG, NotiNames.SENT_ERROR_MSG, NotiNames.START_MSG_SUQUENCE, NotiNames.APPEND_MSG_SUQUENCE, NotiNames.END_MSG_SUQUENCE];
        }// end function

        override public function handleNotification(param1:INotification) : void
        {
            switch(param1.getName())
            {
                case NotiNames.SENT_NOTE_MSG:
                {
                    this.messager.setText(param1.getBody() as String, 0, 12, this._textFilter());
                    this.messager.setBackground(16711614, 0.85);
                    this.messager.y = 0;
                    this.messager.play();
                    break;
                }
                case NotiNames.SENT_ERROR_MSG:
                {
                    this.messager.setText(param1.getBody() as String, 16777215);
                    this.messager.setBackground(8388608, 0.86);
                    this.messager.y = 0;
                    this.messager.play();
                    break;
                }
                case NotiNames.START_MSG_SUQUENCE:
                {
                    this.messager.setText("");
                    this.messager.setBackground(16777062, 0.4);
                    this.messager.y = 0;
                    this.messager.fadeIn();
                    break;
                }
                case NotiNames.APPEND_MSG_SUQUENCE:
                {
                    this.messager.setText(param1.getBody() as String, 0, 12, this._textFilter());
                    break;
                }
                case NotiNames.END_MSG_SUQUENCE:
                {
                    this.messager.fadeOut();
                    break;
                }
                default:
                {
                    break;
                    break;
                }
            }
            return;
        }// end function

        private function _textFilter() : GlowFilter
        {
            return new GlowFilter(16777215, 1, 3, 3, 3, 5);
        }// end function

        public function get messager() : FadeMessager
        {
            return viewComponent as FadeMessager;
        }// end function

    }
}
