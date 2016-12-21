package com.comsenz.camera.v4.view.components.buttons
{
    import flash.display.*;
    import flash.events.*;

    public class AbstractBorderButton extends AbstractButton
    {
        private var _off:DisplayObject;
        private var onCls:Class;
        private var offCls:Class;
        private var _on:DisplayObject;

        public function AbstractBorderButton()
        {
            this.onCls = AbstractBorderButton_onCls;
            this.offCls = AbstractBorderButton_offCls;
            this._on = new Bitmap(new this.onCls(172,45));
            this._on.visible = false;
            this.addChild(this._on);
            this._off = new Bitmap(new this.offCls(172,45));
            this.addChild(this._off);
            return;
        }// end function

        override protected function onMouseOut(event:MouseEvent) : void
        {
            this._off.visible = true;
            this._on.visible = false;
            return;
        }// end function

        override protected function onMouseOver(event:MouseEvent) : void
        {
            this._on.visible = true;
            this._off.visible = false;
            return;
        }// end function

    }
}
