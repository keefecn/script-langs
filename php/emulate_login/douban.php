<?php

function request_by_curl($remote_server, $post_string)
{
    // making string from $data: urlencode
    //foreach($post_data as $key=>$value)  
      //  $values[]="$key=".urlencode($value);
 
    $ch = curl_init();
    //curl_setopt($ch, CURLOPT_POST, 1);  
    //curl_setopt($ch, CURLOPT_HEADER, 0);
    curl_setopt($ch, CURLOPT_URL, $remote_server);
    curl_setopt($ch, CURLOPT_POSTFIELDS, $post_string);
    //为了支持cookie 
    curl_setopt($ch, CURLOPT_COOKIEJAR, 'cookie.txt');
    //curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
    //curl_setopt($ch, CURLOPT_USERAGENT, "Jimmy's CURL Example beta");
    $data = curl_exec($ch);
    curl_close($ch);
    return $data;
} 

$remote = "https://www.douban.com/accounts/login";
$post_str = "form_email=wuqifu@gmail.com&form_passwd=wqf363";
//curl -d "form_email=wuqifu@gmail.com&form_password=wqf363" https://www.douban.com/accounts/login
$data = request_by_curl($remote, $post_str);
echo $data;


?>
