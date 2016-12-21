package com.comsenz.camera.v4.view.components
{
    import com.comsenz.camera.v4.utils.*;
    import flash.display.*;
    import flash.events.*;
    import flash.filters.*;
    import flash.geom.*;

    public class ViewFinderAlterPoint extends Sprite
    {
        private var _vf:ViewFinder;
        private var _wh:uint = 4;
        private var _realScope:Sprite;
        private var _type:uint;
        public static const LT:uint = 1;
        public static const RT:uint = 2;
        public static const LB:uint = 3;
        public static const RB:uint = 4;
        public static const ALTER_END:String = "ViewFinderAlterPointAlterEnd";
        public static const RESIZING:String = "ViewFinderAlterPointResizing";

        public function ViewFinderAlterPoint(param1:ViewFinder, param2:uint)
        {
            this._vf = param1;
            this._type = param2;
            this._realScope = BasicGeom.drawRectSprite(0, 0, -5, -5, this._wh + 10, this._wh + 10);
            this.addChild(this._realScope);
            var _loc_3:* = BasicGeom.drawRectSprite(26316, 0.01, 0, 0, this._wh, this._wh, true, 16777215, 0.7);
            this.addChild(_loc_3);
            this.addEventListener(MouseEvent.MOUSE_OVER, this.onBodyMouseOver);
            this.addEventListener(MouseEvent.MOUSE_OUT, this.onBodyMouseOut);
            this._vf.addEventListener(ViewFinder.SIZE_CHG, this._localPoint);
            this.addEventListener(MouseEvent.MOUSE_DOWN, this.onBodyMouseDown);
            this._vf.container.addEventListener(MouseEvent.MOUSE_UP, this.onVFMouseUp);
            return;
        }// end function

        private function onBodyMouseOut(event:MouseEvent) : void
        {
            Cursor.getInstance().show();
            return;
        }// end function

        private function _localPoint(event:Event = null) : void
        {
            var _loc_2:int = -(0.5 * this._wh - 1);
            var _loc_3:* = 0.5 * this._wh + 1;
            switch(this._type)
            {
                case LT:
                {
                    this.x = _loc_2 - 1;
                    this.y = _loc_2 - 1;
                    break;
                }
                case RT:
                {
                    this.x = this._vf.width - _loc_3;
                    this.y = _loc_2 - 1;
                    break;
                }
                case LB:
                {
                    this.x = _loc_2 - 1;
                    this.y = this._vf.height - _loc_3;
                    break;
                }
                case RB:
                {
                    this.x = this._vf.width - _loc_3;
                    this.y = this._vf.height - _loc_3;
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function onBodyMouseDown(event:MouseEvent) : void
        {
            this._vf.container.addEventListener(MouseEvent.MOUSE_MOVE, this.onVFMouseMove);
            this.removeEventListener(MouseEvent.MOUSE_OUT, this.onBodyMouseOut);
            return;
        }// end function

        private function onVFMouseMove(event:MouseEvent) : void
        {
            event.stopPropagation();
            if (this._vf.container.mouseX < 1 || this._vf.container.mouseX > (this._vf.activeRect.width - 1) || this._vf.container.mouseY < 1 || this._vf.container.mouseY > (this._vf.activeRect.height - 1))
            {
                this.onVFMouseUp(null);
            }
            if (!event.buttonDown)
            {
                this._vf.container.removeEventListener(MouseEvent.MOUSE_MOVE, this.onVFMouseMove);
            }
            this.dispatchEvent(new Event(RESIZING, true));
            event.updateAfterEvent();
            this._getCursor();
            return;
        }// end function

        public function get pointType() : uint
        {
            return this._type;
        }// end function

        private function _getCursor() : void
        {
            var _loc_1:String = null;
            switch(this._type)
            {
                case LT:
                {
                    _loc_1 = Cursor.RESIZE;
                    break;
                }
                case RT:
                {
                    _loc_1 = Cursor.RESIZE2;
                    break;
                }
                case LB:
                {
                    _loc_1 = Cursor.RESIZE2;
                    break;
                }
                case RB:
                {
                    _loc_1 = Cursor.RESIZE;
                    break;
                }
                default:
                {
                    break;
                }
            }
            Cursor.getInstance().show(_loc_1, new GlowFilter(16777215, 0.75, 2, 2, 3, 3));
            return;
        }// end function

        private function onVFMouseUp(event:MouseEvent) : void
        {
            this._vf.container.removeEventListener(MouseEvent.MOUSE_MOVE, this.onVFMouseMove);
            this.addEventListener(MouseEvent.MOUSE_OUT, this.onBodyMouseOut);
            Cursor.getInstance().setOffsetXY(new Point());
            this.dispatchEvent(new Event(ALTER_END, true));
            return;
        }// end function

        private function onBodyMouseOver(event:MouseEvent) : void
        {
            this._getCursor();
            return;
        }// end function

    }
}
