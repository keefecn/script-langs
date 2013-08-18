<?php
//post方法模拟登陆手机qq
//验证成功.
// Date: 20130817
// curl -d "qq=123593090&pwd=xx&toQQchat=true&q_from=&modifySKey=0&loginType=1&aid=nLoginHandle" http://pt.3g.qq.com/handleLogin?aid=nLoginHandle&sid=ATAll43N7ZULRQ5V8zdfojol

function request_by_curl($remote_server, $post_string)
{
    $ch = curl_init();
    //curl_setopt($ch, CURLOPT_POST, 1);
    //curl_setopt($ch, CURLOPT_HEADER, 0);
    curl_setopt($ch, CURLOPT_URL, $remote_server);
    curl_setopt($ch, CURLOPT_POSTFIELDS, $post_string);
    //为了支持cookie
    //curl_setopt($ch, CURLOPT_COOKIEJAR, 'cookie.txt');
    //curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
    $data = curl_exec($ch);
    curl_close($ch);
    return $data;
}


$qqno='123593090';
$qqpw='xx';
$cookie = dirname(__FILE__).'/cookie.txt';
$post = array(
            //'login_url' => 'http://pt.3g.qq.com/s?sid=ATAll43N7ZULRQ5V8zdfojol&aid=nLogin',
            'q_from' => '',
            'loginTitle' => 'login',
            'bid' => '0',
            'qq' => $qqno,
            'pwd' => $qqpw,
            'loginType' => '1',
            'loginsubmit' => 'login',
        );

//method 1: ok
$remote="http://pt.3g.qq.com/handleLogin?aid=nLoginHandle&sid=ATAll43N7ZULRQ5V8zdfojol";
$post_str = http_build_query($post);
$data = request_by_curl($remote, $post_str);
echo $data;


//method 2: ok
/*
$curl = curl_init('http://pt.3g.qq.com/handleLogin?aid=nLoginHandle&sid=ATAll43N7ZULRQ5V8zdfojol');
curl_setopt($curl, CURLOPT_HEADER, 0);
curl_setopt($curl, CURLOPT_RETURNTRANSFER, 1);
curl_setopt($curl, CURLOPT_COOKIEJAR, $cookie); // ?Cookie
curl_setopt($curl, CURLOPT_POST, 1);
curl_setopt($curl, CURLOPT_POSTFIELDS, http_build_query($post));
$result = curl_exec($curl);
echo $result;
curl_close($curl);
*/

?>
