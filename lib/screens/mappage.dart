import 'dart:io' show Platform;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../models/place.dart';

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
    return FutureProvider(
      initialData: null,
      create: (context) => placesProvider,
      child: Scaffold(
        body: (currentPosition != null)
            ? Consumer<List<Place>?>(
                builder: (_, places, __) {
                  return Column(
                    children: <Widget>[
                      Container(
                        height: MediaQuery.of(context).size.height / 3,
                        width: MediaQuery.of(context).size.width,
                        child: GoogleMap(
                          initialCameraPosition: CameraPosition(
                              target: LatLng(currentPosition.latitude,
                                  currentPosition.longitude),
                              zoom: 16.0),
                          zoomGesturesEnabled: true,
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Expanded(
                        child: ListView.builder(
                            itemCount: places?.length,
                            itemBuilder: (context, index) {
                              return (places != null)
                                  ? Card(
                                      child: ListTile(
                                        title: Text(places[index].name),
                                      ),
                                    )
                                  : const Center(
                                      child: CircularProgressIndicator());
                            }),
                      )
                    ],
                  );
                },
              )
            : Platform.isAndroid
                ? Center(child: CircularProgressIndicator())
                : Center(child: CupertinoActivityIndicator()), // 로딩창
      ),
    );
  }
}
