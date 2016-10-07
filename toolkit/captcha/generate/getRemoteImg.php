<?php
// 获取远程图片验证码,各种图片格式
set_time_limit(0);//设置PHP超时时间
//$url = $_GET['url'];
//$url = "http://xyq.cbg.163.com/cgi-bin/create_validate_image.py?stamp=0.5179532546647087";
$url = "http://localhost/captcha/generate/checkcode.php";
if(empty($url)){
	echo "没有图片";
	die;
}
$imginfo = GetImageSize ( $url );   
$type = exif_imagetype($url);
$imgw = $imginfo [0];   
$imgh = $imginfo [1];
$bg = imagecreatetruecolor($imgw,$imgh);
if($type==IMAGETYPE_GIF){
	$image = imagecreatefromgif($url);
}elseif($type==IMAGETYPE_JPEG){
	$image = imagecreatefromjpeg($url);
}elseif($type==IMAGETYPE_PNG){
	$image = imagecreatefrompng($url);
}
 
imagecolorallocate($image,255,255,255);
imagecopy($bg,$image,0,0, 0,0,$imgw,$imgh); 
imagedestroy($image);

header("Content-type:image/jpeg");
imagejpeg($bg);
//header("Content-type:image/png");
//ImagePng($bg);

?>
