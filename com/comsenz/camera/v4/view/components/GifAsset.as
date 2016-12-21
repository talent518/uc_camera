package com.comsenz.camera.v4.view.components
{
    import com.comsenz.camera.v4.errors.*;
    import com.comsenz.camera.v4.utils.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.utils.*;
    import org.gif.encoder.*;
    import org.gif.events.*;
    import org.gif.frames.*;
    import org.gif.player.*;

    public class GifAsset extends AbstractAsset
    {
        private var _player:GIFPlayer;
        private var _firstFrameBitmap:Bitmap;

        public function GifAsset()
        {
            this._firstFrameBitmap = new Bitmap();
            this.addChild(this._firstFrameBitmap);
            this._player = new GIFPlayer();
            this._player.addEventListener(IOErrorEvent.IO_ERROR, this.onIOError);
            this._player.addEventListener(FileTypeEvent.INVALID, this.onInvalidFileLoaded);
            this._player.addEventListener(GIFPlayerEvent.COMPLETE, this.onCompleteGIFLoad);
            this._player.addEventListener(FrameEvent.FRAME_RENDERED, this.onFrameRendered);
            this.addChild(this._player);
            return;
        }// end function

        private function onFrameRendered(event:FrameEvent) : void
        {
            return;
        }// end function

        override public function get width() : Number
        {
            return this._player.getFrame(1).bitmapData.width * this.scaleX;
        }// end function

        private function onIOError(event:IOErrorEvent) : void
        {
            this.dispatchEvent(event);
            return;
        }// end function

        override public function importAsset(param1:ByteArray) : void
        {
            this._player.loadBytes(param1);
            if (this._player.frames.length > Constants.GIF_FRAME_LIMIT)
            {
                this._player.visible = false;
                this._player.removeEventListener(IOErrorEvent.IO_ERROR, this.onIOError);
                this._player.removeEventListener(FileTypeEvent.INVALID, this.onInvalidFileLoaded);
                this._player.removeEventListener(GIFPlayerEvent.COMPLETE, this.onCompleteGIFLoad);
                this._player.removeEventListener(FrameEvent.FRAME_RENDERED, this.onFrameRendered);
                this.removeChild(this._player);
                this.removeChild(this._firstFrameBitmap);
                this._player = null;
                this._firstFrameBitmap = null;
                throw new GifFrameCountError();
            }
            this._player.visible = true;
            return;
        }// end function

        override public function get height() : Number
        {
            return this._player.getFrame(1).bitmapData.height * this.scaleY;
        }// end function

        private function onCompleteGIFLoad(event:GIFPlayerEvent) : void
        {
            this._firstFrameBitmap.bitmapData = this._player.getFrame(1).bitmapData.clone();
            dispatchEvent(new Event(Event.COMPLETE));
            return;
        }// end function

        override public function snapshoot(param1:Rectangle, param2:Boolean, param3:Rectangle, param4:Boolean = false)
        {
            var _loc_8:BitmapData = null;
            var _loc_9:GIFFrame = null;
            var _loc_10:BitmapData = null;
            var _loc_11:BitmapData = null;
            var _loc_12:BitmapData = null;
            var _loc_13:BitmapData = null;
            var _loc_14:Number = NaN;
            var _loc_5:* = this._toLocalRect(param1);
            if (param2)
            {
                _loc_8 = new BitmapData(_loc_5.width, _loc_5.height, true, 0);
                _loc_8.copyPixels(this._firstFrameBitmap.bitmapData, _loc_5, new Point(0, 0));
                return _loc_8;
            }
            this._player.stop();
            var _loc_6:* = new GIFEncoder();
            _loc_6.setRepeat(0);
            _loc_6.setQuality(12);
            _loc_6.start();
            var _loc_7:uint = 0;
            while (_loc_7 < this._player.totalFrames)
            {
                
                this._player.gotoAndStop((_loc_7 + 1));
                _loc_9 = this._player.getFrame((_loc_7 + 1));
                _loc_10 = _loc_9.bitmapData.clone();
                _loc_11 = new BitmapData(_loc_5.width + _loc_5.x, _loc_5.height + _loc_5.y);
                _loc_11.draw(this, null, null, null, _loc_5, true);
                if (!param4)
                {
                    _loc_12 = new BitmapData(_loc_5.width, _loc_5.height);
                    _loc_12.copyPixels(_loc_11, _loc_5, new Point());
                }
                else
                {
                    _loc_13 = new BitmapData(_loc_5.width, _loc_5.height);
                    _loc_13.copyPixels(_loc_11, _loc_5, new Point());
                    _loc_14 = Math.min(_loc_5.width, _loc_5.height);
                    _loc_12 = new BitmapData(_loc_14, _loc_14);
                    _loc_12.copyPixels(_loc_13, new Rectangle(0.5 * (_loc_13.width - _loc_12.width), 0.5 * (_loc_13.height - _loc_12.height), _loc_12.width, _loc_12.height), new Point(), null, null, true);
                }
                if (!param2 && param3)
                {
                    _loc_12 = PictureUtil.adaptBitmapData(_loc_12, param3.width, param3.height, true);
                }
                _loc_6.addFrame(_loc_12);
                _loc_6.setDelay(_loc_9.delay);
                _loc_7 = _loc_7 + 1;
            }
            _loc_6.finish();
            this._player.play();
            return _loc_6.stream;
        }// end function

        private function onInvalidFileLoaded(event:FileTypeEvent) : void
        {
            return;
        }// end function

        override public function beCenterTo(param1:Rectangle) : void
        {
            this._beCenterTo(param1);
            return;
        }// end function

    }
}
