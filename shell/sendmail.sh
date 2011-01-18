#! /bin/bash
# @brief: sendmail use mail/mailx/sendmail
# 1) mailx -s SUBJECT_CONTENT SEND_TO_EMAIL  
# 2) sendmail -t <<TAG
# To:someone@domain.com  
# From:your address  
# Subject: your subject  
# your email text 
# TAG
 
SENDER=/usr/sbin/sendmail
$SENDER -t <<ENDTAG
To:wuqifu@gmail.com 
From:No1@whitehouse.gov
Subject: welcome to the US  
Hello, Denny
        welcome to the US.
	President Obama is committed to creating the most open and accessible administration in American history. 
To send questions, comments, concerns, or well-wishes to the President or his staff, please use the form below.

Obama.
ENDTAG