package 
{
    import com.comsenz.camera.v4.*;
    import flash.display.*;
    import flash.events.*;

    public class CameraMain extends Sprite
    {

        public function CameraMain() : void
        {
            if (stage)
            {
                this.init();
            }
            else
            {
                addEventListener(Event.ADDED_TO_STAGE, this.init);
            }
            return;
        }// end function

        private function init(event:Event = null) : void
        {
            removeEventListener(Event.ADDED_TO_STAGE, this.init);
            this.stage.scaleMode = "noScale";
            this._checkPlayer();
            return;
        }// end function

        private function _checkPlayer() : void
        {
            AppFacade.getInstance().startup(this);
            return;
        }// end function

    }
}
