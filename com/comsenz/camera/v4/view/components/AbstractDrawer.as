package com.comsenz.camera.v4.view.components
{
    import com.comsenz.camera.v4.utils.*;
    import flash.display.*;
    import flash.geom.*;

    public class AbstractDrawer extends Sprite
    {
        protected var _root:DisplayObjectContainer;
        protected var _parent:DisplayObject;
        protected var _h:Number;
        protected var _viewfinder:ViewFinder;
        protected var _w:Number;

        public function AbstractDrawer(param1:DisplayObjectContainer, param2:DisplayObject, param3:Number, param4:Number)
        {
            this._root = param1;
            this._parent = param2;
            this._w = param3;
            this._h = param4;
            this._makeMask();
            this._buildViewfinder();
            return;
        }// end function

        private function _makeMask() : void
        {
            var _loc_1:* = BasicGeom.drawRect(16777215, 0, 0, 0, this._w, this._h);
            this.addChild(_loc_1);
            this.mask = _loc_1;
            return;
        }// end function

        private function _buildViewfinder() : void
        {
            this._viewfinder = new ViewFinder(this, new Rectangle(0, 0, this._w, this._h), new Rectangle(0, 0, Constants.MIN_FINDER_WIDTH, Constants.MIN_FINDER_HEIGHT));
            this._viewfinder.visible = false;
            this.addChild(this._viewfinder);
            return;
        }// end function

    }
}
