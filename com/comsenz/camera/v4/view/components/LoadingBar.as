package com.comsenz.camera.v4.view.components
{
    import flash.display.*;
    import flash.events.*;
    import flash.utils.*;

    public class LoadingBar extends Sprite
    {
        private var _timer:Timer;
        private var _curr:uint = 0;
        private var _p1:DisplayObject;
        private var _p2:DisplayObject;
        private var _p3:DisplayObject;
        private var _p4:DisplayObject;

        public function LoadingBar()
        {
            this._p1 = new Bitmap(new LoadingBar_L1(136,10));
            this._p2 = new Bitmap(new LoadingBar_L2(136,10));
            this._p3 = new Bitmap(new LoadingBar_L3(136,10));
            this._p4 = new Bitmap(new LoadingBar_L4(136,10));
            this.addChild(this._p1);
            this.addChild(this._p2);
            this.addChild(this._p3);
            this.addChild(this._p4);
            this._timer = new Timer(75, 0);
            this._timer.addEventListener(TimerEvent.TIMER, this.onTimer);
            this._timer.start();
            return;
        }// end function

        private function hide() : void
        {
            this._p4.visible = false;
            this._p3.visible = false;
            this._p2.visible = false;
            this._p1.visible = false;
            return;
        }// end function

        public function removeFrom(param1:DisplayObjectContainer) : void
        {
            this._timer.removeEventListener(TimerEvent.TIMER, this.onTimer);
            this._timer.stop();
            this._timer = null;
            param1.removeChild(this);
            return;
        }// end function

        public function beCenterTo(param1:Stage) : void
        {
            this.x = 0.5 * (param1.stageWidth - this.width);
            this.y = 0.5 * (param1.stageHeight - this.height);
            return;
        }// end function

        private function onTimer(event:TimerEvent) : void
        {
            this._curr = this._curr == 4 ? (1) : ((this._curr + 1));
            this.hide();
            this.show(this._curr);
            return;
        }// end function

        private function show(param1:uint) : void
        {
            this["_p" + param1].visible = true;
            return;
        }// end function

    }
}
