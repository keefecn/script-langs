<?php
// login qqmail
// curl -d "f=xhtmlmp&delegate_url=&f=xhtmlmp&action=&tfcont=&uin=123593090&aliastype=%40qq.com&pwd=wqf363wqf363&mss=1&mtk=&btlogin=%E7%99%BB%E5%BD%95" http://w.mail.qq.com/cgi-bin/login

header("Content-type:text/html;charset=utf-8");
$cookie_file = dirname(__FILE__)."/cookie_".md5(basename(__FILE__)).".txt"; // 设置Cookie文件保存路径及文件名

function vlogin($url,$data) { // 模拟登录获取Cookie函数
    $curl = curl_init(); // 启动一个CURL会话
    curl_setopt($curl, CURLOPT_URL, $url); // 要访问的地址
    curl_setopt($curl, CURLOPT_SSL_VERIFYPEER, 0); // 对认证证书来源的检查
    curl_setopt($curl, CURLOPT_SSL_VERIFYHOST, 1); // 从证书中检查SSL加密算法是否存在
    curl_setopt($curl, CURLOPT_USERAGENT, $_SERVER['HTTP_USER_AGENT']); // 模拟用户使用的浏览器
    curl_setopt($curl, CURLOPT_FOLLOWLOCATION, 1); // 使用自动跳转
    curl_setopt($curl, CURLOPT_AUTOREFERER, 1); // 自动设置Referer
    curl_setopt($curl, CURLOPT_POST, 1); // 发送一个常规的Post请求
    curl_setopt($curl, CURLOPT_POSTFIELDS, $data); // Post提交的数据包
    curl_setopt($curl, CURLOPT_COOKIEJAR, $GLOBALS['cookie_file']); // 存放Cookie信息的文件名称
    curl_setopt($curl, CURLOPT_COOKIEFILE, $GLOBALS['cookie_file']); // 读取上面所储存的Cookie信息
    curl_setopt($curl, CURLOPT_TIMEOUT, 30); // 设置超时限制防止死循环
    curl_setopt($curl, CURLOPT_HEADER, 0); // 显示返回的Header区域内容
    curl_setopt($curl, CURLOPT_RETURNTRANSFER, 1); // 获取的信息以文件流的形式返回
    $tmpInfo = curl_exec($curl); // 执行操作
    if (curl_errno($curl)) {
        echo 'Errno'.curl_error($curl);
    }
    curl_close($curl); // 关闭CURL会话
    return $tmpInfo; // 返回数据
}

function vget($url) { // 模拟获取内容函数
    $curl = curl_init(); // 启动一个CURL会话
    curl_setopt($curl, CURLOPT_URL, $url); // 要访问的地址
    curl_setopt($curl, CURLOPT_SSL_VERIFYPEER, 0); // 对认证证书来源的检查
    curl_setopt($curl, CURLOPT_SSL_VERIFYHOST, 1); // 从证书中检查SSL加密算法是否存在
    curl_setopt($curl, CURLOPT_USERAGENT, $_SERVER['HTTP_USER_AGENT']); // 模拟用户使用的浏览器
    curl_setopt($curl, CURLOPT_FOLLOWLOCATION, 1); // 使用自动跳转
    curl_setopt($curl, CURLOPT_AUTOREFERER, 1); // 自动设置Referer
    curl_setopt($curl, CURLOPT_HTTPGET, 1); // 发送一个常规的Post请求
    curl_setopt($curl, CURLOPT_COOKIEFILE, $GLOBALS['cookie_file']); // 读取上面所储存的Cookie信息
    curl_setopt($curl, CURLOPT_TIMEOUT, 30); // 设置超时限制防止死循环
    curl_setopt($curl, CURLOPT_HEADER, 0); // 显示返回的Header区域内容
    curl_setopt($curl, CURLOPT_RETURNTRANSFER, 1); // 获取的信息以文件流的形式返回
    $tmpInfo = curl_exec($curl); // 执行操作
    if (curl_errno($curl)) {
        echo 'Errno'.curl_error($curl);
    }
    curl_close($curl); // 关闭CURL会话
    return $tmpInfo; // 返回数据
}

function vpost($url,$data) { // 模拟提交数据函数
    $curl = curl_init(); // 启动一个CURL会话
    curl_setopt($curl, CURLOPT_URL, $url); // 要访问的地址
    curl_setopt($curl, CURLOPT_SSL_VERIFYPEER, 0); // 对认证证书来源的检查
    curl_setopt($curl, CURLOPT_SSL_VERIFYHOST, 1); // 从证书中检查SSL加密算法是否存在
    curl_setopt($curl, CURLOPT_USERAGENT, $_SERVER['HTTP_USER_AGENT']); // 模拟用户使用的浏览器
    curl_setopt($curl, CURLOPT_FOLLOWLOCATION, 1); // 使用自动跳转
    curl_setopt($curl, CURLOPT_AUTOREFERER, 1); // 自动设置Referer
    curl_setopt($curl, CURLOPT_POST, 1); // 发送一个常规的Post请求
    curl_setopt($curl, CURLOPT_POSTFIELDS, $data); // Post提交的数据包
    curl_setopt($curl, CURLOPT_COOKIEFILE, $GLOBALS['cookie_file']); // 读取上面所储存的Cookie信息
    curl_setopt($curl, CURLOPT_TIMEOUT, 30); // 设置超时限制防止死循环
    curl_setopt($curl, CURLOPT_HEADER, 0); // 显示返回的Header区域内容
    curl_setopt($curl, CURLOPT_RETURNTRANSFER, 1); // 获取的信息以文件流的形式返回
    $tmpInfo = curl_exec($curl); // 执行操作
    if (curl_errno($curl)) {
        echo 'Errno'.curl_error($curl);
    }
    curl_close($curl); // 关键CURL会话
    return $tmpInfo; // 返回数据
}

function delcookie($cookie_file) { // 删除Cookie函数
    @unlink($cookie_file); // 执行删除
}

function readcookies( $file)
{
    $result = null;

    $fp = fopen( $file, "r" );
    if ($fp)
    {
        while ( !feof( $fp ) )
        {
            $buffer = fgets( $fp, 4096 );
            $result = $buffer;
            //$tmp = @split( "/t", $buffer );
            //$result[@trim( $tmp[5] )] = @trim( $tmp[6] );
        }

        fclose($fp);
    }

    return $result;
}
$url = 'http://w.mail.qq.com/cgi-bin/loginpage?f=xhtml';
if (!file_exists($cookie_file)) { // 检测Cookie是否存在
    $str = vget($url); // 获取提交后台
    preg_match("/action=\"([^\"]*?)\"/isU",$str,$hash); // 提取登录随机值
    print_r($hash[1]);
    vlogin($hash[1],'&f=xhtml&uin=123593090&aliastype=@qq.com&pwd=wqf363wqf363&mss=1'); // 登录获取Cookie

}
else
{
    vget("http://w30.mail.qq.com/cgi-bin/today?sid=ggQq2H-cUHdDdHs0z6rT6vN8,4,z-yTNgDwU&first=1");
    echo '生成了cookie';
}
?>

