import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttermap/models/ResultDTO.dart';
import 'package:fluttermap/services/integration.dart';
import 'package:fluttermap/services/notifications.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapComponent extends StatefulWidget {
  MapComponent({Key? key}) : super(key: key);

  @override
  MapComponentState createState() => MapComponentState();
}

class MapComponentState extends State<MapComponent> {
  late GoogleMapController mapController;

  static final LatLng _centerLocation =
      LatLng(-19.932532517135538, -43.938577202118765);

  static final double _fixedZoom = 15.0;

  static final String _urlMapStyle = "assets/map.json";

  void _onMapCreated(GoogleMapController controller) async {
    mapController = controller;

    // Set style in map
    mapController.setMapStyle(
        await DefaultAssetBundle.of(context).loadString(_urlMapStyle));

    // Set animation camera, to current position
    mapController.animateCamera(
        CameraUpdate.newCameraPosition(await _getCurrentPosition()));
  }

  Future<Position> _getPosition() async {
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.lowest);
  }

  Future<CameraPosition> _getCurrentPosition() async {
    Position position = await _getPosition();

    await showDialog(position);

    return CameraPosition(
        target: LatLng(position.latitude, position.longitude),
        zoom: _fixedZoom);
  }

  showDialog(Position position) async {
    Geolocator.getPositionStream(
            desiredAccuracy: LocationAccuracy.lowest,
            distanceFilter: 4,
            intervalDuration: Duration(milliseconds: 30000))
        .listen((Position position) async {
      ResultDTO result = await fetchData(position.latitude, position.longitude);

      if (result.error) {
        return;
      }

      if (!result.success) {
        return;
      }

      NotificationService.showSuccesDialog(context, result.locale);
    });
  }

  CameraPosition _getInitialLocation() {
    return CameraPosition(
        target: _centerLocation, zoom: _fixedZoom, tilt: 0, bearing: 0);
  }

  Set<Marker> _createMarkers() {
    return {
      _buildMarker("PUC_MINAS_CE", "PUC Minas - Coração Eucarístico",
          LatLng(-19.92257975766356, -43.99257354444666)),
      _buildMarker("PUC_MINAS_SG", "PUC Minas - São Gabriel",
          LatLng(-19.859143126099053, -43.91881268492343)),
      _buildMarker("PUC_MINAS_PL", "PUC Minas - Praça da Liberdade",
          LatLng(-19.93265658845615, -43.93602367570194)),
      _buildMarker("PUC_MINAS_BR", "PUC Minas - Barreiro",
          LatLng(-19.976523364712037, -44.02588694432856)),
      _buildMarker("PUC_MINAS_BE", "PUC Minas - Betim",
          LatLng(-19.9550716, -44.1984331)),
      _buildMarker("PUC_MINAS_CT", "PUC Minas - Contagem",
          LatLng(-19.941460, -44.076420)),
      _buildMarker("PUC_MINAS_PC", "PUC Minas - Poços de Caldas",
          LatLng(-21.7992564, -46.6007147)),
    };
  }

  Marker _buildMarker(String id, String title, LatLng location) {
    return Marker(
      markerId: MarkerId(id),
      position: location,
      infoWindow: InfoWindow(title: title),
    );
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for i
    return GoogleMap(
      onMapCreated: _onMapCreated,
      initialCameraPosition: _getInitialLocation(),
      markers: _createMarkers(),
      myLocationEnabled: true,
      zoomGesturesEnabled: true,
      zoomControlsEnabled: true,
    );
  }
}
