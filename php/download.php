<?php    
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
// grab URL, and return output  
$output = curl_exec($ch);  
// close curl resource, and free up system resources  
curl_close($ch);  
// replace ¡®Google¡¯ with ¡®PHPit¡¯  
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
} while(true); 
fclose ($handle); 
echo $contents;  

?>    
