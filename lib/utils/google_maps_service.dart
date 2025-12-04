import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart' as polyline;
import 'package:dio/dio.dart';

class GoogleMapsService {
  static String get _apiKey => dotenv.env['GOOGLE_MAPS_API_KEY'] ?? 'AIzaSyDmXmlu1X44Ng4K9ew1UtEOa90GF8w0RvQ';
  
  // Dio untuk HTTP requests
  static final Dio _dio = Dio();
  
  /// Get current location of the device
  static Future<Position?> getCurrentLocation() async {
    try {
      // Check if location services are enabled
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        throw Exception('Location services are disabled.');
      }

      // Check location permissions
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          throw Exception('Location permissions are denied');
        }
      }

      if (permission == LocationPermission.deniedForever) {
        throw Exception('Location permissions are permanently denied');
      }

      // Get current position
      return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
        timeLimit: const Duration(seconds: 10),
      );
    } catch (e) {
      debugPrint('Error getting current location: $e');
      return null;
    }
  }

  /// Convert address to coordinates (geocoding)
  static Future<LatLng?> geocode(String address) async {
    try {
      List<Location> locations = await locationFromAddress(address);
      if (locations.isNotEmpty) {
        return LatLng(locations.first.latitude, locations.first.longitude);
      }
      return null;
    } catch (e) {
      debugPrint('Error geocoding address: $e');
      return null;
    }
  }

  /// Convert coordinates to address (reverse geocoding)
  static Future<String?> reverseGeocode(LatLng position) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      
      if (placemarks.isNotEmpty) {
        Placemark place = placemarks.first;
        return '${place.street}, $place.subLocality, $place.locality, $place.administrativeArea, $place.country}';
      }
      return null;
    } catch (e) {
      debugPrint('Error reverse geocoding: $e');
      return null;
    }
  }

  /// Search for places using Places API
  static Future<List<dynamic>> searchPlaces(String query) async {
    try {
      final String url = 'https://maps.googleapis.com/maps/api/place/textsearch/json'
          '?query=${Uri.encodeComponent(query)}'
          '&key=$_apiKey';
      
      final response = await _dio.get(url);
      if (response.statusCode == 200) {
        return response.data['results'] ?? [];
      }
      return [];
    } catch (e) {
      debugPrint('Error searching places: $e');
      return [];
    }
  }

  /// Get place details by place ID
  static Future<dynamic> getPlaceDetails(String placeId) async {
    try {
      final String url = 'https://maps.googleapis.com/maps/api/place/details/json'
          '?place_id=$placeId'
          '&key=$_apiKey';
      
      final response = await _dio.get(url);
      if (response.statusCode == 200) {
        return response.data['result'];
      }
      return null;
    } catch (e) {
      debugPrint('Error getting place details: $e');
      return null;
    }
  }

  /// Get autocomplete predictions for place search
  static Future<List<dynamic>> getPlacePredictions(String input) async {
    try {
      final String url = 'https://maps.googleapis.com/maps/api/place/autocomplete/json'
          '?input=${Uri.encodeComponent(input)}'
          '&key=$_apiKey';
      
      final response = await _dio.get(url);
      if (response.statusCode == 200) {
        return response.data['predictions'] ?? [];
      }
      return [];
    } catch (e) {
      debugPrint('Error getting place predictions: $e');
      return [];
    }
  }

  /// Calculate distance between two points in meters
  static double calculateDistance(LatLng start, LatLng end) {
    return Geolocator.distanceBetween(
      start.latitude,
      start.longitude,
      end.latitude,
      end.longitude,
    );
  }

  /// Get directions between two points
  static Future<dynamic> getDirections(
    LatLng origin,
    LatLng destination, {
    String travelMode = 'driving',
  }) async {
    try {
      final String url = 'https://maps.googleapis.com/maps/api/directions/json'
          '?origin=${origin.latitude},${origin.longitude}'
          '&destination=${destination.latitude},${destination.longitude}'
          '&mode=$travelMode'
          '&key=$_apiKey';
      
      final response = await _dio.get(url);
      if (response.statusCode == 200) {
        return response.data;
      }
      return null;
    } catch (e) {
      debugPrint('Error getting directions: $e');
      return null;
    }
  }

  /// Get polyline points for drawing route on map
  static Future<List<LatLng>> getPolylinePoints(
    LatLng origin,
    LatLng destination, {
    String travelMode = 'driving',
  }) async {
    try {
      polyline.PolylineResult result = await polyline.PolylinePoints().getRouteBetweenCoordinates(
        request: polyline.PolylineRequest(
          origin: polyline.PointLatLng(origin.latitude, origin.longitude),
          destination: polyline.PointLatLng(destination.latitude, destination.longitude),
          mode: polyline.TravelMode.driving,
        ),
        googleApiKey: _apiKey,
      );

      if (result.points.isNotEmpty) {
        return result.points
            .map((point) => LatLng(point.latitude, point.longitude))
            .toList();
      }
      return [];
    } catch (e) {
      debugPrint('Error getting polyline points: $e');
      return [];
    }
  }

  /// Get distance matrix for multiple origins and destinations
  static Future<dynamic> getDistanceMatrix(
    List<LatLng> origins,
    List<LatLng> destinations, {
    String travelMode = 'driving',
  }) async {
    try {
      String originStr = origins
          .map((latLng) => '${latLng.latitude},${latLng.longitude}')
          .join('|');
      String destinationStr = destinations
          .map((latLng) => '${latLng.latitude},${latLng.longitude}')
          .join('|');
      
      final String url = 'https://maps.googleapis.com/maps/api/distancematrix/json'
          '?origins=$originStr'
          '&destinations=$destinationStr'
          '&mode=$travelMode'
          '&key=$_apiKey';
      
      final response = await _dio.get(url);
      if (response.statusCode == 200) {
        return response.data;
      }
      return null;
    } catch (e) {
      debugPrint('Error getting distance matrix: $e');
      return null;
    }
  }

  /// Format distance in human readable format
  static String formatDistance(double meters) {
    if (meters < 1000) {
      return '${meters.round()} m';
    } else {
      double km = meters / 1000;
      return '${km.toStringAsFixed(1)} km';
    }
  }

  /// Format duration in human readable format
  static String formatDuration(int seconds) {
    int hours = seconds ~/ 3600;
    int minutes = (seconds % 3600) ~/ 60;

    if (hours > 0) {
      return '${hours}h ${minutes}min';
    } else {
      return '$minutes min';
    }
  }

  /// Search for nearby places
  static Future<List<dynamic>> searchNearbyPlaces(
    LatLng location,
    String type, {
    double radius = 1000, // radius in meters
  }) async {
    try {
      final String url = 'https://maps.googleapis.com/maps/api/place/nearbysearch/json'
          '?location=${location.latitude},${location.longitude}'
          '&radius=$radius'
          '&type=$type'
          '&key=$_apiKey';
      
      final response = await _dio.get(url);
      if (response.statusCode == 200) {
        return response.data['results'] ?? [];
      }
      return [];
    } catch (e) {
      debugPrint('Error searching nearby places: $e');
      return [];
    }
  }

  /// Get photo URL for a place
  static String? getPlacePhotoUrl(
    String photoReference, {
    int maxWidth = 400,
    int maxHeight = 400,
  }) {
    try {
      return 'https://maps.googleapis.com/maps/api/photo'
          '?maxwidth=$maxWidth'
          '&maxheight=$maxHeight'
          '&photoreference=$photoReference'
          '&key=$_apiKey';
    } catch (e) {
      debugPrint('Error getting place photo URL: $e');
      return null;
    }
  }

  /// Validate if a location is within a certain radius
  static bool isWithinRadius(
    LatLng center,
    LatLng point,
    double radiusInMeters,
  ) {
    double distance = calculateDistance(center, point);
    return distance <= radiusInMeters;
  }
}

/// Travel mode enum for directions
enum TravelMode {
  driving,
  walking,
  bicycling,
  transit,
}
