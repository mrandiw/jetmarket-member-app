import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapView extends StatefulWidget {
  final double lat;
  final double lng;

  const MapView({
    super.key,
    required this.lat,
    required this.lng,
  });

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  final mapController = MapController();

  @override
  void didUpdateWidget(covariant MapView oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.lat != widget.lat || oldWidget.lng != widget.lng) {
      final point = LatLng(widget.lat, widget.lng);
      mapController.move(point, 15);
    }
  }

  @override
  Widget build(BuildContext context) {
    final point = LatLng(widget.lat, widget.lng);

    return FlutterMap(
      mapController: mapController,
      options: MapOptions(
        initialCenter: point,
        initialZoom: 15,
      ),
      children: [
        TileLayer(
          urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
          userAgentPackageName: "com.jetmarket.app",
        ),
        MarkerLayer(
          markers: [
            Marker(
              point: point,
              width: 40,
              height: 40,
              child: const Icon(
                Icons.location_pin,
                color: Colors.red,
                size: 40,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
