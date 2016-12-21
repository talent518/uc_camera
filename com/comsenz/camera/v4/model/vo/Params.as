package com.comsenz.camera.v4.model.vo{
	import flash.display.*;

	public class Params extends Object {
		private var _root:DisplayObjectContainer;
		private var _pArr:Object;
		private var _debug:Boolean=true;
		private var _baseURL:String="http://127.0.0.1/uc_camera/";
		private var _action:String="a";
		public static const UPLOAD:String="uploadavatar";
		private static var _instance:Params=new Params;
		public static const P_ROOT_HEIGHT:String="paramsRootHeight";
		public static const SAVE:String="rectavatar";
		public static const P_ROOT_WIDTH:String="paramsRootWidth";

		public function Params() {
			if (_instance) {
				throw new Error("Params can only be accessed through Params.getInstance()");
			}
		}// end function

		public function getLocaleFile():String {
			if(this._debug) {
				return this._baseURL + "locale.xml?" + Math.random();
			}

			var _url:* = this.getParam("locale", false);
			if(_url) {
				return (/^https?:\/\//.test(_url) ? "" : this._baseURL) + _url + (_url.indexOf("?") == -1 ? "?rnd=" : "&rnd=") + Math.random();
			}

			_url = this._root.loaderInfo.loaderURL;
			return _url.substring(0, _url.lastIndexOf("/") + 1) + "locale.xml?" + Math.random();
		}// end function

		public function getCrossDomainFile():String {
			return this._baseURL+"crossdomain.xml";
		}// end function

		public function getActionParams(param1:String):String {
			if(this._debug) {
				return _baseURL + "avatar.php?" + this._action + "=" + param1;
			}

			var _url:* = this.getParam("uploadUrl", false);

			return (/^https?:\/\//.test(_url) ? "" : this._baseURL) + _url + (_url.indexOf("?") == -1 ? "?" : "&") + this._action + "=" + param1;
		}// end function

		public function getParam(key:String, isEncode:Boolean = true):String {
			return isEncode?encodeURIComponent(this._pArr[key]):this._pArr[key];
		}// end function

		public function init(param1:DisplayObjectContainer):void {
			this._root=param1;
			var _url:String=this._root.loaderInfo.loaderURL.toLowerCase();
			this._pArr=LoaderInfo(this._root.root.loaderInfo).parameters;
			this._pArr[P_ROOT_WIDTH]=this._root.stage.stageWidth;
			this._pArr[P_ROOT_HEIGHT]=this._root.stage.stageHeight;
			if(/^https?:\/\//.test(_url)){
				this._baseURL=(this._pArr["baseUrl"] ? this._pArr["baseUrl"] : _url.substring(0, _url.lastIndexOf("/") + 1));
				if(this._pArr["action"]) {
					this._action = encodeURIComponent(this._pArr["action"]);
				}
			}else{
				this._debug=true;
			}
		}// end function

		public static function getInstance():Params {
			return _instance;
		}// end function

	}
}