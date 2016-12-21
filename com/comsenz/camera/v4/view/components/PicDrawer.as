package com.comsenz.camera.v4.view.components
{
    import com.comsenz.camera.v4.errors.*;
    import com.comsenz.camera.v4.events.*;
    import com.comsenz.camera.v4.utils.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.utils.*;

    public class PicDrawer extends AbstractDrawer implements IDrawer
    {
        private var _minScaleX:Number;
        private var _minScaleY:Number;
        private var _currRect:Rectangle;
        private var _asset:AbstractAsset;
        private var _scaleWhenAssetInit:Number;
        private var _pictureIsSmall:Boolean;
        private var _assetHasInited:Boolean;

        public function PicDrawer(param1:DisplayObjectContainer, param2:DisplayObject, param3:Number, param4:Number)
        {
            super(param1, param2, param3, param4);
            _viewfinder.addEventListener(ViewFinder.SELECT_RECT_CHANGE, this.onViewfinderSelect);
            _viewfinder.addEventListener(ViewFinder.MOVING, this.onViewfinderMoving);
            _viewfinder.addEventListener(ViewFinder.SIZE_CHG, this.onViewfinderResizing);
            return;
        }// end function

        private function onAssetLoadComp(event:Event) : void
        {
            this._initAsset();
            return;
        }// end function

        private function onViewfinderMoving(event:Event) : void
        {
            this._accordPicWithViewfinder();
            return;
        }// end function

        private function _initAsset() : void
        {
            this._asset.scaleY = 1;
            this._asset.scaleX = 1;
            this._minScaleX = Constants.MIN_FINDER_WIDTH / this._asset.width;
            this._minScaleY = Constants.MIN_FINDER_HEIGHT / this._asset.height;
            this._minScaleY = Math.max(this._minScaleX, this._minScaleY);
            this._minScaleX = Math.max(this._minScaleX, this._minScaleY);
            if (this._asset.width > Constants.PHOTO_WIDTH || this._asset.height > Constants.PHOTO_HEIGHT)
            {
                this._pictureIsSmall = false;
                PictureUtil.adaptSizeByKeepingScale(this._asset, Constants.PHOTO_WIDTH, Constants.PHOTO_HEIGHT, false);
            }
            else if (this._asset.width < Constants.MIN_FINDER_WIDTH || this._asset.height < Constants.MIN_FINDER_HEIGHT)
            {
                this._pictureIsSmall = true;
            }
            this._scaleWhenAssetInit = this._asset.scaleX;
            this._asset.beCenterTo(new Rectangle(0, 0, Constants.PHOTO_WIDTH, Constants.PHOTO_HEIGHT));
            var _loc_1:* = Math.min(Constants.MIN_FINDER_WIDTH, Constants.MIN_FINDER_HEIGHT);
            var _loc_2:* = Math.min(this._asset.width, this._asset.height);
            if (_loc_2 > Constants.COMMON_FINDER_SIZE)
            {
                _loc_1 = Constants.COMMON_FINDER_SIZE;
            }
            else if (_loc_2 > _loc_1)
            {
                _loc_1 = _loc_2;
            }
            _viewfinder.updateFrame(_loc_1, _loc_1);
            _viewfinder.beCenterTo(new Rectangle(this._asset.x, this._asset.y, this._asset.width, this._asset.height));
            _viewfinder.visible = true;
            if (!this._pictureIsSmall)
            {
                this.dispatchEvent(new Event(Event.INIT));
            }
            this._assetHasInited = true;
            return;
        }// end function

        public function zoom(param1:Number) : void
        {
            var _loc_2:Number = NaN;
            var _loc_3:Number = NaN;
            if (param1 > 0)
            {
                _loc_3 = 1;
                if (this._scaleWhenAssetInit == 1)
                {
                    _loc_3 = Constants.PHOTO_WIDTH / (this._asset.width * this._scaleWhenAssetInit / this._asset.scaleX);
                }
                else if (this._scaleWhenAssetInit > 1)
                {
                    if (this._asset.width < this._asset.height)
                    {
                        _loc_3 = Constants.PHOTO_WIDTH / (this._asset.width / this._scaleWhenAssetInit / this._asset.scaleX);
                    }
                    else
                    {
                        _loc_3 = Constants.PHOTO_HEIGHT / (this._asset.height / this._scaleWhenAssetInit / this._asset.scaleY);
                    }
                }
                _loc_2 = param1 * Math.abs(_loc_3 - this._scaleWhenAssetInit) + this._scaleWhenAssetInit;
            }
            else
            {
                _loc_2 = (1 + param1) * this._scaleWhenAssetInit;
            }
            this._asset.scaleX = Math.max(_loc_2, this._minScaleX);
            this._asset.scaleY = Math.max(_loc_2, this._minScaleY);
            this._asset.beCenterTo(new Rectangle(0, 0, Constants.PHOTO_WIDTH, Constants.PHOTO_HEIGHT));
            this._keepViewfinderValid();
            this.snapshoot();
            return;
        }// end function

        private function onViewfinderResizing(event:Event) : void
        {
            this._accordPicWithViewfinder();
            return;
        }// end function

        public function snapshoot() : void
        {
            this.onViewfinderSelect(null);
            return;
        }// end function

        private function onViewfinderSelect(event:Event) : void
        {
            if (!_viewfinder || !this._asset)
            {
                return;
            }
            this._keepViewfinderValid();
            this._accordPicWithViewfinder();
            var _loc_2:* = _viewfinder.selectedRect;
            var _loc_3:* = this._asset.snapshoot(_loc_2, true, null);
            this._currRect = _loc_2;
            dispatchEvent(new SubpaneUpdateEvent(SubpaneUpdateEvent.UPDATE, _loc_3 as BitmapData));
            return;
        }// end function

        private function _keepViewfinderValid() : void
        {
            if (!_viewfinder || !this._asset)
            {
                return;
            }
            if (_viewfinder.width > this._asset.width)
            {
                _viewfinder.width = this._asset.width;
            }
            if (_viewfinder.height > this._asset.height)
            {
                _viewfinder.height = this._asset.height;
            }
            if (_viewfinder.x + _viewfinder.width - this._asset.x - this._asset.width > 0)
            {
                _viewfinder.x = this._asset.x + (this._asset.width - _viewfinder.width)/(this._asset.width<_viewfinder.width?2:1);
            }
            else if (_viewfinder.x < this._asset.x)
            {
                _viewfinder.x = Math.max(this._asset.x, 0);
            }
            if (_viewfinder.y + _viewfinder.height - this._asset.y - this._asset.height > 0)
            {
                _viewfinder.y = this._asset.y + (this._asset.height - _viewfinder.height)/(this._asset.height<_viewfinder.height?2:1);
            }
            else if (_viewfinder.y < this._asset.y)
            {
                _viewfinder.y = Math.max(this._asset.y, 0);
            }
            return;
        }// end function

        public function importData(type:uint,data:ByteArray) : void
        {
            this._assetHasInited = false;
            if (this._asset)
            {
                this._asset.removeEventListener(Event.COMPLETE, this.onAssetLoadComp);
                this.removeChild(this._asset);
            }
            switch(type)
            {
                case PictureUploadEvent.STATIC_PICTURE:
                {
                    this._asset = new JpgAsset();
                    dispatchEvent(new UsingAnimationEvent(UsingAnimationEvent.IFUSE, false));
                    break;
                }
                case PictureUploadEvent.ANIMATER_PICTURE:
                {
                    this._asset = new GifAsset();
                    dispatchEvent(new UsingAnimationEvent(UsingAnimationEvent.IFUSE, true));
                    break;
                }
                default:
                {
                    break;
                }
            }
            this.addChild(this._asset);
            this._asset.addEventListener(Event.COMPLETE, this.onAssetLoadComp);
            this._asset.addEventListener(IOErrorEvent.IO_ERROR, this.onAssetIoError);
            try
            {
                this._asset.importAsset(data);
            }
            catch (ex:GifFrameCountError)
            {
                _asset = null;
                _viewfinder.visible = false;
                dispatchEvent(new GifFrameCountErrorEvent());
                return;
            }
            dispatchEvent(new Event(Event.SELECT));
            if (_viewfinder && this.getChildIndex(_viewfinder) < this.getChildIndex(this._asset))
            {
                this.swapChildren(this._asset, _viewfinder);
            }
            return;
        }// end function

        private function onAssetIoError(event:IOErrorEvent) : void
        {
            return;
        }// end function

        public function get currRect() : Rectangle
        {
            return this._currRect;
        }// end function

        public function get asset() : AbstractAsset
        {
            return this._asset;
        }// end function

        private function _accordPicWithViewfinder() : void
        {
            if (!this._assetHasInited)
            {
                return;
            }
            var _loc_1:* = _viewfinder.x / (Constants.PHOTO_WIDTH - _viewfinder.width);
            var _loc_2:* = _viewfinder.y / (Constants.PHOTO_HEIGHT - _viewfinder.height);
            var _loc_3:* = isFinite(_loc_1) && !isNaN(_loc_1) && isFinite(_loc_2) && !isNaN(_loc_2);
            if (_loc_3 && (this._asset.x <= 0 || this._asset.y <= 0))
            {
                this._asset.x = (Constants.PHOTO_WIDTH - this._asset.width) * _loc_1;
                this._asset.y = (Constants.PHOTO_HEIGHT - this._asset.height) * _loc_2;
            }
            return;
        }// end function

    }
}
