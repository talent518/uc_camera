package com.comsenz.camera.v4.model
{
    import com.comsenz.camera.v4.model.vo.*;
    import flash.display.*;
    import org.puremvc.as3.patterns.proxy.*;
	import org.puremvc.as3.interfaces.*;

    public class ParamsProxy extends Proxy implements IProxy
    {
        public static const NAME:String = "ParamsProxy";

        public function ParamsProxy(param1:Params)
        {
            super(NAME, param1);
            return;
        }// end function

        public function init(param1:DisplayObjectContainer) : void
        {
            this.params.init(param1);
            return;
        }// end function

        public function getActionParams(param1:String, param2:String = "") : String
        {
            return this.params.getActionParams(param1, param2);
        }// end function

        public function get params() : Params
        {
            return data as Params;
        }// end function

        public function getParam(param1:String, param2:Boolean = true) : String
        {
            return this.params.getParam(param1, param2);
        }// end function

        public function getCrossDomainFile() : String
        {
            return this.params.getCrossDomainFile();
        }// end function

        public function getLocaleFile() : String
        {
            return this.params.getLocaleFile();
        }// end function

    }
}
