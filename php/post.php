<?php 
/**
@beief: PHP POST数据的三种方法: 分别为Curl、socket、file_get_contents:
@author: denny
@date: 2013-08-28
@note: 
**/

/**
 * Socket版本
 * 使用方法：
 * $post_string = "app=socket&version=beta";
 * request_by_socket('facebook.cn','/restServer.php',$post_string);
 */
function request_by_socket($remote_server, $remote_path, $post_string, $port = 80, $timeout = 30)
{
    $socket = fsockopen($remote_server, $port, $errno, $errstr, $timeout);
    if (!$socket) die("$errstr($errno)");

    fwrite($socket, "POST $remote_path HTTP/1.0\r\n");
    fwrite($socket, "User-Agent: Socket Example\r\n");
    fwrite($socket, "HOST: $remote_server\r\n");
    fwrite($socket, "Content-type: application/x-www-form-urlencoded\r\n");
    fwrite($socket, "Content-length: " . (strlen($post_string) + 8) . '\r\n');
    fwrite($socket, "Accept:*/*\r\n");
    fwrite($socket, "\r\n");
    fwrite($socket, "mypost=$post_string\r\n");
    fwrite($socket, "\r\n");
    $header = "";
    while ($str = trim(fgets($socket, 4096))) {
        $header .= $str;
    } 
    $data = "";
    while (!feof($socket)) {
        $data .= fgets($socket, 4096);
    } 
    return $data;
} 



/**
 * Curl版本
 * 使用方法：
 * $post_string = "app=request&version=beta";
 * request_by_curl('http://facebook.cn/restServer.php',$post_string);
 * http_build_query(ARRAY)
 */
function request_by_curl($remote_server, $post_string)
{
    // making string from $data: urlencode, string -> http_build_query(ARRAY)
    //$posts = "";
    //foreach($post_data as $key=>$value)  
       // $posts.="$key=".urlencode($value)."&";
 
    $ch = curl_init();
    //curl_setopt($ch, CURLOPT_POST, 1);  
    //curl_setopt($ch, CURLOPT_HEADER, 0);
    curl_setopt($ch, CURLOPT_URL, $remote_server);
    curl_setopt($ch, CURLOPT_POSTFIELDS, $post_string); //
    //curl_setopt($curl, CURLOPT_POSTFIELDS, http_build_query($post));  //$post=array
    //为了支持cookie 
    curl_setopt($ch, CURLOPT_COOKIEJAR, 'cookie.txt');
    //curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
    $data = curl_exec($ch);
    curl_close($ch);
    return $data;
} 


/**
 * 其它版本
 * 使用方法：
 * $post_string = "app=request&version=beta";
 * request_by_other('http://facebook.cn/restServer.php',$post_string);
 */
function request_by_other($remote_server, $post_string)
{
    $context = array(
        'http' => array(
            'method' => 'POST',
            'header' => 'Content-type: application/x-www-form-urlencoded' .
                        '\r\n'.'User-Agent : Jimmy\'s POST Example beta' .
                        '\r\n'.'Content-length:' . strlen($post_string) + 8,
            'content' => 'mypost=' . $post_string)
        );
    $stream_context = stream_context_create($context);
    $data = file_get_contents($remote_server, false, $stream_context);
    return $data;
} 

?>
