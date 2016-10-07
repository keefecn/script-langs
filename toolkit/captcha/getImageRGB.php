<?php
/**
@brief: get image RGB value
@author: denny
@date: 2013-08-28
**/

/* Report all errors except E_NOTICE */
error_reporting(E_ALL^E_NOTICE);

//打印出图形的RGB值.
//字模提取原理:字体可分为点陳和矢量.这里討論点陳,如果是汉字按照区位码.16位表示一个汉字?. 二值化提取.

// 十进制转化为十六进制dechex, 十->二 decbin
function dec2hex($dec)
{
    return strtoupper($dec>15?dechex($dec):('0'.dechex($dec)));
}

$font_color = array('r' => 180, 'g' => 150, 'b' => 256);
//$black = imagecolorallocate($im2, 0, 0, 0);
//$white = imagecolorallocate($im2, 255, 255, 255);


$m255=210; //二值化处理的分母值
$rTotal=0;
$gTotal=0;
$bTotal=0;
$total=0;
$imgName = "captcha_breaker1/letters/1.png";
$img = imagecreatefrompng($imgName);
//$img = imagecreatefromjpeg($imgName);
$size = getimagesize($imgName);
print_r($size);
$data = array();
for ($x=0; $x<imagesx($img); $x++) {
    for ($y=0; $y<imagesy($img); $y++) {
        // get image point rgb
        $rgbarray = imagecolorat($img, $x, $y);
        $r = ($rgbarray >> 16) & 0xFF;
        $g = ($rgbarray >> 8) & 0xFF;
        $b = $rgbarray & 0xFF;
        //$r= $rgbarray['red'] ;
        //$g= $rgbarray['green'] ;
        //$b= $rgbarray['blue'] ;
        $t= round(($r+$g+$b)*0.333 /$m255);
        //print_r($rgbarray);
        //die();
        //退色,二值化
        if ($t==0)
        {
            $data[$i][$j]=1;
        } else {
            $data[$i][$j]=0;
        }
        $rTotal += $r;
        $gTotal += $g;
        $bTotal += $b;
        $total++;
    }// end for 2
} // end for 1

print_r($data);
$rAverage = round($rTotal/$total);
$gAverage = round($gTotal/$total);
$bAverage = round($bTotal/$total);
echo "point num = $total average rgb = {";
echo $rAverage."\t".$gAverage."\t".$bAverage."}";

?>

