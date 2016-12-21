package com.comsenz.camera.v4.view
{
    import com.comsenz.camera.v4.*;
    import com.comsenz.camera.v4.model.vo.*;
    import com.comsenz.camera.v4.utils.*;
    import com.comsenz.camera.v4.view.components.*;
    import com.comsenz.camera.v4.view.components.buttons.*;
    import com.comsenz.camera.v4.view.components.slider.*;
    import flash.display.*;
    import flash.events.*;
    import flash.filters.*;
    import flash.geom.*;
    import flash.utils.*;
    import org.puremvc.as3.interfaces.*;
    import org.puremvc.as3.patterns.mediator.*;

    public class ModePicPaneMediator extends Mediator implements IMediator
    {
        private var _slider:Slider;
        private var _root:CameraMain;
        private var _submitMask:SubmitMask;
        private var _visibleGroup:Array;
        private var _returnBtn:ReturnButton;
        private var _drawer:PicDrawer;
        private var _submitBtn:SubmitButton;
        private var _bk:DisplayObject;
        private var _camBtn:CamButton;
        private var _preUploader:PreUploader;
        private var _browseBtn:BrowseButton;
        public static const NAME:String = "ModePicPaneMediator";

        public function ModePicPaneMediator(param1:Object)
        {
            super(NAME, param1);
            this._bk = new Bitmap(new LatticeBack(Constants.VALID_WIDTH, Constants.VALID_HEIGHT));
			this._bk.x=10;
			this._bk.y=10;
			this._bk.width=430;
			this._bk.height=233;
            this.pane.addChild(this._bk);
            this._browseBtn = new BrowseButton();
            this._browseBtn.x = 146;
            this._browseBtn.y = 69;
            this._browseBtn.addEventListener(MouseEvent.CLICK, this.onBrowse);
            this.pane.addChild(this._browseBtn);
            this._camBtn = new CamButton();
            this._camBtn.x = 146;
            this._camBtn.y = 139;
            if (CameraUtil.getCamera())
            {
                this._camBtn.addEventListener(MouseEvent.CLICK, this.onCam);
            }
            else
            {
                this._camBtn.alpha = 0.5;
                this._camBtn.filters = [new ColorMatrixFilter([0.3086, 0.6094, 0.082, 0, 0, 0.3086, 0.6094, 0.082, 0, 0, 0.3086, 0.6094, 0.082, 0, 0, 0, 0, 0, 1, 0])];
            }
            this.pane.addChild(this._camBtn);
            this._preUploader = new PreUploader();
            this._preUploader.x = 130;
            this._preUploader.y = 70;
            this._preUploader.alpha = 0.55;
            facade.registerMediator(new PreUploaderMediator(this._preUploader));
            this.pane.addChild(this._preUploader);
            this._drawer = new PicDrawer(this.pane, this._root, Constants.PHOTO_WIDTH, Constants.PHOTO_HEIGHT);
            this._drawer.x = 12;
            this._drawer.y = 14;
            facade.registerMediator(new PicDrawerMediator(this._drawer));
            this.pane.addChild(this._drawer);
            this._returnBtn = new ReturnButton(1);
            this._returnBtn.x = 332;
            this._returnBtn.y = 14;
            this._returnBtn.addEventListener(MouseEvent.CLICK, this.onReturn);
            this.pane.addChild(this._returnBtn);
            this._submitBtn = new SubmitButton();
            this._submitBtn.x = 332;
            this._submitBtn.y = 199;
            this._submitBtn.addEventListener(MouseEvent.CLICK, this.onSubmit);
            this.pane.addChild(this._submitBtn);
            this._slider = new Slider(this.pane, 83, 332, 147);
            facade.registerMediator(new SliderMediator(this._slider));
            this.pane.addChild(this._slider);
            this._submitMask = new SubmitMask();
            this._submitMask.visible = false;
            this._submitMask.buttonMode = true;
            this.pane.addChild(this._submitMask);
            this._visibleGroup = [];
            this._visibleGroup.push([this._bk, this._browseBtn, this._camBtn]);
            this._visibleGroup.push([this._bk, this._preUploader]);
            this._visibleGroup.push([this._drawer, this._returnBtn, this._submitBtn, this._slider]);
            this._toggleVisible(0);
            return;
        }// end function

        private function onBrowse(event:MouseEvent) : void
        {
            this._preUploader.browse();
            return;
        }// end function

        override public function handleNotification(param1:INotification) : void
        {
            var picInfo:Array;
            var sValue:Number;
            var note:* = param1;
            switch(note.getName())
            {
                case BasePaneMediator.MODE_CHANGE:
                {
                    if (note.getBody() as uint == BasePaneMediator.MODE_IDX_UPLOAD)
                    {
                        this._toggleVisible(0);
                        if (this._submitMask.visible)
                        {
                            this._submitMask.visible = false;
                        }
                    }
                    break;
                }
                case NotiNames.SELECT_WHEN_PRELOADER:
                {
                    this._toggleVisible(1);
                    break;
                }
                case NotiNames.ERR_WHEN_PRELOADER:
                {
                    this._toggleVisible(0);
                    break;
                }
                case NotiNames.PREUPLOAD_COMPLETE:
                {
                    picInfo = note.getBody() as Array;
                    this._drawer.importData(picInfo[0], picInfo[1]);
                    this._toggleVisible(2);
                    break;
                }
                case NotiNames.SLIDER_VALUE_CHANGE:
                {
                    sValue = note.getBody() as Number;
                    this._drawer.zoom(sValue);
                    break;
                }
                case NotiNames.GIF_FRAMES_OVERFLOW:
                {
                    sendNotification(NotiNames.SENT_ERROR_MSG, LocaleObject.getInstance().getKey("gif_frame_overflow"));
                    setTimeout(function () : void
            {
                sendNotification(BasePaneMediator.MODE_CHANGE, BasePaneMediator.MODE_IDX_UPLOAD);
                return;
            }// end function
            , 2300);
                    this._submitMask.visible = true;
                    break;
                }
                default:
                {
                    break;
                    break;
                }
            }
            return;
        }// end function

        private function onSubmit(event:MouseEvent) : void
        {
            this._submitMask.visible = true;
            sendNotification(NotiNames.APP_SUBMIT_DATA);
            return;
        }// end function

        override public function listNotificationInterests() : Array
        {
            return [BasePaneMediator.MODE_CHANGE, NotiNames.SELECT_WHEN_PRELOADER, NotiNames.ERR_WHEN_PRELOADER, NotiNames.PREUPLOAD_COMPLETE, NotiNames.SLIDER_VALUE_CHANGE, NotiNames.GIF_FRAMES_OVERFLOW];
        }// end function

        public function get pane() : ModePicPane
        {
            return viewComponent as ModePicPane;
        }// end function

        private function onCam(event:MouseEvent) : void
        {
            sendNotification(BasePaneMediator.MODE_CHANGE, BasePaneMediator.MODE_IDX_CAMERA);
            return;
        }// end function

        private function onReturn(event:MouseEvent) : void
        {
            this._toggleVisible(0);
            return;
        }// end function

        private function _toggleVisible(param1:int) : void
        {
            var _loc_3:DisplayObject = null;
            var _loc_4:DisplayObject = null;
            var _loc_2:uint = 0;
            while (_loc_2 < this._visibleGroup.length)
            {
                
                if (_loc_2 == param1)
                {
                    for each (_loc_3 in this._visibleGroup[_loc_2])
                    {
                        
                        _loc_3.visible = true;
                    }
                }
                else
                {
                    for each (_loc_4 in this._visibleGroup[_loc_2])
                    {
                        
                        if (this._visibleGroup[param1].indexOf(_loc_4) == -1)
                        {
                            _loc_4.visible = false;
                        }
                    }
                }
                _loc_2 = _loc_2 + 1;
            }
            return;
        }// end function

    }
}
