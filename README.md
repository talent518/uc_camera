# uc_camera
UCenter1.6头像上传破解版源码(uc_camera_v1.0)使用说明：
* 客户端Flash源码文件包括：
  * camera.fla => 主要包括图像和动画资源（AdobeFlash IDE Tools主项目文件）
  * CameraMain.as => Flash运行默认加载类
  * com => camera主包
  * gs	 => TweenLite10.092动画库
  * mx => flex的mx类库
  * org => AS3GIF类库和PureMVC框架
* 服务端源码文件包括：
  * avatar.php => 上传处理以保存到Web服务器端
  * camera.swf => flash动画客户端（浏览端执行）
  * locale.php => 把locale.xml显示为可见中文
  * locale.xml => 本地化语言（加载camera.swf时会从Web端读取）
  * crossdomain.xml => flash域安全配置（如上）
  * index.php => Web服务器端执行返回html页面以供浏览器解析加载camera.swf
* 编译swf与部署Web端：
  * 运行测试头像上传效果：把第2项的5个文件上传到Web端（须支持php），记住你放置的URL目录地址，下面要用到；
  * 编译与调试：camera.swf编译使用AdobeFlashCS4及以上版本打开camera.fla和CameraMain.as，并修改com\comsenz\camera\v4\model\vo\Params.as的第9行_baseURL属性的值为Web端的URL地址，并保存按Ctrl+Enter导出并运行camera.swf文件，即可上传头像与调试啦。
* 类库下载地址：
  * TweenLite10.092 => http://www.greensock.com/as/legacy/greensock-tweening-platform-v10-as3.zip
  * PureMVC => https://codeload.github.com/PureMVC/puremvc-as3-standard-framework/zip/master
  * as3gif => http://code.google.com/p/as3gif/

