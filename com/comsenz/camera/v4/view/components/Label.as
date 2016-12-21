package com.comsenz.camera.v4.view.components{
	import flash.display.*;
	import flash.text.*;
    import flash.events.*;

	public class Label extends Sprite {
		private var _format:TextFormat;
		private var _field:TextField;

		public function Label(param1:String, param2:uint = 12, param3:Number = 0, param4:Boolean = false, param5:Boolean = true) {
			this._format = new TextFormat();
			if (! param1.match(/<font(\s[^\n\r\f]*)*\scolor\=('|")#?[a-zA-Z0-9]+('|")[^\n\r\f]*>/)) {
				this._format.color=param3;
			}
			this._format.size=param2;
			this._format.bold=param4;
			this._field = new TextField();
			this.say(param1);
			this._field.setTextFormat(this._format);
			this._field.autoSize=TextFieldAutoSize.LEFT;
			this._field.selectable=false;
			if (param5) {
				this.addEventListener(MouseEvent.MOUSE_OVER, this.onMouseOver);
				this.addEventListener(MouseEvent.MOUSE_OUT, this.onMouseOut);
			}
			this.addChild(this._field);
			return;
		}// end function

		protected function onMouseOut(event:MouseEvent):void {
			Cursor.getInstance().show();
			return;
		}// end function

		protected function onMouseOver(event:MouseEvent):void {
			Cursor.getInstance().show(Cursor.HAND);
			return;
		}// end function

		public function say(param1:String):void {
			if (/^<font/.test(param1)) {
				this._field.htmlText=param1;
			} else {
				this._field.text=param1;
			}
			return;
		}// end function

		public function setTextAlign(param1:String):void {
			this._field.autoSize=param1;
			return;
		}// end function

	}
}