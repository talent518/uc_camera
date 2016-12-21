package com.comsenz.camera.v4.model.vo{
	import flash.display.*;

	public class Params extends Object {
		private var _root:DisplayObjectContainer;
		private var _nt:Boolean=false;
		private var _pArr:Object;
		private var _debug:Boolean=true;
		private var _baseURL="http://example.com/uc_camera";
		public static const UPLOAD:String="uploadavatar";
		private static var _instance:Params=new Params  ;
		public static const P_ROOT_HEIGHT:String="paramsRootHeight";
		public static const SAVE:String="rectavatar";
		public static const P_ROOT_WIDTH:String="paramsRootWidth";

		public function Params() {
			if (_instance) {
				throw new Error("Params can only be accessed through Params.getInstance()");
			}
			return;
		}// end function

		public function getLocaleFile():String {
			var _loc_1:* =this._debug?this._baseURL+"/camera.swf":this._root.loaderInfo.loaderURL;
			var _loc_2:* =_loc_1.match(/[^\\\/]+\.swf/)[0];
			var _loc_3:* =_loc_1.replace(_loc_2,"locale.xml");
			var _loc_4:* =(this.getParam("locale", false) || _loc_3) + "?" + Math.random();
			return _loc_4;
		}// end function

		public function getCrossDomainFile():String {
			var _loc_1:String=null;
			if (this._debug) {
				return this._baseURL+"/crossdomain.xml";
			}
			_loc_1=this._parseBasePath("ucapi");
			if (this._nt) {
				_loc_1 = _loc_1.substring(0, (_loc_1.lastIndexOf("/") + 1));
			}
			return _loc_1 + "crossdomain.xml";
		}// end function

		public function getActionParams(param1:String, param2:String = ""):String {
			var _loc_3:String=null;
			var _loc_4:String=null;
			var _loc_5:String=null;
			var _loc_6:String=null;
			var _loc_7:String=null;
			var _loc_8:String=null;
			var _loc_9:String=null;
			if (this._debug) {
				_loc_3=this._baseURL+"/avatar.php?a="+param1;
			} else {
				_loc_4=this._parseBasePath("ucapi");
				_loc_5="appid="+this.getParam("appid");
				_loc_6="input="+this.getParam("input");
				_loc_7="agent="+this.getParam("agent");
				_loc_8="avatartype="+this.getParam("avatartype");
				_loc_9 = this._nt ? ("") : ("index.php");
				_loc_3=_loc_4+_loc_9+"?m=user&inajax=1&a="+param1+"&"+_loc_5+"&"+_loc_6+"&"+_loc_7+"&"+_loc_8+param2;
			}
			return _loc_3;
		}// end function

		public function getParam(key:String, isEncode:Boolean = true):String {
			return isEncode?encodeURIComponent(this._pArr[key]):this._pArr[key];
		}// end function

		private function _parseBasePath(param1:String):String {
			var _loc_2:* =this.getParam(param1,false);
			if (_loc_2.length > 0 && _loc_2.substring((_loc_2.length - 1), _loc_2.length) != "/" && !this._nt) {
				_loc_2=_loc_2+"/";
			}
			if (_loc_2.length>0&&! new RegExp("^https?://","i").test(_loc_2)) {
				_loc_2="http://"+_loc_2;
			}
			return _loc_2;
		}// end function

		public function init(param1:DisplayObjectContainer):void {
			this._root=param1;
			var url:String=this._root.loaderInfo.loaderURL.toLowerCase();
			this._pArr=LoaderInfo(this._root.root.loaderInfo).parameters;
			this._pArr[P_ROOT_WIDTH]=this._root.stage.stageWidth;
			this._pArr[P_ROOT_HEIGHT]=this._root.stage.stageHeight;
			if(/^https?:\/\//.test(url)){
				this._debug=this._pArr.debug==1;
				this._baseURL=url.substring(0,url.lastIndexOf("/")+1);
			}else{
				this._debug=true;
			}
			this._nt=this._pArr.nt==1;
			return;
		}// end function

		public static function getInstance():Params {
			return _instance;
		}// end function

	}
}