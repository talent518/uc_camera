package com.comsenz.camera.v4.utils
{

    public class StringBuilder extends Object
    {
        private var data:String = "";

        public function StringBuilder(param1:String = null)
        {
            if (param1 != null)
            {
                this.append(param1);
            }
            return;
        }// end function

        public function get length() : uint
        {
            return this.data.length;
        }// end function

        public function append(param1:String) : void
        {
            this.data = this.data + param1;
            return;
        }// end function

        public function toString() : String
        {
            return this.data;
        }// end function

        public function set length(param1:uint) : void
        {
            return;
        }// end function

    }
}
