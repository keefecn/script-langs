<?php

//phpinfo();

//// method 1: (PHP 4 >= 4.1.0, PHP 5) phpsocket_create, socket_connect, socket_set_option, socket_write, socket_recv, socket_close
//// method 2: (PHP 4, PHP 5) fsockopen fwrite fgets fclose
$FSFlag = 1;

function microtime_float()
{
    list($usec, $sec) = explode(" ", microtime());
    return ((float)$usec + (float)$sec);
}

function get_socket( $host, $port )
{   // inner function to call global variable: global
    global $FSFlag;
    printf("HOST = %s, PORT = %d ", $host, $port );
    if ( $FSFlag == 1) {
        $timeout = 7;
        $sock = fsockopen($host,  $port, $errno, $errstr, $timeout);
        if ( !$sock ) {
            echo "$errstr ($errno)\n";
            exit(1);
        }
    } else {
        $sock = socket_create(AF_INET, SOCK_STREAM, SOL_TCP);
        $res = socket_connect( $sock, $host, $port );
        if ( false == $res ) {
            printf("==%s",socket_strerror( socket_last_error( $sock ) ) );
            exit(1);
        }
        //socket_set_option( $sock, SOL_SOCKET, SO_LINGER, array("l_onoff"=>1, "l_linger"=>0) );
    }
    printf("Connection successful\n");

    return $sock;
}

function get_request( $keyword )
{
//	if( $type != 1 ){
//		printf( "Please insert keyword : " );
//		$keyword = trim(fgets(STDIN) );
//	}else{
//		if ( rand() % 2 == 0)
//			$keyword = "周杰伦" ;
//		else
//			$keyword = "笑话" ;
//		printf( "get keyword : %s\n", $keyword );
//	}

    $len = strlen($keyword) + 4;
    printf( "send len = %d\n", $len);
    $type = 0x00001000;
    $subType = 0x00008420;
    $request = pack('N1a*'
                    , $len
                    , $keyword);
    return $request;
}

function parse_result( $buf )
{
    $res1 = unpack( "N2", substr( $buf, 0, 8 ) );
    printf("-----------------------\n" );
    printf("type = %08x\n",  $res1[1]);
    printf("subtype = %08x\n",  $res1[2]);
}

//if($argc == 4)
//{
//  $host = $argv[1];
//  $port = $argv[2];
//  $type = $argv[3];
//}
//else if ($argc == 2 )
//{
$host = "127.0.0.1";
$port = 9280;
//  $type = $argv[1];
//}
//else
//{
//	printf( "Test\n");
//	printf( "Test:  Usage:   %s host port  type\n", $argv[0] );
//	printf( "\t0\n\t\t: ReplyTask\n" );
//	die();
//}
$key = $_GET['key'];
echo $key;

$time_start = microtime_float(true);
//get sock: socket + connect
$sock = get_socket( $host, $port );

//send packet
$request =  get_request( $key );
$len = strlen( $request );

if ( $FSFlag == 1) {
    fwrite( $sock, $request, $len );
    printf( "fsock send ok\n" );
    // use fsocket
    while ( $buffer = fgets($sock)) {
        echo $buffer;
        if (strpos($buffer, '</hsr>') !== false) break;
    }
    fclose($sock);
} else {
    socket_write( $sock, $request, $len );
    printf( "send ok\n" );

    //recv packet
    socket_set_option( $sock, SOL_SOCKET, SO_RCVTIMEO, array("sec"=>10, "usec"=>5000) );
    socket_recv( $sock, $lenBuf, 4, MSG_WAITALL);
    //printf( "recv ok\n" );

    ////parse result
    //$res = unpack( 'N', $lenBuf );
    //printf("len = %d\n", $res[1] );

    //socket_recv( $sock, $buf, $res[1] - 4, MSG_WAITALL);
    socket_recv( $sock, $buf, 204800, MSG_WAITALL);
    printf("buf len = %d\n", strlen( $buf ) );
    print_r ($buf);

    //parse_result( $buf );
    socket_close( $sock );
}

//$time_stop = microtime_float(true);
////$time = $time_stop - $time_start;
////$current_date = date("Ymd|H:i:s");
////$text=$current_date.' waste time: '.$time.' seconds'."\r\n";
////echo $text;
////
////$fp1 = fopen("debug.txt","a+");
////fwrite($fp1, $text);
////fclose($fp1);

?>
