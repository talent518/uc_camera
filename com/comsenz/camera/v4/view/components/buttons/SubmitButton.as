package com.comsenz.camera.v4.view.components.buttons
{
    import com.comsenz.camera.v4.model.vo.*;
    import com.comsenz.camera.v4.view.components.*;
	import flash.display.*;

    public class SubmitButton extends AbstractButton
    {
        private var btnCls:Class;

        public function SubmitButton()
        {
            this.btnCls = SubmitButton_btnCls;
            this.addChild(new Bitmap(new this.btnCls(104,39)));
            _label = new Label(LocaleObject.getInstance().getKey("button_submit"), 12, 6710886, true);
            this.addChild(_label);
            _label.x = 50;
            _label.y = 11;
            _addFilter();
            return;
        }// end function

    }
}
