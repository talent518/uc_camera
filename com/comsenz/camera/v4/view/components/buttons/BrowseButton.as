package com.comsenz.camera.v4.view.components.buttons
{
    import com.comsenz.camera.v4.model.vo.*;
    import com.comsenz.camera.v4.view.components.*;
	import flash.display.*;

    public class BrowseButton extends AbstractBorderButton
    {
        private var btnCls:Class;

        public function BrowseButton()
        {
            this.btnCls = BrowseButton_btnCls;
            this.addChild(new Bitmap(new this.btnCls(172,45)));
            _label = new Label(LocaleObject.getInstance().getKey("button_browse"), 16, 6710886, true);
            this.addChild(_label);
            _label.x = 57;
            _label.y = 12;
            _addFilter();
            return;
        }// end function

    }
}
