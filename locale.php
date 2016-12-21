<?php
$xml=file_get_contents('./locale.xml');
header('Content-Type:application/xml');
echo preg_replace("/(\\\\u?[0-9A-F]+)/ie","json_decode('\"\\1\"')",$xml);
