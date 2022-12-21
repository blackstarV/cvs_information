import 'dart:async';
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
import 'package:sliding_up_panel/sliding_up_panel.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  static const double gpsButtonHeightClosed = 120;
  double gpsButtonHeight = gpsButtonHeightClosed;
  final panelController = PanelController();
  Completer<GoogleMapController> mapcontroller = Completer();

  @override
  Widget build(BuildContext context) {
    final currentPosition = Provider.of<Position?>(context);
    final placesProvider = Provider.of<Future<List<Place>?>?>(context);
    final geoService = GeoLocatorService();
    final markerService = MarkerService();
    final panelHeightOpen = MediaQuery.of(context).size.height * 0.6;
    final panelHeightClosed = MediaQuery.of(context).size.height * 0.1;
    final panelMaxScrollExtent = panelHeightOpen - panelHeightClosed;

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
                  return Stack(alignment: Alignment.topCenter, children: <
                      Widget>[
                    SlidingUpPanel(
                      controller: panelController,
                      maxHeight: panelHeightOpen,
                      minHeight: panelHeightClosed,
                      parallaxEnabled: true,
                      parallaxOffset: 0.5,
                      borderRadius:
                          const BorderRadius.vertical(top: Radius.circular(30)),
                      onPanelSlide: (position) => setState(() {
                        gpsButtonHeight = position * panelMaxScrollExtent +
                            gpsButtonHeightClosed;
                      }),
                      body: SizedBox(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        child: GoogleMap(
                          myLocationButtonEnabled: false,
                          myLocationEnabled: true,
                          initialCameraPosition: CameraPosition(
                              target: LatLng(currentPosition.latitude,
                                  currentPosition.longitude),
                              zoom: 16.0),
                          zoomGesturesEnabled: true,
                          markers: Set<Marker>.of(markers),
                          onCameraIdle: () async {
                            GoogleMapController controller =
                                await mapcontroller.future;
                            // ignore: use_build_context_synchronously
                            (Theme.of(context).brightness == Brightness.dark)
                                ? await controller.setMapStyle(
                                    '[{"elementType":"labels.icon","stylers":[{"visibility":"off"}]},{"elementType":"labels.text.fill","stylers":[{"color":"#969696"},{"saturation":36},{"lightness":40}]},{"elementType":"labels.text.stroke","stylers":[{"color":"#000000"},{"lightness":16},{"visibility":"on"}]},{"featureType":"administrative","elementType":"geometry.fill","stylers":[{"color":"#000000"},{"lightness":20}]},{"featureType":"administrative","elementType":"geometry.stroke","stylers":[{"color":"#000000"},{"lightness":17},{"weight":1.2}]},{"featureType":"administrative.country","elementType":"geometry.stroke","stylers":[{"color":"#606060"}]},{"featureType":"administrative.locality","elementType":"labels.icon","stylers":[{"color":"#9e9e9e"},{"visibility":"simplified"}]},{"featureType":"administrative.locality","elementType":"labels.text.fill","stylers":[{"color":"#8d8d8d"}]},{"featureType":"administrative.province","elementType":"geometry.stroke","stylers":[{"color":"#525252"}]},{"featureType":"landscape","stylers":[{"visibility":"on"}]},{"featureType":"landscape","elementType":"geometry","stylers":[{"color":"#000000"},{"lightness":20}]},{"featureType":"landscape","elementType":"geometry.stroke","stylers":[{"color":"#636363"}]},{"featureType":"landscape","elementType":"labels.icon","stylers":[{"saturation":"-100"},{"lightness":"-54"}]},{"featureType":"poi","stylers":[{"saturation":"-100"},{"lightness":"0"}]},{"featureType":"poi","elementType":"geometry","stylers":[{"color":"#101010"},{"lightness":21}]},{"featureType":"poi","elementType":"labels.icon","stylers":[{"saturation":"-89"},{"lightness":"-55"}]},{"featureType":"poi","elementType":"labels.text","stylers":[{"visibility":"off"}]},{"featureType":"poi.business","stylers":[{"visibility":"off"}]},{"featureType":"road","elementType":"labels.icon","stylers":[{"visibility":"off"}]},{"featureType":"road.arterial","elementType":"geometry","stylers":[{"color":"#000000"},{"lightness":18}]},{"featureType":"road.arterial","elementType":"geometry.stroke","stylers":[{"color":"#453838"},{"visibility":"off"}]},{"featureType":"road.highway","elementType":"geometry.fill","stylers":[{"color":"#303030"},{"saturation":"-100"},{"lightness":17}]},{"featureType":"road.highway","elementType":"geometry.stroke","stylers":[{"color":"#000000"},{"lightness":29},{"weight":0.2}]},{"featureType":"road.local","elementType":"geometry","stylers":[{"color":"#000000"},{"lightness":16}]},{"featureType":"road.local","elementType":"geometry.stroke","stylers":[{"visibility":"off"}]},{"featureType":"transit","stylers":[{"visibility":"off"}]},{"featureType":"transit","elementType":"geometry","stylers":[{"color":"#000000"},{"lightness":19}]},{"featureType":"transit.station","elementType":"labels.icon","stylers":[{"saturation":"-100"},{"lightness":"-51"},{"visibility":"on"}]},{"featureType":"water","elementType":"geometry","stylers":[{"color":"#000000"},{"lightness":17}]}]')
                                : await controller.setMapStyle(
                                    '[{"elementType":"geometry","stylers":[{"color":"#f5f5f5"}]},{"elementType":"labels.icon","stylers":[{"visibility":"off"}]},{"elementType":"labels.text.fill","stylers":[{"color":"#616161"}]},{"elementType":"labels.text.stroke","stylers":[{"color":"#f5f5f5"}]},{"featureType":"administrative","elementType":"geometry","stylers":[{"visibility":"off"}]},{"featureType":"administrative.land_parcel","elementType":"labels.text.fill","stylers":[{"color":"#bdbdbd"}]},{"featureType":"poi","stylers":[{"visibility":"off"}]},{"featureType":"poi","elementType":"geometry","stylers":[{"color":"#eeeeee"}]},{"featureType":"poi","elementType":"labels.text.fill","stylers":[{"color":"#757575"}]},{"featureType":"poi.park","elementType":"geometry","stylers":[{"color":"#e5e5e5"}]},{"featureType":"poi.park","elementType":"labels.text.fill","stylers":[{"color":"#9e9e9e"}]},{"featureType":"road","elementType":"geometry","stylers":[{"color":"#ffffff"}]},{"featureType":"road","elementType":"labels.icon","stylers":[{"visibility":"off"}]},{"featureType":"road.arterial","elementType":"labels.text.fill","stylers":[{"color":"#757575"}]},{"featureType":"road.highway","elementType":"geometry","stylers":[{"color":"#dadada"}]},{"featureType":"road.highway","elementType":"labels.text.fill","stylers":[{"color":"#616161"}]},{"featureType":"road.local","elementType":"labels.text.fill","stylers":[{"color":"#9e9e9e"}]},{"featureType":"transit","stylers":[{"visibility":"off"}]},{"featureType":"transit.line","elementType":"geometry","stylers":[{"color":"#e5e5e5"}]},{"featureType":"transit.station","elementType":"geometry","stylers":[{"color":"#eeeeee"}]},{"featureType":"water","elementType":"geometry","stylers":[{"color":"#c9c9c9"}]},{"featureType":"water","elementType":"labels.text.fill","stylers":[{"color":"#9e9e9e"}]}]');
                          },
                          onMapCreated: (GoogleMapController controller) {
                            mapcontroller.complete(controller);
                          },
                        ),
                      ),
                      panelBuilder: (ScrollController controller) =>
                          ListView.builder(
                              padding: const EdgeInsets.symmetric(vertical: 30),
                              controller: controller,
                              itemCount: places?.length,
                              itemBuilder: (context, index) {
                                return (places != null)
                                    ? FutureProvider(
                                        create: (context) =>
                                            geoService.getDistance(
                                                currentPosition.latitude,
                                                currentPosition.longitude,
                                                places[index].lat,
                                                places[index].lng),
                                        initialData: null,
                                        child: Card(
                                          child: ListTile(
                                            onTap: () async {
                                              GoogleMapController controller =
                                                  await mapcontroller.future;
                                              controller.animateCamera(
                                                  CameraUpdate
                                                      .newCameraPosition(
                                                          CameraPosition(
                                                              target: LatLng(
                                                                  places[index]
                                                                      .lat,
                                                                  places[index]
                                                                      .lng),
                                                              zoom: 16.0)));
                                            },
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
                                                Consumer<double?>(
                                                  builder: (context, meters,
                                                      widget) {
                                                    return (meters != null)
                                                        ? Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceEvenly,
                                                                  children: [
                                                                    Image.asset(
                                                                      'images/24h_off.png',
                                                                      width: 30,
                                                                    ),
                                                                    Image.asset(
                                                                      'images/parcel_off.png',
                                                                      width: 30,
                                                                    ),
                                                                    Image.asset(
                                                                      'images/coffee_off.png',
                                                                      width: 30,
                                                                    ),
                                                                    Image.asset(
                                                                      'images/fried_off.png',
                                                                      width: 30,
                                                                    ),
                                                                    Image.asset(
                                                                      'images/atm_off.png',
                                                                      width: 30,
                                                                    ),
                                                                    Image.asset(
                                                                      'images/lotto_off.png',
                                                                      width: 30,
                                                                    ),
                                                                    Image.asset(
                                                                      'images/toto_off.png',
                                                                      width: 30,
                                                                    )
                                                                  ]),
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
                                              icon: const Icon(
                                                  Icons.info_outline),
                                              onPressed: () async {
                                                _launchMapsUrl(
                                                    places[index].place_url);
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
                    ),
                    Positioned(
                        right: 20,
                        bottom: gpsButtonHeight,
                        child: FloatingActionButton(
                          child: const Icon(Icons.gps_fixed),
                          onPressed: () async {
                            GoogleMapController controller =
                                await mapcontroller.future;
                            controller.animateCamera(
                                CameraUpdate.newCameraPosition(CameraPosition(
                                    target: LatLng(currentPosition.latitude,
                                        currentPosition.longitude),
                                    zoom: 16.0)));
                          },
                        )),
                  ]);
                },
              )
            : Platform.isAndroid
                ? const Center(child: CircularProgressIndicator())
                : const Center(child: CupertinoActivityIndicator()), // 로딩창
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Future<void> _launchMapsUrl(String place_url) async {
    if (!await launchUrl(Uri.parse(place_url),
        mode: LaunchMode.externalApplication)) {
      throw ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('불러올 수 없습니다.\n$place_url'),
          duration: const Duration(seconds: 1)));
    }
  }
}
