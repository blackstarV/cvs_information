import 'dart:io' show Platform;

import 'package:cvs_information/services/geolocator_service.dart';
import 'package:cvs_information/services/marker_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/place.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  /* 카메라 포지션 기본값 공주대학교
  static const double _defaultLat = 36.8511811;
  static const double _defaultLng = 127.1511352;

  static const CameraPosition _defaultLocation =
      CameraPosition(target: LatLng(_defaultLat, _defaultLng), zoom: 15);
  */
  @override
  Widget build(BuildContext context) {
    final currentPosition = Provider.of<Position?>(context);
    final placesProvider = Provider.of<Future<List<Place>?>?>(context);
    final geoService = GeoLocatorService();
    final markerService = MarkerService();

    return FutureProvider(
      initialData: null,
      create: (context) => placesProvider,
      child: Scaffold(
        body: (currentPosition != null)
            ? Consumer<List<Place>?>(
                builder: (_, places, __) {
                  var markers = (places != null)
                      ? markerService.getMarkers(places)
                      : <Marker>[];
                  return Column(
                    children: <Widget>[
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 3,
                        width: MediaQuery.of(context).size.width,
                        child: GoogleMap(
                          initialCameraPosition: CameraPosition(
                              target: LatLng(currentPosition.latitude,
                                  currentPosition.longitude),
                              zoom: 16.0),
                          zoomGesturesEnabled: true,
                          markers: Set<Marker>.of(markers),
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Expanded(
                        child: ListView.builder(
                            itemCount: places?.length,
                            itemBuilder: (context, index) {
                              return (places != null)
                                  ? FutureProvider(
                                      create: (context) =>
                                          geoService.getDistance(
                                              currentPosition.latitude,
                                              currentPosition.longitude,
                                              places[index]
                                                  .geometry
                                                  .location
                                                  .lat,
                                              places[index]
                                                  .geometry
                                                  .location
                                                  .lng),
                                      initialData: null,
                                      child: Card(
                                        child: ListTile(
                                          onTap: () {},
                                          //----------------------------------------------------------------------
                                          title: Text(places[index].name),
                                          subtitle: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              //----------------------------------------------------------------------
                                              const SizedBox(
                                                height: 5.0,
                                              ),
                                              //----------------------------------------------------------------------
                                              (places[index].rating !=
                                                      0.0) // rating이 있을 땐 표시, 없으면 표시 안함
                                                  ? Row(
                                                      children: [
                                                        RatingBarIndicator(
                                                          rating: places[index]
                                                              .rating,
                                                          itemBuilder: (context,
                                                                  index) =>
                                                              const Icon(
                                                                  Icons.star),
                                                          itemCount: 5,
                                                          itemSize: 10.0,
                                                          direction:
                                                              Axis.horizontal,
                                                        )
                                                      ],
                                                    )
                                                  : Row(),
                                              //----------------------------------------------------------------------
                                              const SizedBox(
                                                height: 5.0,
                                              ),
                                              //----------------------------------------------------------------------
                                              Consumer<double?>(
                                                builder:
                                                    (context, meters, widget) {
                                                  return (meters != null)
                                                      ? Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(places[index]
                                                                .vicinity),
                                                            (meters >= 1000)
                                                                ? Text(
                                                                    '${(meters / 1000).toStringAsFixed(1)} km')
                                                                : Text(
                                                                    '${meters.toInt()} m'),
                                                          ],
                                                        )
                                                      : Container();
                                                },
                                              )
                                            ],
                                          ),
                                          //----------------------------------------------------------------------
                                          trailing: IconButton(
                                            icon:
                                                const Icon(Icons.info_outline),
                                            onPressed: () {
                                              _launchMapsUrl(
                                                  places[index].place_id);
                                            },
                                          ),
                                        ),
                                      ),
                                    )
                                  : Platform.isAndroid
                                      ? const Center(
                                          child: CircularProgressIndicator())
                                      : const Center(
                                          child:
                                              CupertinoActivityIndicator()); // 로딩창
                            }),
                      )
                    ],
                  );
                },
              )
            : Platform.isAndroid
                ? const Center(child: CircularProgressIndicator())
                : const Center(child: CupertinoActivityIndicator()), // 로딩창
      ),
    );
  }

  void _launchMapsUrl(String place_id) async {
    final url = 'https://www.google.com/maps/place/?q=place_id:$place_id';

    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw '불러올 수 없습니다. $url';
    }
  }
}
