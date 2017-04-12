$(document).ready(function() {
  initMap();
  $.getJSON('/spots', function(results){
    for (var i = 0; i < results.spots.length; i++) {
      var jsonlatitude = results.spots[i].lat;
      var jsonlong = results.spots[i].lng;
      var latLng = new google.maps.LatLng(jsonlatitude, jsonlong);
      var marker = new google.maps.Marker({
        position: latLng,
        map: map,
        icon: 'http://maps.google.com/mapfiles/ms/icons/green-dot.png'
      })
    }
  })





  infoWindow = new google.maps.InfoWindow;
  // Try HTML5 geolocation.
  if (navigator.geolocation) {
    navigator.geolocation.getCurrentPosition(function(position) {
      latitude = position.coords.latitude;
      longitude = position.coords.longitude;
      coords = new google.maps.LatLng(latitude, longitude);
      infoWindow.setPosition(coords);
      infoWindow.setContent('Current Location');
      infoWindow.open(map);
      map.setCenter(coords);
      var destinationInput = document.getElementById('destination-input');
      var destinationAutocomplete = new google.maps.places.Autocomplete(
      destinationInput, {placeIdOnly: true});

    })
  }
  $("#des-button").on("click", function(){
    var directionsService = new google.maps.DirectionsService();
    var directionsDisplay = new google.maps.DirectionsRenderer();
      map = new google.maps.Map( document.getElementById("map"));
      directionsDisplay.setMap(map);
      var destinationInput = document.getElementById('destination-input');
      var address = destinationInput.value
      geocoder = new google.maps.Geocoder();
      var marker = null;
      geocoder.geocode({'address' : address}, function(results, status){
        if(status == 'OK') {
          map.setCenter(results[0].geometry.location);
          marker = new google.maps.Marker({
            map: map,
            postition: results[0].geometry.location
          });
          var request = {
            origin: coords,
            destination: { lat: marker.postition.lat(), lng: marker.postition.lng() },
            travelMode: google.maps.DirectionsTravelMode.DRIVING
          };
          directionsService.route(request, function (response, status) {
            if (status == google.maps.DirectionsStatus.OK) {
              directionsDisplay.setDirections(response);
              $.getJSON('/spots', function(results){
                for (var i = 0; i < results.spots.length; i++) {
                  var jsonlatitude = results.spots[i].lat;
                  var jsonlong = results.spots[i].lng;
                  var latLng = new google.maps.LatLng(jsonlatitude, jsonlong);
                  var marker = new google.maps.Marker({
                    position: latLng,
                    map: map,
                    icon: 'http://maps.google.com/mapfiles/ms/icons/green-dot.png'
                  })
                }
              })
              }
            });
        } else {
          alert('Geocide was not successful for the following reason:' + status)
        }
      });
    });

  $("#check-in").on("click", function(e){
    e.preventDefault();
    USER_ID = parseInt(this.name)
    window.navigator.geolocation.getCurrentPosition(function(position){
      coords = [position.coords.latitude, position.coords.longitude];
      $.ajax({
        url: "/spots",
        method: "post",
        data: { spot: {
          user_id: USER_ID,
          lat: coords[0],
          lng: coords[1],
          }
        }
      }).done(function(response){
      });
    });

  });





})



var map, infoWindow;
function initMap() {
  map = new google.maps.Map(document.getElementById('map'), {
    center: {lat: -34.397, lng: 150.644},
    zoom: 15
  });

}
