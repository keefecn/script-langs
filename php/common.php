<?php

function get_socket( $host, $port )
{
    printf("HOST = %s, PORT = %d\n", $host, $port );
    $sock = socket_create( AF_INET, SOCK_STREAM, SOL_TCP );

    $res = socket_connect( $sock, $host, $port );
    if( false == $res ) {
        printf("==%s",socket_strerror( socket_last_error( $sock ) ) );
        return false;
    }
    //socket_set_option( $sock, SOL_SOCKET, SO_LINGER, array("l_onoff"=>1, "l_linger"=>0) );
	return $sock;
}

// generate request packet
function get_request( $type )
{
	switch ( $type ) { 
	case 10:
	case 1:
	case 2:
	case 20:
	case 3:
	case 30:
	case 4:
	case 40:
		$request = get_request_from_cache( $type );
		//print_r( unpack ( "N1len/N1type/N1subtype/a14time" , $request ) );
		break;		
	case 5:
	case 50:
		$request = get_request_from_index( );
		break;		
	case 6:
	case 60:
		$request = get_request_from_summary( );
		break;		
	default: 
		break;
	}
	return $request;
}

// unavailable
function get_request_from_summary(  )
{
    $len = 64;
    $type = 0x00002000;
	$subType = 0x00000404;
    $KeyWordNum = 1;
    $actType = 1;
	$Str = "beijing";
	$TotalNum = 1;
	$retNum = 1;
	$NsId = 24987;
    $request = pack('N5a32N3'
        , $len
        , $type
        , $subType
        , $KeyWordNum
        , $actType
        , $Str
        , $TotalNum
        , $retNum
        , $NsId );
    return $request;
}

// unavailable
function get_request_from_index(  )
{
	die();
}

function get_request_from_cache( $type )
{
	switch ( $type ) { 
	case 10:
	case 1:	// text
		$subType = 0x00000401;
		break;
	case 20:
	case 2:	// title
		$subType = 0x00000402;
		break;
	case 30:
	case 3:	// class
		$subType = 0x00000404;
		break;
	case 40:
	case 4:	// show title
		$subType = 0x00000408;
		break;
	default:
		$subType = 0x00000404;
		break;
	}
	//printf("subType = %X\n", $subType );

	// give a default keyword or get from stdin
	if( $type < 9 ){	
		$keyword = 'beijing';
		#$keyword = '¨?¨???';
	}
	else{
		printf( "Please insert keyword(xxxxxx) : " );
		$keyword = trim(fgets(STDIN) );
	}
	printf( "insert keyword = %s\n", $keyword );
    $len = 84;
    $type = 0x00002000;
    $wantNum = 3;
    $beginNum = 0;
    $beginDate = 0;
    $endDate = 0;
    #$stCode = 600992;
    $stCode = 0;
    $category = 0;
    $nsType = 0;
    $sortType = 0;
    $keywordNum = 1;
    $actType = 1;
    $request = pack('N13a32'
        , $len
        , $type
        , $subType
        , $wantNum
        , $beginNum
        , $beginDate
        , $endDate
        , $stCode
        , $category
        , $nsType
        , $sortType
        , $keywordNum
        , $actType
        , $keyword );
    return $request;
}

function parse_final_result( $buf, $num )
{
    $len = strlen( $buf );
    for( $i = 0; $i < $num; $i++ ) {
        $title = unpack( "a80", substr( $buf, $i*496 + 0, 80 ) );
        $summary = unpack( "a128", substr( $buf, $i*496 + 80, 128 ) );
        printf("[%d]==================================\n", $i+1);
        printf("\ttitle = %s\n\tsummary = %s\n", $title[1], $summary[1] );
    }
}

function parse_result( $buf )
{
    $res1 = unpack( 'N*', substr( $buf, 0, 16 ) );
    printf("-------\n" );
    print_r( $res1);
    switch( $res1[2] ) { 
    case 0x10000401:
        print "text retrieve result.\n";
        parse_final_result( substr( $buf, 20 ), $res1[4] );
        break;
    case 0x10000402:
        print "title retrieve result.\n";
        parse_final_result( substr( $buf, 20), $res1[4] );
        break;
    case 0x10000404:
        print "class retrieve result.\n";
        parse_final_result( substr( $buf, 20), $res1[4] );
        break;
    case 0x10000408:
        print "show title retrieve result.\n";
        parse_final_result( substr( $buf, 20), $res1[4] );
        break;
    default:
        break;   
    }   
    die();
}

?>
