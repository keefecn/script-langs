<?php
// 2017/9/1 writed by Keefe
// 查看：浏览器打开 http://localhost/soap/client.php
try {
    // non-wsdl方式调用web service
    // 创建 SoapClient 对象
    $soap = new SoapClient(null,array('location'=>"http://localhost/soap/Server.php",'uri'=>'Server.php'));
    // 调用函数
    $result1 = $soap->getName();
    $result2 = $soap->__soapCall("getUrl",array());
    echo $result1."<br/>";
    echo $result2;
} catch(SoapFault $e) {
    echo $e->getMessage();
} catch(Exception $e) {
    echo $e->getMessage();
}