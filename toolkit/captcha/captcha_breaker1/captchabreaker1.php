<?php

function breakcaptcha($url) {

    $im  = imagecreatefrompng('http://'.$url);
    
    $start_x = 26;
    $start_y = 7;

    //图片(字模)的宽高
    $letter_w = 9;
    $letter_h = 10;

    //验证码中数字个数
    $letter_num = 5;

    // $pos: file array
    $pos = array();
    if ($handle = opendir('letters/')) {

        while (false !== ($file = readdir($handle))) {

            if (substr($file,strlen($file)-4,4) == '.png') {

                $file = str_replace('.png','',$file);
                array_push($pos,$file);
            }
        }

        closedir($handle);
    }

    $code = '';


    for ($i = 0; $i < $letter_num; $i ++) {

    	$img = imagecreatetruecolor ($letter_w,$letter_h);
	    imagecopy($img,$im,0,0,($start_x+($letter_w*$i)),$start_y,$letter_w,$letter_h); 
        imagepng($img,'tmp/'.$i.'.png');
        imagedestroy($img);
	
	    $filename = 'tmp/'.$i.'.png';
	    $handle = fopen($filename, "r");
	    $contents = fread($handle, filesize($filename));
	    fclose($handle);

	    for($a = 0; $a < count($pos); $a++) {
				
            $filename = 'letters/'.$pos[$a].'.png';
		    $handle = fopen($filename, "r");
		    $contents2 = fread($handle, filesize($filename));
		    fclose($handle);

            // == compare pixel 
		    if ($contents2==$contents) {
		
                if ($pos[$a] == 'dot') {
                    $code .= '.';
			    }
			    else {			
				    $code .= $pos[$a];
			    }
			    $a = count($pos)+2;
		
		    }
		
		    elseif ($a == (count($pos)-1)) {

                @copy('tmp/'.$i.'.png','unknown/'.rand(0,10000000).'.png');
                $code .= '?';			

		    }
        }	
    }

    return $code;

}
      ///test: 932e6
      $code = breakcaptcha('captcha-breaker.googlecode.com/files/captcha1.png');    
      //$code = breakcaptcha('localhost/validate/90849.png');
      echo $code;

?>
