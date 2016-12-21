<?php

define('DEBUG',0);
define('ROOT',dirname(__FILE__));
define('URL','http://'.$_SERVER['HTTP_HOST'].dirname($_SERVER['SCRIPT_NAME']?$_SERVER['SCRIPT_NAME']:$_SERVER['REQUEST_URI']));

if(DEBUG){
	ob_start();

	var_dump($_SERVER,$_FILES);
	echo "\r\n\r\n",URL;
}

function flashdata_decode($s) {
	$r = '';
	$l = strlen($s);
	for($i=0; $i<$l; $i=$i+2) {
		$k1 = ord($s[$i]) - 48;
		$k1 -= $k1 > 9 ? 7 : 0;
		$k2 = ord($s[$i+1]) - 48;
		$k2 -= $k2 > 9 ? 7 : 0;
		$r .= chr($k1 << 4 | $k2);
	}
	return $r;
}

function onuploadavatar() {
	@header("Expires: 0");
	@header("Cache-Control: private, post-check=0, pre-check=0, max-age=0", FALSE);
	@header("Pragma: no-cache");
	//header("Content-type: application/xml; charset=utf-8");

	if(empty($_FILES['Filedata'])) {
		return -3;
	}

	list($width, $height, $type, $attr) = getimagesize($_FILES['Filedata']['tmp_name']);
	$imgtype = array(1 => '.gif', 2 => '.jpg', 3 => '.png');
	$filetype = $imgtype[$type];
	$tmpavatar = ROOT.'/tmp_avatar'.$filetype;
	file_exists($tmpavatar) && @unlink($tmpavatar);
	if(@copy($_FILES['Filedata']['tmp_name'], $tmpavatar) || @move_uploaded_file($_FILES['Filedata']['tmp_name'], $tmpavatar)) {
		@unlink($_FILES['Filedata']['tmp_name']);
		list($width, $height, $type, $attr) = getimagesize($tmpavatar);
		if($width < 10 || $height < 10 || $type == 4) {
			@unlink($tmpavatar);
			return -2;
		}
	} else {
		@unlink($_FILES['Filedata']['tmp_name']);
		return -4;
	}
	$avatarurl = URL.'/tmp_avatar'.$filetype;
	return $avatarurl;
}

function onrectavatar() {
	@header("Expires: 0");
	@header("Cache-Control: private, post-check=0, pre-check=0, max-age=0", FALSE);
	@header("Pragma: no-cache");
	header("Content-type: application/xml; charset=utf-8");

	$bigavatarfile = ROOT.'/avatar_big.jpg';
	$middleavatarfile = ROOT.'/avatar_middle.jpg';
	$smallavatarfile = ROOT.'/avatar_small.jpg';
	$bigavatar = flashdata_decode($_POST['avatar1']);
	$middleavatar = flashdata_decode($_POST['avatar2']);
	$smallavatar = flashdata_decode($_POST['avatar3']);
	if(!$bigavatar || !$middleavatar || !$smallavatar) {
		return '<?xml version="1.0" ?><root><message type="error" value="-2" /></root>';
	}

	$success = 1;
	$fp = @fopen($bigavatarfile, 'wb');
	@fwrite($fp, $bigavatar);
	@fclose($fp);

	$fp = @fopen($middleavatarfile, 'wb');
	@fwrite($fp, $middleavatar);
	@fclose($fp);

	$fp = @fopen($smallavatarfile, 'wb');
	@fwrite($fp, $smallavatar);
	@fclose($fp);

	$biginfo = @getimagesize($bigavatarfile);
	$middleinfo = @getimagesize($middleavatarfile);
	$smallinfo = @getimagesize($smallavatarfile);
	if(!$biginfo || !$middleinfo || !$smallinfo || $biginfo[2] == 4 || $middleinfo[2] == 4 || $smallinfo[2] == 4) {
		file_exists($bigavatarfile) && unlink($bigavatarfile);
		file_exists($middleavatarfile) && unlink($middleavatarfile);
		file_exists($smallavatarfile) && unlink($smallavatarfile);
		$success = 0;
	}

	foreach(array('.gif','.jpg','.png') as $filetype)
		@unlink(ROOT.'/tmp_avatar'.$filetype);

	if($success) {
		return '<?xml version="1.0" ?><root><face success="1"/></root>';
	} else {
		return '<?xml version="1.0" ?><root><face success="0"/></root>';
	}
}

$callback='on'.$_GET['a'];

if(DEBUG){
	echo "\r\n\r\n",$callback;

	file_put_contents('log.txt',ob_get_contents());
	ob_end_clean();
}

if(function_exists($callback))
	echo $callback();
exit;
