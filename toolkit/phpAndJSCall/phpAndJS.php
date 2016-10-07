<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title></title><script language="JavaScript" src="javascript.js"></script>
<script language="JavaScript">
function JSTest()
{
   var $tmp = "Hello, JS use the same file JS function";
   return $tmp;
}

function phpJSTest()
{

   document.write("Hello, php use the same file JS function");
}

var tmp = "php call the same file JS element";
 document.write("<br/><br/><br/><br/>");
 document.write("script---call---show :");
 document.write("<br/>");

 
 
//use the same file js function
 var x = JSTest();
 document.write(x);
 document.write("<br/>");
 
 
 //use same file php function
 var y = "<?php JSphpTest()?>";
 document.write(y);
 document.write("<br/>");
  
  
  //use another file's  JS function 
  var z = fileouter();
  document.write(z);
  document.write("<br/>");
  
</script>



<?php
  
  function phpTest()
  {
    echo "Hello, php use the same php  function";
  }
  
  function JSphpTest()
  {
    echo "Hello, JS use the same file php function";
  }
  
  
  include 'PHPcallOutfilePHP.php';
  
  
  echo "<br/><br/><br/><br/>";
  echo "php---call---show"."<br/>";

  
 
  //php call the same file php function
   $phpA = phpTest();
   echo "$phpA"."<br/>";
  
  
  //php use the  same file JS function
  $phpB = "<script> phpJSTest()</script>";
  echo "$phpB"."<br/>";

   
  //php use external file php function
   $phpC = phpcalloutfilephp();
   echo "$phpC"."<br/>";

?>

</head>
</html>






	