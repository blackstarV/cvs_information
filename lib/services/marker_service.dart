import 'package:cvs_information/models/place.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MarkerService {
  List<Marker> getMarkers(List<Place> places) {
    var markers = <Marker>[];

    // ignore: avoid_function_literals_in_foreach_calls
    places.forEach((place) async {
      Marker marker = Marker(
        markerId: MarkerId(place.name),
        draggable: false,
        icon: place.icon,
        infoWindow: InfoWindow(title: place.name, snippet: place.address_name),
        position: LatLng(place.lat, place.lng),
      );

      markers.add(marker);
    });

    return markers;
  }
}
