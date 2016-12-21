package com.comsenz.camera.v4.view.components
{
    import com.comsenz.camera.v4.utils.*;
    import flash.display.*;
    import flash.events.*;
    import flash.filters.*;
    import flash.geom.*;

    public class ViewFinder extends Sprite
    {
        private var _ts:Number = 0;
        private var _ltPoint:ViewFinderAlterPoint;
        private var _rtPoint:ViewFinderAlterPoint;
        private var _lbPoint:ViewFinderAlterPoint;
        private var _rbPoint:ViewFinderAlterPoint;
        private var _commonSize:Number;
        private var _minSize:Rectangle;
        private var _rect:Rectangle;
        private var _parent:DisplayObject;
        private var _glassB:Sprite;
        private var _glassC:Sprite;
        private var _glassD:Sprite;
        private var _glassA:Sprite;
        private var _frame:Sprite;
        private var _w:Number;
        private var _h:Number;
        public static const SIZE_CHG:String = "viewfindersizechg";
        public static const SELECT_RECT_CHANGE:String = "viewfinderSelectRectChg";
        public static const MOVING:String = "viewfinderMoving";

        public function ViewFinder(param1:DisplayObject, param2:Rectangle, param3:Rectangle)
        {
            this._parent = param1;
            this._rect = param2;
            this._minSize = param3;
            this._commonSize = Math.max(this._rect.width, this._rect.height);
            this._frame = BasicGeom.drawRectSprite(16777215, 0.01, 0, 0, 1, 1);
            this._frame.addEventListener(MouseEvent.MOUSE_OVER, this.onMouseOver);
            this._frame.addEventListener(MouseEvent.MOUSE_OUT, this.onMouseOut);
            this._frame.addEventListener(MouseEvent.MOUSE_DOWN, this.onMouseDownEvent);
            this._frame.addEventListener(MouseEvent.MOUSE_UP, this.onMouseUpEvent);
            this.addChild(this._frame);
            this._glassA = this._getBasicBox();
            this._glassB = this._getBasicBox();
            this._glassC = this._getBasicBox();
            this._glassD = this._getBasicBox();
            this.addChild(this._glassA);
            this.addChild(this._glassB);
            this.addChild(this._glassC);
            this.addChild(this._glassD);
            this._ltPoint = new ViewFinderAlterPoint(this, ViewFinderAlterPoint.LT);
            this._rtPoint = new ViewFinderAlterPoint(this, ViewFinderAlterPoint.RT);
            this._lbPoint = new ViewFinderAlterPoint(this, ViewFinderAlterPoint.LB);
            this._rbPoint = new ViewFinderAlterPoint(this, ViewFinderAlterPoint.RB);
            this.addChild(this._ltPoint);
            this.addChild(this._rtPoint);
            this.addChild(this._lbPoint);
            this.addChild(this._rbPoint);
            this.addEventListener(ViewFinderAlterPoint.RESIZING, this.onVFResizing);
            this.addEventListener(ViewFinderAlterPoint.ALTER_END, this.onVFAlterEnd);
            return;
        }// end function

        public function get container() : DisplayObject
        {
            return this._parent;
        }// end function

        public function get activeRect() : Rectangle
        {
            return this._rect;
        }// end function

        public function beCenterTo(param1:Rectangle) : void
        {
            this.x = param1.x + 0.5 * (param1.width - this.width);
            this.y = param1.y + 0.5 * (param1.height - this.height);
            return;
        }// end function

        public function get selectedRect() : Rectangle
        {
            return new Rectangle(this.x, this.y, this.width, this.height);
        }// end function

        private function _updateBorder() : void
        {
            this.graphics.clear();
            this.graphics.lineStyle(1, 16777215, 0.6);
            this.graphics.drawRect(0, 0, (this._w - 1), (this._h - 1));
            return;
        }// end function

        private function onMouseUpEvent(event:MouseEvent) : void
        {
            this.stopDrag();
            this._parent.removeEventListener(MouseEvent.MOUSE_MOVE, this.onMouseMoveEvent);
            Cursor.getInstance().show();
            if (event != null)
            {
                this.dispatchEvent(new Event(SELECT_RECT_CHANGE));
            }
            return;
        }// end function

        override public function get width() : Number
        {
            return Math.min(this._frame.width,this._frame.height);
        }// end function

        override public function set width(param1:Number) : void
        {
            this.updateFrame(param1, this._frame.height);
            return;
        }// end function

        override public function get height() : Number
        {
            return Math.min(this._frame.width,this._frame.height);
        }// end function

        override public function set height(param1:Number) : void
        {
            this.updateFrame(this._frame.width, param1);
            return;
        }// end function

        private function onMouseDownEvent(event:MouseEvent) : void
        {
            this.startDrag(false, new Rectangle(this._rect.x, this._rect.y, this._rect.width - this.width, this._rect.height - this.height));
            this._parent.addEventListener(MouseEvent.MOUSE_MOVE, this.onMouseMoveEvent);
            return;
        }// end function

        private function onVFResizing(event:Event) : void
        {
            event.stopPropagation();
            var _loc_2:* = (event.target as ViewFinderAlterPoint).pointType;
            switch(_loc_2)
            {
                case ViewFinderAlterPoint.LT:
                {
                    this._getLimit("l");
                    this._getLimit("t");
                    break;
                }
                case ViewFinderAlterPoint.RT:
                {
                    this._getLimit("r");
                    this._getLimit("t");
                    break;
                }
                case ViewFinderAlterPoint.LB:
                {
                    this._getLimit("l");
                    this._getLimit("b");
                    break;
                }
                case ViewFinderAlterPoint.RB:
                {
                    this._getLimit("r");
                    this._getLimit("b");
                    break;
                }
                default:
                {
                    break;
                }
            }

			if(this.x<0)
				this.x=0;
            if(this.x>this._rect.width - this.width)
				this.x=this._rect.width - this.width;
			if(this.y<0)
				this.y=0;
            if(this.y>this._rect.height - this.height)
				this.y=this._rect.height - this.height;
            this._updateGlass();
            this._updateBorder();

			this.dispatchEvent(new Event(SIZE_CHG));
            return;
        }// end function

        private function onVFAlterEnd(event:Event) : void
        {
            event.stopPropagation();
            var _loc_2:* = new Date().getTime();
            if (_loc_2 - this._ts > 10)
            {
                this._ts = _loc_2;
                this.dispatchEvent(new Event(SELECT_RECT_CHANGE));
            }
            return;
        }// end function

        private function _getLimit(param1:String) : void
        {
            switch(param1)
            {
                case "l":
                {
                    if (this.width - mouseX >= this._minSize.width)
                    {
                        this.width = this.width - mouseX;
                        this.x = this.x + mouseX;
                    }
                    break;
                }
                case "r":
                {
                    if (mouseX >= this._minSize.width)
                    {
                        this.width = mouseX;
                    }
                    break;
                }
                case "t":
                {
                    if (this.height - mouseY >= this._minSize.height)
                    {
                        this.height = this.height - mouseY;
                        this.y = this.y + mouseY;
                    }
                    break;
                }
                case "b":
                {
                    if (mouseY >= this._minSize.height)
                    {
                        this.height = mouseY;
                    }
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        public function updateFrame(param1:Number, param2:Number) : void
        {
			var side:Number=Math.min(param1,param1);
            this._w = side;
            this._h = side;
            this._frame.width = side;
            this._frame.height = side;
            this._updateGlass();
            this._updateBorder();
            dispatchEvent(new Event(SIZE_CHG));
            return;
        }// end function

        private function onMouseOut(event:MouseEvent) : void
        {
            Cursor.getInstance().show();
            this.onMouseUpEvent(null);
            return;
        }// end function

        private function _updateGlass() : void
        {
            with (this._glassA)
            {
                width = _w + 2 * _commonSize;
                height = _commonSize;
                x = -_commonSize;
                y = -_commonSize;
            }
            with (this._glassB)
            {
                width = _w + 2 * _commonSize;
                height = _commonSize;
                x = -_commonSize;
                y = _h;
            }
            with (this._glassC)
            {
                width = _commonSize;
                height = _h;
                x = -_commonSize;
                y = 0;
            }
            with (this._glassD)
            {
                width = _commonSize;
                height = _h;
                x = _w;
                y = 0;
            }
            return;
        }// end function

        private function onMouseMoveEvent(event:MouseEvent) : void
        {
            event.stopPropagation();
            if (event.buttonDown)
            {
                Cursor.getInstance().show(Cursor.MOVE, new GlowFilter(16777215, 0.75, 2, 2, 3, 3));
                this.dispatchEvent(new Event(MOVING));
            }
            else
            {
                this._parent.removeEventListener(MouseEvent.MOUSE_MOVE, this.onMouseMoveEvent);
            }
            return;
        }// end function

        private function onMouseOver(event:MouseEvent) : void
        {
            Cursor.getInstance().show(Cursor.MOVE, new GlowFilter(16777215, 0.75, 2, 2, 3, 3));
            return;
        }// end function

        private function _getBasicBox() : Sprite
        {
            return BasicGeom.drawRectSprite(0, 0.63, 0, 0, 1, 1);
        }// end function

    }
}
