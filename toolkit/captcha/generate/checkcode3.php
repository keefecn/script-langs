<?php
//生成验证码3: 汉字
//1.qi启用gd库GD库提供了一系列用来处理图片的API，使用GD库可以处理图片，或者生成图片。
// 在网站上GD库通常用来生成缩略图或者用来对图片加水印或者对网站数据生成报表。
session_start();
// 把GBK编码的字符串转换成UTF-8字符串，第一个参数之所以写GBK，是因为本php文件在主机中存储的编码是GBK编码
// UTF-8编码浏览器普遍支持，通用性强，这里就转换成UTF-8
$str = iconv("GBK", "utf-8", "芸芸众生绿水青山名胜古迹敞开心胸便会云蒸霞蔚快乐将永远伴随着你");
if (!is_string($str) || !mb_check_encoding($str,"utf-8"))
{
    exit("不是字符串或者不是utf-8");
}
$zhongwenku_size;
// 按UTF-8编码方式获取字符串的长度
$zhongwenku_size = mb_strlen($str,"UTF-8");
// 把上述字符导入数组中
$zhongwenku = array();
for ( $i=0; $i<$zhongwenku_size; $i++)
{
    $zhongwenku[$i] = mb_substr($str, $i,1,"UTF-8");
}
$result = "";
// 图片上要写入的四个字符
for ($i=0; $i<4; $i++)
{
    switch (rand(0, 1))
    {
    case 0:
        $result.=$zhongwenku[rand(0, $zhongwenku_size-1)];
        break;
    case 1:
        $result.=dechex(rand(0,15));
        break;
    }

}
$_SESSION["check_pic"] = $result;

// 创建一个真彩图片 宽100，高30
$img = imagecreatetruecolor(100, 30);
$bg = imagecolorallocate($img, 0, 0, 0);
$te = imagecolorallocate($img, 255,255,255);

// 在图片上写字符串
imagestring($img, rand(3,8), rand(1,70), rand(1,10), $result, $te);
// 在图片上根据载入字体可以写出特殊字体
imagettftext($img, 13, rand(2, 9), 20 ,20, $te, "MSYH.TTF",$result);
$_SESSION["check_pic"] = $result;
for ($i=0; $i<3; $i++)
{ // 画线
// $t = imagecolorallocate($img, rand(0, 255),rand(0, 255),rand(0, 255));
    imageline($img, 0, rand(0, 20), rand(70,100), rand(0, 20), $te);
}
$t = imagecolorallocate($img, rand(0, 255),rand(0, 255),rand(0, 255));
for ($i=0; $i<200; $i++)
{ // 为图片添加噪点
    imagesetpixel($img, rand(1, 100), rand(1, 30), $t);
}

// 输出图像
header("Content-type:image/jpeg");
imagejpeg($img);
?>
?>
