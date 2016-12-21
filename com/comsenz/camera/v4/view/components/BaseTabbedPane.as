package com.comsenz.camera.v4.view.components
{
    import flash.display.*;

    public class BaseTabbedPane extends Sprite
    {
        private var _currentIdx:uint;
        private var _components:Array;
        private var _modeContainer:Sprite;

        public function BaseTabbedPane()
        {
            this._components = [];
            this._modeContainer = new Sprite();
            this.addChild(this._modeContainer);
            return;
        }// end function

        public function setVisibleIndex(param1:uint) : void
        {
            var idx:* = param1;
            if (idx > (this._components.length - 1))
            {
                return;
            }
            try
            {
                this._modeContainer.removeChild(this._components[this._currentIdx]);
            }
            catch (e:Error)
            {
            }
            this._modeContainer.addChild(this._components[idx]);
            this._currentIdx = idx;
            return;
        }// end function

        public function addComponent(param1:DisplayObject) : void
        {
            this._components.push(param1);
            return;
        }// end function

    }
}
