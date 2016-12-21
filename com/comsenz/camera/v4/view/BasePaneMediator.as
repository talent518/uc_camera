package com.comsenz.camera.v4.view
{
    import com.comsenz.camera.v4.utils.*;
    import com.comsenz.camera.v4.view.components.*;
    import flash.display.*;
    import org.puremvc.as3.interfaces.*;
    import org.puremvc.as3.patterns.mediator.*;

    public class BasePaneMediator extends Mediator implements IMediator
    {
        private var _isUsingAnimation:Boolean = false;
        private var _currBitmapdata:BitmapData = null;
        public static const MODE_IDX_CAMERA:uint = 2;
        public static const NAME:String = "BasePaneMediator";
        public static const MODE_CHANGE:String = "bpModeChange";
        public static const MODE_IDX_UPLOAD:uint = 1;
        public static const UPDATE_BITMAPDATA:String = "bpUpdateBitmapdata";
        public static const MODE_IDX_FINISH:uint = 3;
        public static const SET_VISIBLE_IDX:String = "bpSetvisibleIdx";
        public static const ANIMATION_USE:String = "bpAnimationUse";
        public static const ADD_COMPONENT:String = "bpAddComponent";

        public function BasePaneMediator(param1:Object)
        {
            super(NAME, param1);
            var _loc_2:* = new ModePicPane();
            var _loc_3:* = new ModeCamPane();
            var _loc_4:* = new ModeFinishPane();
            facade.registerMediator(new ModePicPaneMediator(_loc_2));
            facade.registerMediator(new ModeCamPaneMediator(_loc_3));
            facade.registerMediator(new ModeFinishPaneMediator(_loc_4));
            this.pane.addComponent(_loc_2);
            this.pane.addComponent(_loc_3);
            this.pane.addComponent(_loc_4);
            this.pane.setVisibleIndex(0);
            var _loc_5:* = BasicGeom.drawRect(16777215, 0, 0, 0, (Constants.APP_WIDTH - 1), (Constants.APP_HEIGHT - 1), true, 14079702, 1);
            this.pane.addChild(_loc_5);
            var _loc_6:* = FadeMessager.getInstance();
            facade.registerMediator(new FadeMessagerMediator(_loc_6));
            this.pane.addChild(_loc_6);
            var _loc_7:* = Cursor.getInstance();
            facade.registerMediator(new CursorMediator(_loc_7));
            this.pane.addChild(_loc_7);
            return;
        }// end function

        override public function listNotificationInterests() : Array
        {
            return [MODE_CHANGE, UPDATE_BITMAPDATA, ANIMATION_USE];
        }// end function

        override public function handleNotification(param1:INotification) : void
        {
            var _loc_2:uint = 0;
            var _loc_3:BitmapData = null;
            var _loc_4:Boolean = false;
            switch(param1.getName())
            {
                case MODE_CHANGE:
                {
                    _loc_2 = param1.getBody() as uint;
                    this.pane.setVisibleIndex((_loc_2 - 1));
                    break;
                }
                case UPDATE_BITMAPDATA:
                {
                    _loc_3 = param1.getBody() as BitmapData;
                    this._currBitmapdata = _loc_3;
                    break;
                }
                case ANIMATION_USE:
                {
                    _loc_4 = param1.getBody() as Boolean;
                    this._isUsingAnimation = _loc_4;
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        public function get pane() : BasePane
        {
            return viewComponent as BasePane;
        }// end function

        public function get isUsingAnimation() : Boolean
        {
            return this._isUsingAnimation;
        }// end function

        public function get currBitmapdata() : BitmapData
        {
            return this._currBitmapdata;
        }// end function

    }
}
