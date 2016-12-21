package com.comsenz.camera.v4.view
{
    import com.comsenz.camera.v4.*;
    import com.comsenz.camera.v4.utils.*;
    import com.comsenz.camera.v4.view.components.*;
    import com.comsenz.camera.v4.view.components.buttons.*;
    import flash.events.*;
    import org.puremvc.as3.interfaces.*;
    import org.puremvc.as3.patterns.mediator.*;

    public class ModeCamPaneMediator extends Mediator implements IMediator
    {
        private var _root:CameraMain;
        private var _submitMask:SubmitMask;
        private var _submitBtn:SubmitButton;
        private var _returnBtn:ReturnButton;
        private var _drawer:CamDrawer;
        public static const NAME:String = "ModeCamPaneMediator";

        public function ModeCamPaneMediator(param1:Object)
        {
            super(NAME, param1);
            this._drawer = new CamDrawer(this.pane, this._root, Constants.CAM_WIDTH, Constants.CAM_HEIGHT);
            this._drawer.x = 12;
            this._drawer.y = 14;
            facade.registerMediator(new CamDrawerMediator(this._drawer));
            this.pane.addChild(this._drawer);
            this._returnBtn = new ReturnButton(1);
            this._returnBtn.x = 332;
            this._returnBtn.y = 14;
            this._returnBtn.addEventListener(MouseEvent.CLICK, this.onReturn);
            this.pane.addChild(this._returnBtn);
            this._submitBtn = new SubmitButton();
            this._submitBtn.x = 332;
            this._submitBtn.y = 199;
            this.pane.addChild(this._submitBtn);
            this._submitMask = new SubmitMask();
            this._submitMask.visible = false;
            this._submitMask.buttonMode = true;
            this.pane.addChild(this._submitMask);
            return;
        }// end function

        override public function listNotificationInterests() : Array
        {
            return [BasePaneMediator.MODE_CHANGE];
        }// end function

        public function get pane() : ModeCamPane
        {
            return viewComponent as ModeCamPane;
        }// end function

        override public function handleNotification(param1:INotification) : void
        {
            switch(param1.getName())
            {
                case BasePaneMediator.MODE_CHANGE:
                {
                    if (param1.getBody() as uint == BasePaneMediator.MODE_IDX_CAMERA)
                    {
                        this._drawer.importData(1,null);
                        this._submitBtn.addEventListener(MouseEvent.CLICK, this.onSubmit);
                        sendNotification(BasePaneMediator.ANIMATION_USE, false);
                        if (this._submitMask.visible)
                        {
                            this._submitMask.visible = false;
                        }
                        if (!CameraUtil.getCamera())
                        {
                            this.onReturn(null);
                        }
                    }
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

        private function onReturn(event:MouseEvent) : void
        {
            sendNotification(BasePaneMediator.MODE_CHANGE, BasePaneMediator.MODE_IDX_UPLOAD);
            return;
        }// end function

        private function onSubmit(event:MouseEvent) : void
        {
            this._submitMask.visible = true;
            this._drawer.snapshoot();
            sendNotification(NotiNames.APP_SUBMIT_DATA);
            this._submitBtn.removeEventListener(MouseEvent.CLICK, this.onSubmit);
            return;
        }// end function

    }
}
