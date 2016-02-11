

<html>
<head>
	<link rel="stylesheet" href="http://cdn.leafletjs.com/leaflet/v0.7.7/leaflet.css" />

	<script src="http://cdn.leafletjs.com/leaflet/v0.7.7/leaflet.js"></script>
		
</head>

<body>


 <div id="map" style="height: 100%"></div>

</body>

<script>
	
	// Error catching if php fails..
	var latitude = 0;
	var longitude = 0;
	
	var map = L.map('map').setView([51.505, -0.09], 13);

	L.tileLayer('http://{s}.tile.osm.org/{z}/{x}/{y}.png', {
    	attribution: '&copy; <a href="http://osm.org/copyright">OpenStreetMap</a> contributors'
	}).addTo(map);
	
	
</script>
<?php

$json_file = file_get_contents('mapdata.txt');
// convert the string to a json object
$jfo = json_decode($json_file);
// read the title value
$lat = $jfo->lat;
// copy the posts array to a php var
$lon = $jfo->lon;
$timestamp = $jfo->timestamp;
// listing posts

echo('<script>
    var lon = '.$lon.';
    var lat = '.$lat.';
    var marker = L.marker([lat,lon], {title:  \'Your Location at '.$timestamp.'\'}).addTo(map);
    map.panTo(new L.LatLng(lat, lon));
    </script>');
?>

</html>


