<?php
// usage: do database operations
// refer: http://www.java2s.com/Code/Php/MySQL-Database/
$host = "localhost";
$user = "test";
$pass = "test";
$db = "test";
// connect
$link = mysql_connect( $host, $user, $pass );
if ( ! $link ) {
    die( "Couldn't connect to MySQL: ".mysql_error() );
}
print "conncet to mysql success\n";
mysql_select_db( $db, $link ) or die ( "Couldn't open $db: ".mysql_error() );

// query
$result = mysql_query( "SELECT * from example " );
$num_rows = mysql_num_rows( $result );

// show result
print "$num_rows result in the table\n";
while ( $a_row = mysql_fetch_row( $result ) ) {
    foreach ( $a_row as $field ) {
        print "$field\t";
    }
    print "\n";
}
mysql_close( $link );
?>
