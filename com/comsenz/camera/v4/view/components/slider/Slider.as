package com.comsenz.camera.v4.view.components.slider
{
    import flash.display.*;
    import flash.events.*;

    public class Slider extends Sprite
    {
        private var _root:DisplayObjectContainer;
        private var _bk:DisplayObject;
        private var _enabled:Boolean;
        private var _track:DisplayObject;
        private var _buttonPressed:Boolean;
        private var _thumb:DisplayObject;

        public function Slider(param1:DisplayObjectContainer, param2:Number, param3:Number = 0, param4:Number = 0)
        {
            this._root = param1;
            this._bk = new SliderAsset(2);
            this._bk.x = -11;
            this._bk.y = -10;
            addChild(this._bk);
            this._track = new SliderAsset(0);
            addChild(this._track);
            this._thumb = new SliderAsset(1);
            this._thumb.y = -3.5;
            this._thumb.visible = false;
            addChild(this._thumb);
            this._thumb.addEventListener(MouseEvent.MOUSE_DOWN, this.onThumbMouseDown);
            this.x = param3 + 11;
            this.y = param4 + 10;
            return;
        }// end function

        public function get value() : Number
        {
            return (this._thumb.x + 5) / this._track.width;
        }// end function

        private function onSliderMouseUp(event:MouseEvent) : void
        {
            dispatchEvent(new Event(Event.CHANGE));
            return;
        }// end function

        public function set value(param1:Number) : void
        {
            if (!this._buttonPressed)
            {
                if (param1 > 1)
                {
                    param1 = 1;
                }
                else if (param1 < 0)
                {
                    param1 = 0;
                }
                param1 = this._track.width * param1;
                this._thumb.x = param1 - 5;
            }
            return;
        }// end function

        private function onSliderMouseMove(event:MouseEvent) : void
        {
            if (event.buttonDown)
            {
                event.stopPropagation();
                this._thumb.x = mouseX - 5;
                if (this._thumb.x > this._track.width - 5)
                {
                    this._thumb.x = this._track.width - 5;
                }
                else if (this._thumb.x < -5)
                {
                    this._thumb.x = -5;
                }
            }
            else
            {
                this._buttonPressed = false;
                this._root.removeEventListener(MouseEvent.MOUSE_MOVE, this.onSliderMouseMove, true);
            }
            dispatchEvent(new Event(Event.CHANGE));
            return;
        }// end function

        public function get enabled() : Boolean
        {
            return this._enabled;
        }// end function

        public function set enabled(param1:Boolean) : void
        {
            this._enabled = param1;
            if (param1)
            {
                this._thumb.visible = true;
                this._thumb.addEventListener(MouseEvent.MOUSE_DOWN, this.onThumbMouseDown);
            }
            else
            {
                this._thumb.visible = false;
                this._thumb.removeEventListener(MouseEvent.MOUSE_DOWN, this.onThumbMouseDown);
            }
            return;
        }// end function

        private function onThumbMouseDown(event:MouseEvent) : void
        {
            this._root.addEventListener(MouseEvent.MOUSE_MOVE, this.onSliderMouseMove, true);
            this._root.addEventListener(MouseEvent.MOUSE_UP, this.onSliderMouseUp, true);
            this._buttonPressed = true;
            return;
        }// end function

    }
}
