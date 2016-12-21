package com.comsenz.camera.v4.view.components
{
    import com.comsenz.camera.v4.utils.*;
    import flash.display.*;
    import flash.filters.*;
    import flash.text.*;
    import gs.*;

    public class FadeMessager extends Sprite
    {
        private var _bk:Shape;
        private var _h:Number = 37;
        private var _text:TextField;
        private var _format:TextFormat;
        private var _w:Number = 450;
        public static const DOWN:int = 1;
        private static var _instance:FadeMessager = new FadeMessager;
        public static const UP:int = -1;

        public function FadeMessager()
        {
            if (_instance)
            {
                throw new Error("FadeMessager can only be accessed through FadeMessager.getInstance()");
            }
            this._init();
            return;
        }// end function

        public function fadeIn(param1:Number = 1000, param2:int = 1) : void
        {
            this.y = param2 == 1 ? (-this._h) : (0);
            this.alpha = 0;
            TweenLite.to(this, param1 / 1000, {alpha:1, y:param2 == 1 ? (0) : (-this._h)});
            return;
        }// end function

        public function setSize(param1:Number, param2:Number) : void
        {
            this._w = param1;
            this._h = param2;
            return;
        }// end function

        private function _init() : void
        {
            this._text = new TextField();
            this._text.autoSize = TextFieldAutoSize.LEFT;
            this._text.multiline = true;
            this._text.selectable = false;
            this._text.x = 10;
            this.addChild(this._text);
            this._format = new TextFormat();
            this._format.size = 12;
            this._format.color = 0;
            this._text.defaultTextFormat = this._format;
            return;
        }// end function

        public function play(param1:Number = 3000, param2:int = 1) : void
        {
            this.y = param2 == 1 ? (-this._h) : (0);
            this.alpha = 0;
            var _loc_3:* = new TweenGroup([new TweenLite(this, 0.7, {alpha:1, y:param2 == 1 ? (0) : (-this._h)}), new TweenLite(this, param1 / 1000, {alpha:1, y:param2 == 1 ? (0) : (-this._h)}), new TweenLite(this, 0.5, {alpha:0, y:param2 == 1 ? (-this._h) : (0)})]);
            _loc_3.align = TweenGroup.ALIGN_SEQUENCE;
            _loc_3.restart();
            return;
        }// end function

        public function fadeOut(param1:Number = 1000, param2:int = -1) : void
        {
            this.y = param2 == 1 ? (-this._h) : (0);
            this.alpha = 1;
            TweenLite.to(this, param1 / 1000, {alpha:0, y:param2 == 1 ? (0) : (-this._h)});
            return;
        }// end function

        public function setBackground(param1:Number = 16777215, param2:Number = 1) : void
        {
            if (this._bk)
            {
                this.removeChild(this._bk);
            }
            else
            {
                this.mask = BasicGeom.drawRect(0, 1, 0, 0, this._w, this._h);
            }
            this._bk = BasicGeom.drawRect(param1, param2, 0, 0, this._w, this._h);
            this.addChild(this._bk);
            if (this.getChildIndex(this._bk) > this.getChildIndex(this._text))
            {
                this.swapChildren(this._bk, this._text);
            }
            return;
        }// end function

        public function setText(param1:String = "", param2:Number = 0, param3:uint = 12, param4:BitmapFilter = null) : void
        {
            this._format.size = param3;
            this._format.color = param2;
            this._text.text = param1;
            this._text.setTextFormat(this._format);
            this._text.y = (this._h - this._text.height) * 0.5;
            if (param4)
            {
                this._text.filters = [param4];
            }
            else
            {
                this._text.filters = [];
            }
            return;
        }// end function

        public static function getInstance() : FadeMessager
        {
            return _instance;
        }// end function

    }
}
