$(document).ready(function() {
  initMap();
  $("#check-in").on("click", function(e){
    e.preventDefault();
    window.navigator.geolocation.getCurrentPosition(function(position){

      coords = [position.coords.latitude, position.coords.longitude];
      $.ajax({
        url: "/spots",
        method: "post",
        data: { spot: {
          user_id: parseInt(this.name),
          lat: coords[0],
          long: coords[1],
          }
        }
      }).done(function(response){
        debugger;
      });
    });

  });

  // all the code you want to run when the page loads
  // $("#whatever").on("click", function(){
  //
  // })
  // this should include *binding* event handlers to nodes

})

var map, infoWindow;
function initMap() {
  map = new google.maps.Map(document.getElementById('map'), {
    center: {lat: -34.397, lng: 150.644},
    zoom: 15
  });

  infoWindow = new google.maps.InfoWindow;

  // Try HTML5 geolocation.
  if (navigator.geolocation) {
    navigator.geolocation.getCurrentPosition(function(position) {
      var latitude = position.coords.latitude;
      var longitude = position.coords.longitude;
      var coords = new google.maps.LatLng(latitude, longitude);
      var directionsService = new google.maps.DirectionsService();
      var directionsDisplay = new google.maps.DirectionsRenderer();
      var mapOptions =
      {
        zoom: 15,
        center: coords,
        mapTypeControl: true,
        navigationControlerOptions:
        {
          style: google.maps.NavigationControlStyle.SMALL
        },
          mapTypeId: google.maps.MapTypeId.ROADMAP
      };
        map = new google.maps.Map( document.getElementById("map"), mapOptions);
        directionsDisplay.setMap(map);
        directionsDisplay.setPanel(document.getElementById('panel'));
        var request = {
          origin: coords,
          destination: 'BT42 1FL',
          travelMode: google.maps.DirectionsTravelMode.DRIVING
        };

        directionsService.route(request, function (response, status) {
          if (status == google.maps.DirectionsStatus.OK) {
            directionsDisplay.setDirections(response);
          }
        });
    });
  }
}
