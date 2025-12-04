import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:jetmarket/components/location_picker/modern_location_picker.dart';

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
  @override
  Widget build(BuildContext context) {
    final initialLocation = LatLng(widget.lat, widget.lng);

    return GoogleMap(
      initialCameraPosition: CameraPosition(
        target: initialLocation,
        zoom: 15,
      ),
      markers: {
        Marker(
          markerId: const MarkerId('current_location'),
          position: initialLocation,
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
          infoWindow: const InfoWindow(title: 'Selected Location'),
        ),
      },
      zoomControlsEnabled: true,
      myLocationEnabled: true,
      myLocationButtonEnabled: true,
      mapType: MapType.normal,
      compassEnabled: true,
    );
  }
}

// Enhanced map view with location picker integration
class EnhancedMapView extends StatelessWidget {
  final double? lat;
  final double? lng;
  final Function(double lat, double lng, String address)? onLocationSelected;
  final String? title;

  const EnhancedMapView({
    super.key,
    this.lat,
    this.lng,
    this.onLocationSelected,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: lat != null && lng != null
          ? GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(lat!, lng!),
                zoom: 15,
              ),
              markers: {
                Marker(
                  markerId: const MarkerId('selected_location'),
                  position: LatLng(lat!, lng!),
                  icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
                  infoWindow: const InfoWindow(title: 'Selected Location'),
                ),
              },
              zoomControlsEnabled: true,
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              mapType: MapType.normal,
              compassEnabled: true,
            )
          : Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.location_off,
                      size: 48,
                      color: Colors.grey[400],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'No location selected',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ModernLocationPicker(
                              title: title ?? 'Select Location',
                              initialLocation: lat != null && lng != null
                                  ? LatLng(lat!, lng!)
                                  : null,
                              onLocationSelected: (location, address) {
                                if (onLocationSelected != null) {
                                  onLocationSelected!(
                                    location.latitude,
                                    location.longitude,
                                    address,
                                  );
                                }
                              },
                            ),
                          ),
                        );
                      },
                      icon: const Icon(Icons.map),
                      label: const Text('Select Location'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xffDB4C45),
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
