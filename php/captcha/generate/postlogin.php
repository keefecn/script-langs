<?php
// post方法模拟登陆 
include ('Valite.php');
function request_by_curl($remote_server, $post_string)
{
    $ch = curl_init();
//    curl_setopt($ch, CURLOPT_POST, 1);  
//    curl_setopt($ch, CURLOPT_HEADER, 0);
    curl_setopt($ch, CURLOPT_URL, $remote_server);
    curl_setopt($ch, CURLOPT_POSTFIELDS, $post_string);
    //为了支持cookie 
    curl_setopt($ch, CURLOPT_COOKIEJAR, 'cookie.txt');
//    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);

    $data = curl_exec($ch);
    curl_close($ch);
    return $data;
} 

$valite = new Valite();
//test1: locate image
//$valite->setImage('2.bmp');
//$valite->getHec();

//test2: remote image
$img_url = "http://localhost/captcha/generate/checkcode.php";
$valite->getRemoteImage($img_url);

//test: login
$code = $valite->run();
$remote = "http://localhost/captcha/generate/login.php";
$post_str = "check=$code";
// curl -d "check=000" http://localhost/captcha/generate/login.php
$data = request_by_curl($remote, $post_str);
echo $data;
echo $post_str;

//print_r($code);
//echo "\n";




?>
