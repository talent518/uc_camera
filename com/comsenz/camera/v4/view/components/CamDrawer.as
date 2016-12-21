package com.comsenz.camera.v4.view.components
{
    import com.comsenz.camera.v4.events.*;
    import com.comsenz.camera.v4.utils.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.media.*;
	import flash.utils.*;

    public class CamDrawer extends AbstractDrawer implements IDrawer
    {
        private var _camera:Camera;
        private var _video:Video;
        public var turn:Function;

        public function CamDrawer(param1:DisplayObjectContainer, param2:DisplayObject, param3:Number, param4:Number)
        {
            this.turn = this.importData;
            super(param1, param2, param3, param4);
            _viewfinder.addEventListener(ViewFinder.SELECT_RECT_CHANGE, this.onViewfinderSelect);
            _viewfinder.addEventListener(ViewFinder.MOVING, this.onViewfinderMoving);
            _viewfinder.addEventListener(ViewFinder.SIZE_CHG, this.onViewfinderResizing);
            this._initVideo();
            return;
        }// end function

        private function onViewfinderSelect(event:Event) : void
        {
            return;
        }// end function

        private function _initVideo() : void
        {
            this._video = new Video(_w, _h);
            this.addChild(this._video);
            this._camera = CameraUtil.getCamera();
            _viewfinder.updateFrame(Constants.VIEWFINDER_VIDEO_WIDTH, Constants.VIEWFINDER_VIDEO_HEIGHT);
            _viewfinder.beCenterTo(new Rectangle(this._video.x, this._video.y, this._video.width, this._video.height));
            _viewfinder.visible = true;
            return;
        }// end function

        public function importData(type:uint,data:ByteArray) : void
        {
            if (type)
            {
                if (!this._camera)
                {
                    return;
                }
                this._camera.setMode(_w, _h, 36);
                this._camera.setQuality(0, 100);
                this._video.attachCamera(this._camera);
                if (_viewfinder && this.getChildIndex(_viewfinder) < this.getChildIndex(this._video))
                {
                    this.swapChildren(this._video, _viewfinder);
                }
            }
            return;
        }// end function

        public function snapshoot() : void
        {
            if (!_viewfinder || !this._video)
            {
                return;
            }
            var _loc_1:* = _viewfinder.selectedRect;
            var _loc_2:* = new BitmapData(_loc_1.width, _loc_1.height);
            var _loc_3:* = new BitmapData(this._video.width, this._video.height);
            _loc_3.draw(this._video, null, null, null, null, true);
            _loc_2.copyPixels(_loc_3, _loc_1, new Point());
            dispatchEvent(new SubpaneUpdateEvent(SubpaneUpdateEvent.UPDATE, _loc_2));
            _loc_3 = null;
            return;
        }// end function

        private function onViewfinderMoving(event:Event) : void
        {
            return;
        }// end function

        private function onViewfinderResizing(event:Event) : void
        {
            return;
        }// end function

    }
}
