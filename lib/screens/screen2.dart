import 'package:assignment_crops_app/screens/tabs.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:http/http.dart' as http;

class GoogleMaps extends StatefulWidget {
  const GoogleMaps({Key? key}) : super(key: key);
  static const routeName = '/screen2.0';
  @override
  State<GoogleMaps> createState() => _GoogleMapsState();
}

class _GoogleMapsState extends State<GoogleMaps> {
  late GoogleMapController _googleMapController;
  Set<Marker> _markers = {};
  late BitmapDescriptor mapMarker;
  @override
  void initState() {
    _setCustomMarker();
    // TODO: implement initState
    super.initState();
  }

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      _markers.add(Marker(
        icon: mapMarker,
        markerId: MarkerId('id1'),
        position: LatLng(22.5, 88.3),
      ));
    });
  }

  void _setCustomMarker() async {
    mapMarker = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(), 'assets/custom_marker.png');
  }

  @override
  void dispose() {
    _googleMapController.dispose();

    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
              myLocationButtonEnabled: false,
              zoomControlsEnabled: false,
              initialCameraPosition:
                  CameraPosition(target: LatLng(22.5, 88.3), zoom: 15),
              onMapCreated: _onMapCreated,
              markers: _markers),
        ],
      ),
    );
  }
}
