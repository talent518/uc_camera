package com.comsenz.camera.v4.utils
{

    public class XMLReader extends URLReader
    {

        public function XMLReader()
        {
            return;
        }// end function

        public function get xml() : XMLList
        {
            return XMLList(loader.data);
        }// end function

    }
}
