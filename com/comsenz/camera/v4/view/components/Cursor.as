package com.comsenz.camera.v4.view.components
{
    import flash.display.*;
    import flash.events.*;
    import flash.filters.*;
    import flash.geom.*;
    import flash.ui.*;

    public class Cursor extends Bitmap
    {
        public var YSplitter:Class;
        public var CHand:Class;
        public var CMove:Class;
        public var CResize:Class;
        private var delta:Point;
        private var _offset:Point;
        public var CResize2:Class;
        public var XSplitter:Class;
        public static const YSPITTER:String = "yspit";
        public static const XSPITTER:String = "xspit";
        public static const MOVE:String = "move";
        public static const RESIZE:String = "resize";
        public static const HAND:String = "hand";
        private static var _instance:Cursor = new Cursor;
        public static const RESIZE2:String = "resize2";

        public function Cursor()
        {
            this.CMove = Cursor_CMove;
            this.CResize = Cursor_CResize;
            this.CResize2 = Cursor_CResize2;
            this.XSplitter = Cursor_XSplitter;
            this.YSplitter = Cursor_YSplitter;
            this.CHand = Cursor_CHand;
            this.delta = new Point();
            this._offset = new Point();
            if (_instance)
            {
                throw new Error("Cursor can only be accessed through Cursor.getInstance()");
            }
            return;
        }// end function

        public function setOffsetXY(param1:Point) : void
        {
            this._offset = param1;
            return;
        }// end function

        private function MouseMoveEvent(event:MouseEvent) : void
        {
            x = parent.mouseX + this.delta.x + this._offset.x;
            y = parent.mouseY + this.delta.y + this._offset.y;
            return;
        }// end function

        public function show(param1:String = null, param2:BitmapFilter = null) : void
        {
            Mouse.hide();
            switch(param1)
            {
                case MOVE:
                {
                    bitmapData = new this.CMove(19,19);
                    this.delta.x = -7;
                    this.delta.y = -7;
                    break;
                }
                case RESIZE:
                {
                    bitmapData = new this.CResize(12,12);
                    this.delta.x = -6;
                    this.delta.y = -5;
                    break;
                }
                case RESIZE2:
                {
                    bitmapData = new this.CResize2(12,12);
                    this.delta.x = -6;
                    this.delta.y = -5;
                    break;
                }
                case XSPITTER:
                {
                    bitmapData = new this.XSplitter(16,13);
                    this.delta.x = -7;
                    this.delta.y = -5;
                    break;
                }
                case YSPITTER:
                {
                    bitmapData = new this.YSplitter(13,14);
                    this.delta.x = -5;
                    this.delta.y = -6;
                    break;
                }
                case HAND:
                {
                    bitmapData = new this.CHand(16,19);
                    this.delta.x = -3;
                    this.delta.y = -3;
                    break;
                }
                case null:
                {
                    Mouse.show();
                    stage.removeEventListener(MouseEvent.MOUSE_MOVE, this.MouseMoveEvent);
                    bitmapData = null;
                    return;
                }
                default:
                {
                    break;
                }
            }
            if (param2)
            {
                this.filters = [param2];
            }
            else
            {
                this.filters = [];
            }
            stage.addEventListener(MouseEvent.MOUSE_MOVE, this.MouseMoveEvent);
            this.MouseMoveEvent(null);
            return;
        }// end function

        public static function getInstance() : Cursor
        {
            return _instance;
        }// end function

    }
}
