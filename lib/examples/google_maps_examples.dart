import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../utils/google_maps_service.dart';

/// Comprehensive examples of using Google Maps APIs
class GoogleMapsExamples extends StatefulWidget {
  const GoogleMapsExamples({super.key});

  @override
  State<GoogleMapsExamples> createState() => _GoogleMapsExamplesState();
}

class _GoogleMapsExamplesState extends State<GoogleMapsExamples> {
  GoogleMapController? _mapController;
  Set<Marker> markers = {};
  Set<Polyline> polylines = {};
  LatLng? _currentLocation;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _initializeLocation();
  }

  Future<void> _initializeLocation() async {
    setState(() => _isLoading = true);

    // Example 1: Get current location (Geolocation API)
    final position = await GoogleMapsService.getCurrentLocation();
    if (position != null && mounted) {
      setState(() {
        _currentLocation = LatLng(position.latitude, position.longitude);
        markers.add(Marker(
          markerId: const MarkerId('current_location'),
          position: _currentLocation!,
          infoWindow: const InfoWindow(title: 'Your Location'),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        ));
      });
    }

    if (mounted) {
      setState(() => _isLoading = false);
    }
  }

  /// Example 2: Search for places (Places API)
  Future<void> _searchPlaces(String query) async {
    final places = await GoogleMapsService.searchPlaces(query);

    if (mounted) {
      setState(() {
        for (final place in places) {
          final location = place['geometry']['location'];
          final latLng = LatLng(location['lat'], location['lng']);

          markers.add(Marker(
            markerId: MarkerId(place['place_id']),
            position: latLng,
            infoWindow: InfoWindow(
              title: place['name'],
              snippet: place['formatted_address'],
            ),
          ));
        }
      });
    }
  }

  /// Example 3: Geocoding - Convert address to coordinates
  Future<void> _geocodeAddress(String address) async {
    final coordinates = await GoogleMapsService.geocode(address);
    if (coordinates != null && mounted) {
      setState(() {
        markers.add(Marker(
          markerId: const MarkerId('geocoded_address'),
          position: coordinates,
          infoWindow: InfoWindow(title: 'Geocoded: $address'),
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
        ));
      });

      _mapController?.animateCamera(
        CameraUpdate.newLatLngZoom(coordinates, 15),
      );
    }
  }

  /// Example 4: Reverse Geocoding - Convert coordinates to address
  Future<void> _reverseGeocode(LatLng position) async {
    final address = await GoogleMapsService.reverseGeocode(position);
    if (address != null && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Address: $address')),
      );
    }
  }

  /// Example 5: Get directions and draw route (Directions API)
  Future<void> _getDirections(LatLng origin, LatLng destination) async {
    final directions =
        await GoogleMapsService.getDirections(origin, destination);
    if (directions != null && directions['routes'].isNotEmpty) {
      final polylinePoints =
          await GoogleMapsService.getPolylinePoints(origin, destination);

      if (mounted) {
        setState(() {
          polylines.add(Polyline(
            polylineId: const PolylineId('route'),
            points: polylinePoints,
            color: Colors.blue,
            width: 5,
          ));

          // Add destination marker
          markers.add(Marker(
            markerId: const MarkerId('destination'),
            position: destination,
            infoWindow: const InfoWindow(title: 'Destination'),
            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
          ));
        });
      }
    }
  }

  /// Example 6: Distance Matrix API
  Future<void> _getDistanceMatrix() async {
    if (_currentLocation == null) return;

    final destinations = [
      const LatLng(-6.2088, 106.8456), // Jakarta
      const LatLng(-6.9175, 107.6191), // Bandung
      const LatLng(-7.2575, 112.7521), // Surabaya
    ];

    final matrix = await GoogleMapsService.getDistanceMatrix(
      [_currentLocation!],
      destinations,
    );

    if (matrix != null) {
      final rows = matrix['rows'] as List;
      for (final row in rows) {
        final elements = row['elements'] as List;
        for (int i = 0; i < elements.length; i++) {
          final element = elements[i];
          final distance = element['distance']['text'];
          final duration = element['duration']['text'];

          // ignore: avoid_print
          print('To destination $i: $distance, $duration');
        }
      }
    }
  }

  /// Example 7: Search nearby places
  Future<void> _searchNearbyPlaces() async {
    if (_currentLocation == null) return;

    final restaurants = await GoogleMapsService.searchNearbyPlaces(
      _currentLocation!,
      'restaurant',
      radius: 1000,
    );

    if (mounted) {
      setState(() {
        for (final place in restaurants) {
          final location = place['geometry']['location'];
          final latLng = LatLng(location['lat'], location['lng']);

          markers.add(Marker(
            markerId: MarkerId('restaurant_${place['place_id']}'),
            position: latLng,
            infoWindow: InfoWindow(
              title: place['name'],
              snippet: place['vicinity'],
            ),
            icon:
                BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
          ));
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Google Maps Examples'),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          // Control buttons
          Container(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  ElevatedButton(
                    onPressed: () => _searchPlaces('restaurants'),
                    child: const Text('Search Restaurants'),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () => _geocodeAddress('Monas, Jakarta'),
                    child: const Text('Geocode Monas'),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () => _searchNearbyPlaces(),
                    child: const Text('Nearby Places'),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: _currentLocation != null
                        ? () => _getDirections(
                              _currentLocation!,
                              const LatLng(-6.2088, 106.8456), // Jakarta
                            )
                        : null,
                    child: const Text('Get Directions'),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: _getDistanceMatrix,
                    child: const Text('Distance Matrix'),
                  ),
                ],
              ),
            ),
          ),

          // Map
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : GoogleMap(
                    onMapCreated: (controller) => _mapController = controller,
                    initialCameraPosition: CameraPosition(
                      target:
                          _currentLocation ?? const LatLng(-6.2088, 106.8456),
                      zoom: 12,
                    ),
                    markers: markers,
                    polylines: polylines,
                    myLocationEnabled: true,
                    myLocationButtonEnabled: true,
                    onTap: _reverseGeocode,
                  ),
          ),
        ],
      ),
    );
  }
}

/// Utility class for common Google Maps operations
class MapsUtils {
  /// Calculate distance between two points
  static double calculateDistance(LatLng start, LatLng end) {
    return GoogleMapsService.calculateDistance(start, end);
  }

  /// Format distance for display
  static String formatDistance(double meters) {
    return GoogleMapsService.formatDistance(meters);
  }

  /// Format duration for display
  static String formatDuration(int seconds) {
    return GoogleMapsService.formatDuration(seconds);
  }

  /// Check if a point is within radius
  static bool isWithinRadius(LatLng center, LatLng point, double radiusMeters) {
    return GoogleMapsService.isWithinRadius(center, point, radiusMeters);
  }

  /// Get place photo URL
  static String? getPlacePhotoUrl(String photoReference) {
    return GoogleMapsService.getPlacePhotoUrl(photoReference);
  }

  /// Get place predictions for autocomplete
  static Future<List<dynamic>> getPlacePredictions(String input) async {
    return await GoogleMapsService.getPlacePredictions(input);
  }

  /// Get detailed place information
  static Future<dynamic> getPlaceDetails(String placeId) async {
    return await GoogleMapsService.getPlaceDetails(placeId);
  }
}
