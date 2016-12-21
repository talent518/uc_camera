package com.comsenz.camera.v4.model.vo
{
    import flash.utils.*;

    public class LocaleObject extends Object
    {
        private var _data:Dictionary;
        private static var _instance:LocaleObject = new LocaleObject;

        public function LocaleObject()
        {
            if (_instance)
            {
                throw new Error("LocaleObject can only be accessed through LocaleObject.getInstance().");
            }
            return;
        }// end function

        public function getKey(param1:String) : String
        {
            return this._data[param1];
        }// end function

        public function fillData(param1:Dictionary) : void
        {
            this._data = param1;
            return;
        }// end function

        public static function getInstance() : LocaleObject
        {
            return _instance;
        }// end function

    }
}
