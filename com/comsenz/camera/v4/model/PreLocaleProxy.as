package com.comsenz.camera.v4.model
{
    import org.puremvc.as3.patterns.proxy.*;
	import org.puremvc.as3.interfaces.*;

    public class PreLocaleProxy extends Proxy implements IProxy
    {
        public static const NAME:String = "PreLocaleProxy";

        public function PreLocaleProxy(param1:Object = null)
        {
            super(NAME, param1);
            return;
        }// end function

    }
}
