<?php
/**
@author: denny
@date: 2011-8-23
@function: file_get_contents, curl, fopen/fread, fsockopen/fwrite
@library: 
    simple_html_dom.php 
    Snoopy.class.php  :fetch() fetchtext() fetchlinks() 
@note: 
**/

ini_set("max_execution_time", 2);

//brief:  download url
//note: file_get_contents/fopen need support allow_url_fopen, which set in php.ini
//	allow_url_fopen = On
// method 1: file_get_contents
$url = "http://www.phpzixue.cn";
$contents = file_get_contents($url);
// if messycode, use below
//$getcontent = iconv("gb2312", "utf-8",$contents);
echo $contents;


// method 2: curl
// note: curl need support curl library.
$url="http://www.google.cn/";
// create a new curl resource
$ch = curl_init();
// set URL and other appropriate options
curl_setopt($ch, CURLOPT_URL, $url);
curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
curl_setopt($ch, CURLOPT_TIMEOUT, 1);
// grab URL, and return output
$output = curl_exec($ch);
// close curl resource, and free up system resources
curl_close($ch);
// replace ‘Google’ with ‘PHPit’
$output = str_replace('Google', 'denny workshop', $output);
// print output
echo $output;


// method 3: fopen->fread->fclose
$url = "http://www.phpzixue.cn";
$handle = fopen ($url, "rb");
$contents = "";
do {
    $data = fread($handle, 1024);
    if (strlen($data) == 0) {
        break;
    }
    $contents .= $data;
} while (true);
fclose ($handle);
echo $contents;


//method 4: fsockopen
$fp = fsockopen("www.example.com", 80, $errno, $errstr, 30);
if (!$fp) {
    echo "$errstr ($errno)<br />\n";
} else {
    $out = "GET / HTTP/1.1\r\n";
    $out .= "Host: www.example.com\r\n";
    $out .= "Connection: Close\r\n\r\n";

    fwrite($fp, $out);
    while (!feof($fp)) {
        echo fgets($fp, 128);
    }
    fclose($fp);
}

/**
@name: zhoz_get_contents
@date: 2011-8-11
**/
function curl_get_content($url, $second = 5) {         
    $ch = curl_init();         
    curl_setopt($ch, CURLOPT_URL, $url);         
    curl_setopt($ch, CURLOPT_HEADER, 0);         
    curl_setopt($ch, CURLOPT_TIMEOUT, $second);         
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);         
    
    $content = curl_exec($ch);         
    curl_close($ch);         
    return $content;         
} 

/**
* file_get_contents方式获取远程文件
* @param $url 可以是带参数的url
* @param $timeout 设置超时
* @param $params 参数字符串,如a=2&b=3,通常用http_build_query生成
* @param $method 'GET','POST','' 为空等表示不对参数处理
* @param $times
* @return string|boolean
**/
function get_remote_file($url = '', $timeout = 10, $params = '', $method = 'GET', $times = 3) {
    //提交方式
    $method =   strtoupper($method);
    //基本选项
    $opts['http'] = array(
                        'method'=>$method,
                        'timeout'=>$timeout,//设置超时时间(秒)
                    );

    //判断参数提交方式
    if(!empty($params)) {
        if('POST' == $method) {
            $opts['http']['content']    =   $params;
        }
        elseif('GET' == $method) {
            $url.= ((false === strpos($url, '?'))?'?':'&').$params;
        }
    }
    $context = stream_context_create($opts);
    $cnt = 0;
    $file = false;
    //尝试$times次获取远程文件
    while($cnt < $times && ($file = file_get_contents($url, false, $context)) === false)$cnt++;

    return $file;
}


?>
