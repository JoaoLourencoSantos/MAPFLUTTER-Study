import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Mapr',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Map'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
        desiredAccuracy: LocationAccuracy.high);
  }

  Future<CameraPosition> _getCurrentPosition() async {
    Position position = await _getPosition();

    return CameraPosition(
        target: LatLng(position.latitude, position.longitude),
        zoom: _fixedZoom);
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
          LatLng(-19.933722065812983, -43.93633613095481)),
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
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Color(0xFF158185),
      ),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: _getInitialLocation(),
        markers: _createMarkers(),
        myLocationEnabled: true,
        zoomGesturesEnabled: true,
        zoomControlsEnabled: true,
      ),
    );
  }
}
