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
  var geolocator = Geolocator();

  static final LatLng _locationCenter =
      LatLng(-19.932532517135538, -43.938577202118765);

  void _onMapCreated(GoogleMapController controller) async {
    mapController = controller;

    mapController.setMapStyle(
        await DefaultAssetBundle.of(context).loadString('assets/map.json'));

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
        target: LatLng(position.latitude, position.longitude), zoom: 15.0);
  }

  CameraPosition _getInitialLocation() {
    return CameraPosition(
        target: _locationCenter, zoom: 15.0, tilt: 0, bearing: 0);
  }

  Set<Marker> _createMarkers() {
    return {
      Marker(
        markerId: MarkerId("PUC_MINAS_CE"),
        position: LatLng(-19.92257975766356, -43.99257354444666),
        infoWindow: InfoWindow(title: 'PUC Minas - Coração Eucarístico'),
      ),
      Marker(
        markerId: MarkerId("PUC_MINAS_SG"),
        position: LatLng(-19.859143126099053, -43.91881268492343),
        infoWindow: InfoWindow(title: 'PUC Minas - São Gabriel'),
      ),
      Marker(
        markerId: MarkerId("PUC_MINAS_PL"),
        position: LatLng(-19.933722065812983, -43.93633613095481),
        infoWindow: InfoWindow(title: 'PUC Minas - Praça da Liberdade'),
      ),
    };
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for i
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
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
