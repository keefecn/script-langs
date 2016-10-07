<?php
//用来判断验证码是否相同
session_start();

if ($_POST[check]) {
//判断验证码是否相同
    if ($_POST[check]==$_SESSION[check_pic]) {
        echo "验证成功！";
    } else {
        echo "验证码错误";
    }
}

?>
