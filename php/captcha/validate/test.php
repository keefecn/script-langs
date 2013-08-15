<?php
//error_reporting(0);
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

// ok: 2534
// bad: 
$valite = new Valite();
//test1: locate image
$valite->setImage("5496.jpeg");
$valite->getHec();

//test2: remote image
//$valite->getRemoteImage();

//test3: login
$code = $valite->run();
$remote = "http://localhost/php/gen/login.php";
$post_str = 'check=$code';
//$data = request_by_curl($remote, $post_str);
//echo $data;

print_r($code);
//echo "\n";




?>
