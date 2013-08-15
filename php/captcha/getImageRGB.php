<?php
//打印出图形的RGB值.
//字模提取原理:字体可分为点陳和矢量.这里討論点陳,如果是汉字按照区位码.16位表示一个汉字.

// 十进制转化为十六进制dechex, 十->二 decbin
function dec2hex($dec)
{
    return strtoupper($dec>15?dechex($dec):('0'.dechex($dec)));
}

$rTotal=0;$gTotal=0;$bTotal=0;$total=0;
$i = imagecreatefromjpeg("ceshi.jpeg");
for ($x=0; $x<imagesx($i); $x++) {
    for ($y=0; $y<imagesy($i); $y++) {
        // get image point rgb 
        $rgb = imagecolorat($i,$x,$y);
        $r = ($rgb >> 16) & 0xFF;
        $g = ($rgb >> 8) & 0xFF;
        $b = $rgb & 0xFF;
//        echo decbin($r).decbin($g).decbin($b);
//        echo $r."\n";
        $rTotal += $r;
        $gTotal += $g;
        $bTotal += $b;
        $total++;
    }
}

$rAverage = round($rTotal/$total);
$gAverage = round($gTotal/$total);
$bAverage = round($bTotal/$total);
echo "point num = $total average rgb = {";
echo $rAverage."\t".$gAverage."\t".$bAverage."}";

?>

