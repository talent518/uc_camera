package com.comsenz.camera.v4.view.components.buttons
{
    import com.comsenz.camera.v4.model.vo.*;
    import com.comsenz.camera.v4.view.components.*;
	import flash.display.*;

    public class ReturnButton extends AbstractButton
    {
        private var btnCls:Class;

        public function ReturnButton(param1:uint)
        {
            this.btnCls = ReturnButton_btnCls;
            if (param1 == 1)
            {
                this.addChild(new Bitmap(new this.btnCls(104,33)));
                _label = new Label(LocaleObject.getInstance().getKey("button_return"), 12, 6710886, true);
                this.addChild(_label);
                _label.x = 19;
                _label.y = 7;
            }
            _addFilter();
            return;
        }// end function

    }
}
