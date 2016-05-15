<?php
// THIS IS ONLY A SAMPLE SCRIPT. PLEASE TWEAK IT TO YOUR NEEDS.
// IT COMES WITH NO WARRANTY WHATSOEVER. 
$file = "mapdata.txt"; // you might save in a database instead...
if (isset($_GET["lat"]) && isset($_GET["lon"])) {
    $fh = fopen($file, "w");
    if (!$fh) {
        header("HTTP/1.0 500 Internal Server Error");
        exit(print_r(error_get_last(), true));
    }
        fwrite($fh, '{"lat":"'.$_GET["lat"].'", "lon":"'.$_GET["lon"].'", "timestamp":"'.$_GET["timestamp"].'"}');
    fclose($fh);
    // you should obviously do your own checks before this...
    echo "success";
} else {
    header('HTTP/1.0 400 Bad Request');
    echo 'Error.';
}
?>
