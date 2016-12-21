package com.comsenz.camera.v4.view.components.slider
{
    import flash.display.*;

    public class SliderAsset extends Sprite
    {
        private var bkCls:Class;
        private var btnCls:Class;
        private var barCls:Class;
        private var _obj:DisplayObject;

        public function SliderAsset(param1:uint)
        {
            this.btnCls = SliderAsset_btnCls;
            this.barCls = SliderAsset_barCls;
            this.bkCls = SliderAsset_bkCls;
            switch(param1)
            {
                case 0:
                {
                    this._obj = new Bitmap(new this.barCls(83,5));
                    break;
                }
                case 1:
                {
                    this._obj = new Bitmap(new this.btnCls(9,11));
                    this.buttonMode = true;
                    break;
                }
                case 2:
                {
                    this._obj = new Bitmap(new this.bkCls(104,33));
                    break;
                }
                default:
                {
                    break;
                }
            }
            this.addChild(this._obj);
            this.tabEnabled = false;
            return;
        }// end function

    }
}
