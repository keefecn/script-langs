<?php
// post方法模拟登陆 
include ('Valite.php');
function request_by_curl($remote_server, $post_string)
{
    $ch = curl_init();
    curl_setopt($ch, CURLOPT_URL, $remote_server);
    curl_setopt($ch, CURLOPT_POSTFIELDS, 'mypost=' . $post_string);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
    curl_setopt($ch, CURLOPT_USERAGENT, "Jimmy's CURL Example beta");
    $data = curl_exec($ch);
    curl_close($ch);
    return $data;
} 

$valite = new Valite();
//test1: locate image
//$valite->setImage('2.bmp');
//$valite->getHec();

//test2: remote image
$valite->getRemoteImage();
$code = $valite->run();

//test3: login
$remote = "http://localhost/captcha/generate/login.php";
$checkcode = $code;
$post_str = 'check=$checkcode';
$data = request_by_curl($remote, $post_str);
echo $data;

print_r($code);
//echo "\n";




?>
