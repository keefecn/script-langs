<?php
/*
* 生成图片验证码2: 
* NOte: 有bug需调试
* and open the template in the editor.
*/
session_start();
for ($i=0; $i<4; $i++) {
    $rand.=dechex(rand(1,15)); //生成4位数包含十六进制的随机数
}
//保存验证码到SESSION
$_SESSION[check_pic]=$rand;

$img=imagecreatetruecolor(100,30); //创建图片
$bg=imagecolorallocate($img,0,0,0); //第一次生成的是背景颜色
$fc=imagecolorallocate($img,255,255,255); //生成的字体颜色
//给图片画线
for ($i=0; $i<3; $i++) {
    $te=imagecolorallocate($img,rand(0,255),rand(0,255),rand(0,255));
    imageline($img,rand(0,15),0,100,30,$te);
}
//给图片画点
for ($i=0; $i<200; $i++) {
    $te=imagecolorallocate($img,rand(0,255),rand(0,255),rand(0,255));
    imagesetpixel($img,rand()%100,rand()%30,$te);
}
//首先要将文字转换成utf-8格式
//$str=iconv("gb2312","utf-8","呵呵呵");
//加入中文的验证
//smkai.ttf是一个字体文件，为了在别人的电脑中也能起到字体作用，把文件放到项目的根目录，可以下载，还有本机C:\WINDOWS\Fonts中有
imagettftext($img,11,10,20,20,$fc,"simkai.ttf","你好你好");
//把字符串写在图片中
imagestring($img,rand(1,6),rand(3,70),rand(3,16),$rand,$fc);

// 输出图像
header("Content-type:image/jpeg");
imagejpeg($img);
?>




