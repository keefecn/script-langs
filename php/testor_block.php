#!/usr/bin/php
<?php
include_once("common.php");

//print_r($_GET);   //get from commandline, no need
//print_r($_SERVER["argv"]);   //get array

if ($argc == 4)
{
    $type = $argv[1];
    $host = $argv[2];
    $port = $argv[3];
}
else if ($argc == 2)
{
    $type = $argv[1];
// $host = "127.0.0.1";
    $host = "124.42.127.170";
    $port = 3200;
}
else
{
    printf( "Usage: %s [type] [host] [port]\n", $argv[0] );
    printf( "\t1/10\n\t\t: title_retrieve\n" );
    printf( "\t2/20\n\t\t: text_retrieve\n" );
    printf( "\t3/30\n\t\t: class_retrieve\n" );
    printf( "\t4/40\n\t\t: show_retrieve\n" );
    printf( "\t5/n\t\t: retrieve from index\n" );
    printf( "\t6/n\t\t: retrieve from index\n" );
    die();
}

// get sock: socket + connect
$sock = get_socket( $host, $port );
socket_set_option( $sock, SOL_SOCKET, SO_LINGER, array("l_onoff"=>1, "l_linger"=>0) );

// send packet
$request =  get_request( $type );
$len = strlen( $request );
printf("len = %d\n", $len );
socket_write( $sock, $request, $len );
printf( "send ok\n" );

// recv packet
//socket_set_option( $sock, SOL_SOCKET, SO_RCVTIMEO, array("sec"=>10, "usec"=>5000) );
socket_recv( $sock, $lenBuf, 4, MSG_WAITALL);
printf( "recv len ok\n" );
$res = unpack( 'N', $lenBuf );
printf("len = %d\n", $res[1] );
socket_recv( $sock, $buf, $res[1] - 4, MSG_WAITALL);
printf("buf len = %d\n", strlen( $buf ) );

// parse result
if ($type == 6)
    printf("buf = %s\n",  substr( $buf, 16) );
else
    parse_result( $buf );
print $buf;
socket_close( $sock );
printf("\ncl0se ok\n")

?>
