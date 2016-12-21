package com.comsenz.camera.v4.view
{
    import com.comsenz.camera.v4.*;
    import com.comsenz.camera.v4.model.vo.*;
    import com.comsenz.camera.v4.utils.*;
    import com.comsenz.camera.v4.view.components.*;
    import com.comsenz.camera.v4.view.components.buttons.*;
    import flash.display.*;
    import flash.events.*;
    import flash.external.*;
    import flash.filters.*;
    import org.puremvc.as3.interfaces.*;
    import org.puremvc.as3.patterns.mediator.*;

    public class ModeFinishPaneMediator extends Mediator implements IMediator
    {
        private var _bm2:Bitmap;
        private var _bm3:Bitmap;
        private var _bm1:Bitmap;
        private var bm1maskCls:Class;
        public static const NAME:String = "ModeFinishPaneMediator";

        public function ModeFinishPaneMediator(param1:Object)
        {
            this.bm1maskCls = ModeFinishPaneMediator_bm1maskCls;
            super(NAME, param1);
            var _loc_2:* = new Bitmap(new FinishBack(203,216));
            _loc_2.x = 242;
            _loc_2.y = 33;
            this.pane.addChild(_loc_2);
            this._bm1 = new Bitmap();
            this._bm2 = new Bitmap();
            this._bm3 = new Bitmap();

			this._bm3.y = 10;
            this._bm2.y = 10;
            this._bm1.y = 10;

			this._bm3.filters = [this._getBitmapFilter()];
            this._bm2.filters = [this._getBitmapFilter()];
            this._bm1.filters = [this._getBitmapFilter()];

			this._bm3.smoothing = true;
            this._bm2.smoothing = true;
            this._bm1.smoothing = true;

            this._bm3.cacheAsBitmap = false;
            this._bm2.cacheAsBitmap = false;
            this._bm1.cacheAsBitmap = false;

			this.pane.addChild(this._bm1);
            this.pane.addChild(this._bm2);
            this.pane.addChild(this._bm3);
            var _loc_3:* = new Bitmap(new this.bm1maskCls(220,100));
            _loc_3.x = 10;
            _loc_3.y = 200;
            this.pane.addChild(_loc_3);
            var _loc_4:* = new Label(LocaleObject.getInstance().getKey("note_success"), 18, 0, true,false);
            _loc_4.x = Constants.OUT1_WIDTH + 17 + 0.5 * (Constants.VALID_WIDTH - Constants.OUT1_WIDTH - _loc_4.width);
            _loc_4.y = 155;
            this.pane.addChild(_loc_4);
            var _loc_5:* = new Label(LocaleObject.getInstance().getKey("note_3size"), 12, 7960953, true,false);
            _loc_5.x = Constants.OUT1_WIDTH + 17 + 0.5 * (Constants.VALID_WIDTH - Constants.OUT1_WIDTH - _loc_5.width);
            _loc_5.y = 179;
            this.pane.addChild(_loc_5);
            var _loc_6:* = new FinishButton();
            _loc_6.x = Constants.OUT1_WIDTH + 17 + 0.5 * (Constants.VALID_WIDTH - Constants.OUT1_WIDTH - _loc_6.width);
            _loc_6.y = 203;
            _loc_6.addEventListener(MouseEvent.CLICK, this.onFinishBtn);
            this.pane.addChild(_loc_6);
            return;
        }// end function

        override public function listNotificationInterests() : Array
        {
            return [BasePaneMediator.MODE_CHANGE];
        }// end function

        private function onFinishBtn(event:MouseEvent) : void
        {
            if (ExternalInterface.available)
            {
                ExternalInterface.call("updateavatar");
            }
            else
            {
                sendNotification(NotiNames.SENT_ERROR_MSG, LocaleObject.getInstance().getKey("js_connect_error"));
            }
            sendNotification(BasePaneMediator.MODE_CHANGE, BasePaneMediator.MODE_IDX_UPLOAD);
            return;
        }// end function

        public function get pane() : ModeFinishPane
        {
            return viewComponent as ModeFinishPane;
        }// end function

        override public function handleNotification(param1:INotification) : void
        {
            var _loc_2:BitmapData = null;
            switch(param1.getName())
            {
                case BasePaneMediator.MODE_CHANGE:
                {
                    if (param1.getBody() as uint == BasePaneMediator.MODE_IDX_FINISH)
                    {
                        _loc_2 = (facade.retrieveMediator(BasePaneMediator.NAME) as BasePaneMediator).currBitmapdata;
                        this._bm1.bitmapData = AppOutput.getAppOutput(_loc_2, 1);
                        this._bm2.bitmapData = AppOutput.getAppOutput(_loc_2, 2);
                        this._bm3.bitmapData = AppOutput.getAppOutput(_loc_2, 3);
                        this._bm1.x = 17;
                        this._bm2.x = this._bm1.x + this._bm1.width + 22;
                        this._bm3.x = this._bm2.x + this._bm2.width + 22;
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

        private function _getBitmapFilter() : DropShadowFilter
        {
            var _loc_1:Number = 10066329;
            var _loc_2:Number = 45;
            var _loc_3:Number = 1;
            var _loc_4:Number = 2;
            var _loc_5:Number = 2;
            var _loc_6:Number = 2;
            var _loc_7:Number = 1;
            var _loc_8:Boolean = false;
            var _loc_9:Boolean = false;
            var _loc_10:* = BitmapFilterQuality.HIGH;
            return new DropShadowFilter(_loc_6, _loc_2, _loc_1, _loc_3, _loc_4, _loc_5, _loc_7, _loc_10, _loc_8, _loc_9);
        }// end function

    }
}
