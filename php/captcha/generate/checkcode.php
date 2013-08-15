<?php
//生成图片验证码 1
//主要步骤: 生成随机数;设置图片大小颜色;写字符串;加干扰项(画线,画点,旋转等)
session_start();
for ($i=0; $i<4; $i++) {
    $rand.= dechex(rand(1,15));
}
$_SESSION[check_pic]=$rand;

//echo $_SESSION[check_pic];
// 设置图片大小
$img = imagecreatetruecolor(100,30);
// 设置颜色: 背景色,字体色
$bg=imagecolorallocate($img,0,0,0);
$fc=imagecolorallocate($img,255,255,255);
// 把字符串写在图像左上角
imagestring($img,rand(5,6),rand(25,30),5,$rand,$fc);
//imagestring($img,rand(1,6),rand(3,70),rand(3,16),$rand,$fc);

//加入干扰象素, 非必需
for($i=0;$i<100;$i++) 
{
    $randcolor = ImageColorallocate($img,rand(0,255),rand(0,255),rand(0,255));
//    imagesetpixel($img, rand()%70 , rand()%30 , $randcolor); // 画像素点函数
}

// 输出图像
header("Content-type:image/jpeg");
imagejpeg($img);
?>
