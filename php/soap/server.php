<?php
// PHP需要安装SOAP扩展，可用phpinfo()查看
// SiteInfo 类用于处理请求
Class SiteInfo
{
    /**
     *    返回网站名称
     *    @return string
     */
    public function getName() {
        return "getname";
    }
    public function getUrl() {
        return "www.runoob.com";
    }
}

// 创建 SoapServer 对象
$s = new SoapServer(null,array("location"=>"http://localhost/soap/Server.php","uri"=>"Server.php"));

// 导出 SiteInfo 类中的全部函数
$s->setClass("SiteInfo");
// 处理一个SOAP请求，调用必要的功能，并发送回一个响应。
$s->handle();
?>