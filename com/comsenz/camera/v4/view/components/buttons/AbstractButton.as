package com.comsenz.camera.v4.view.components.buttons
{
    import com.comsenz.camera.v4.view.components.*;
    import flash.display.*;
    import flash.events.*;
    import flash.filters.*;

    public class AbstractButton extends Sprite
    {
        protected var _label:Label;

        public function AbstractButton()
        {
            this.buttonMode = true;
            this.tabEnabled = false;
            this.addEventListener(MouseEvent.MOUSE_OVER, this.onMouseOver);
            this.addEventListener(MouseEvent.MOUSE_OUT, this.onMouseOut);
            return;
        }// end function

        protected function onMouseOut(event:MouseEvent) : void
        {
            Cursor.getInstance().show();
            return;
        }// end function

        protected function _addFilter() : void
        {
            if (this._label is Label)
            {
                this._label.filters = [new GlowFilter(16777215, 0.95, 3, 3, 4, 5)];
            }
            return;
        }// end function

        protected function onMouseOver(event:MouseEvent) : void
        {
            Cursor.getInstance().show(Cursor.HAND);
            return;
        }// end function

    }
}
