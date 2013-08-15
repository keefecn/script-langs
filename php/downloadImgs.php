<?php
/*
More & Original PHP Framwork
Copyright (c) 2007 - 2008 IsMole Inc.
Author: kimi
Documentation: 下载样式文件中的图片，水水专用扒皮工具
from: http://js8.in/586.html
*/

//note 设置PHP超时时间
set_time_limit(0);

//note 取得样式文件内容
$file = 'images/style.css';
$styleFileContent = file_get_contents($file);

//note 匹配出需要下载的URL地址
preg_match_all("/url\((.*)\)/", $styleFileContent, $imagesURLArray);

//note 循环需要下载的地址，逐个下载
$imagesURLArray = array_unique($imagesURLArray[1]);
foreach($imagesURLArray as $imagesURL) {
    file_put_contents(basename($imagesURL), file_get_contents($imagesURL));
}


?>
