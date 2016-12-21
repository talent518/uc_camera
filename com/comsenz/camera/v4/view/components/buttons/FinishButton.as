package com.comsenz.camera.v4.view.components.buttons
{
    import com.comsenz.camera.v4.model.vo.*;
    import com.comsenz.camera.v4.view.components.*;
	import flash.display.*;

    public class FinishButton extends AbstractButton
    {
        private var btnCls:Class;

        public function FinishButton()
        {
            this.btnCls = FinishButton_btnCls;
            this.addChild(new Bitmap(new this.btnCls(92,33)));
            _label = new Label(LocaleObject.getInstance().getKey("button_finish"), 14, 6710886, true);
            this.addChild(_label);
            _label.x = 15;
            _label.y = 6;
            _addFilter();
            return;
        }// end function

    }
}
