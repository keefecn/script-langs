<?php
/*
*前端页面加判断验证码是否相同
*login.php = form.php + post.php
*/
session_start();

if($_POST[check]) {
//判断验证码是否相同
    if($_POST[check]==$_SESSION[check_pic]) {
        echo "验证成功！";
    } else {
        echo "验证码错误";
    }
}
?>

<form action="login.php" method="POST">
用户名：<input type="text" name="user"/><br>
密码：<input type="password" name="pwd"/><br>
验证码：<input type="text" name="check"/><img src="checkcode.php"><br>
<input type="submit" value="submit"/>
</form>


