<?php
//Use variables in mail function
//http://www.java2s.com/Code/Php/Email
$headers = "From:sender@java2s.com\r\n";
$address = "wuqifu@gmail.com,wuqifu@ihandy.cn";
$Subject = "All I want for Christmas";
$body = "great denny, do u good at and do more.";
$mailsend = mail("$address", "$Subject", "$body", "$headers");
print("$mailsend");
?>
      
