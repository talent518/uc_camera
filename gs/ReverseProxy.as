package gs{
	import flash.events.*;
	import flash.utils.*;
	
	class ReverseProxy extends Object {
		private var _tween:TweenLite;

		function ReverseProxy(param1:TweenLite) {
			this._tween=param1;
			return;
		}// end function

		public function reverseEase(param1:Number, param2:Number, param3:Number, param4:Number):Number {
			return this._tween.vars.ease(param4 - param1, param2, param3, param4);
		}// end function

	}

}