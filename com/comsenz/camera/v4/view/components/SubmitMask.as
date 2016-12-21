package com.comsenz.camera.v4.view.components
{
    import com.comsenz.camera.v4.utils.*;
    import flash.display.*;

    public class SubmitMask extends Sprite
    {

        public function SubmitMask()
        {
            this.addChild(BasicGeom.drawRectSprite(0, 0.5, 0, 0, Constants.APP_WIDTH, Constants.APP_HEIGHT));
            return;
        }// end function

    }
}
