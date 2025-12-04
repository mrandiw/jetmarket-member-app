# Google Maps APIs Usage Guide

This guide explains how to use all the Google Maps APIs that have been set up in your Flutter application.

## 🗺️ Available APIs

### ✅ Configured APIs:
- **Maps SDK for Android** - Display interactive maps
- **Maps SDK for iOS** - Display interactive maps
- **Places API** - Search for places, get place details
- **Geocoding API** - Convert addresses to coordinates
- **Geolocation API** - Get device location
- **Distance Matrix API** - Calculate distances between multiple points
- **Directions API** - Get routes and navigation

## 🔑 API Key Configuration

The Google Maps API key `AIzaSyDmXmlu1X44Ng4K9ew1UtEOa90GF8w0RvQ` is configured in:
- `assets/env/.env` - Environment variable
- `android/app/src/main/AndroidManifest.xml` - Android configuration
- `ios/Runner/AppDelegate.swift` - iOS configuration
- `lib/utils/google_maps_service.dart` - Service utility

## 📦 Dependencies

Required packages in `pubspec.yaml`:
```yaml
google_maps_flutter: ^2.5.0
geolocator: ^10.1.0
geocoding: ^2.1.1
flutter_polyline_points: ^2.0.0
google_places_sdk: ^0.4.0
flutter_dotenv: ^5.1.0
```

## 🚀 Quick Start

### 1. Basic Map Display

```dart
import 'package:google_maps_flutter/google_maps_flutter.dart';

GoogleMap(
  initialCameraPosition: CameraPosition(
    target: LatLng(-6.2088, 106.8456), // Jakarta
    zoom: 12,
  ),
  myLocationEnabled: true,
  myLocationButtonEnabled: true,
)
```

### 2. Get Current Location

```dart
import '../utils/google_maps_service.dart';

final position = await GoogleMapsService.getCurrentLocation();
if (position != null) {
  final latLng = LatLng(position.latitude, position.longitude);
  // Use the location
}
```

### 3. Search for Places

```dart
// Search by query
final places = await GoogleMapsService.searchPlaces('restaurants in Jakarta');

// Search nearby places
final nearbyPlaces = await GoogleMapsService.searchNearbyPlaces(
  currentLocation,
  'restaurant',
  radius: 1000,
);
```

### 4. Geocoding (Address to Coordinates)

```dart
final coordinates = await GoogleMapsService.geocode('Monas, Jakarta');
if (coordinates != null) {
  print('Lat: ${coordinates.latitude}, Lng: ${coordinates.longitude}');
}
```

### 5. Reverse Geocoding (Coordinates to Address)

```dart
final address = await GoogleMapsService.reverseGeocode(
  LatLng(-6.2088, 106.8456),
);
print('Address: $address');
```

### 6. Get Directions & Draw Route

```dart
// Get directions
final directions = await GoogleMapsService.getDirections(
  origin,
  destination,
  travelMode: 'driving',
);

// Get polyline points for drawing route
final polylinePoints = await GoogleMapsService.getPolylinePoints(
  origin,
  destination,
);

// Draw on map
setState(() {
  _polylines.add(Polyline(
    polylineId: PolylineId('route'),
    points: polylinePoints,
    color: Colors.blue,
    width: 5,
  ));
});
```

### 7. Distance Matrix

```dart
final matrix = await GoogleMapsService.getDistanceMatrix(
  [origin1, origin2], // Multiple origins
  [destination1, destination2], // Multiple destinations
  travelMode: 'driving',
);

// Process results
if (matrix != null) {
  final rows = matrix['rows'];
  for (final row in rows) {
    final elements = row['elements'];
    // Process each element
  }
}
```

## 🛠️ Advanced Usage Examples

### Place Autocomplete

```dart
final predictions = await GoogleMapsService.getPlacePredictions('Jakarta');
for (final prediction in predictions) {
  print('${prediction['description']} (${prediction['place_id']})');
}
```

### Get Place Details

```dart
final placeDetails = await GoogleMapsService.getPlaceDetails(placeId);
if (placeDetails != null) {
  print('Name: ${placeDetails['name']}');
  print('Address: ${placeDetails['formatted_address']}');
  print('Rating: ${placeDetails['rating']}');
  print('Photos: ${placeDetails['photos']}');
}
```

### Get Place Photos

```dart
final photoUrl = GoogleMapsService.getPlacePhotoUrl(
  photoReference,
  maxWidth: 400,
  maxHeight: 400,
);

// Display in Image widget
Image.network(photoUrl!)
```

### Calculate Distance & Duration

```dart
// Direct distance calculation
final distance = GoogleMapsService.calculateDistance(start, end);
print('Distance: ${GoogleMapsService.formatDistance(distance)}');

// From directions API
final directions = await GoogleMapsService.getDirections(start, end);
if (directions != null) {
  final route = directions['routes'][0];
  final leg = route['legs'][0];
  final distance = leg['distance']['text'];
  final duration = leg['duration']['text'];
  print('Distance: $distance, Duration: $duration');
}
```

### Location Within Radius Check

```dart
final isWithinRadius = GoogleMapsService.isWithinRadius(
  center,
  point,
  radiusInMeters: 1000,
);

if (isWithinRadius) {
  print('Point is within 1km radius');
}
```

## 🎨 Map Customization

### Custom Markers

```dart
Marker(
  markerId: MarkerId('custom_marker'),
  position: LatLng(lat, lng),
  icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
  infoWindow: InfoWindow(
    title: 'Custom Marker',
    snippet: 'Tap for more info',
  ),
  onTap: () {
    // Handle marker tap
  },
)
```

### Custom Polylines

```dart
Polyline(
  polylineId: PolylineId('custom_route'),
  points: routePoints,
  color: Colors.red,
  width: 5,
  patterns: [PatternItem.dash(10), PatternItem.gap(5)],
)
```

### Map Styles

```dart
GoogleMap(
  initialCameraPosition: CameraPosition(...),
  mapType: MapType.normal,
  // or MapType.satellite, MapType.hybrid, MapType.terrain
)
```

## 🔧 Error Handling

```dart
try {
  final position = await GoogleMapsService.getCurrentLocation();
  if (position == null) {
    // Handle null result
    print('Could not get location');
  } else {
    // Use location
  }
} catch (e) {
  // Handle exceptions
  print('Error getting location: $e');
}
```

## 📱 Permissions

### Android Permissions
Already configured in `AndroidManifest.xml`:
```xml
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION"/>
<uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION"/>
```

### iOS Permissions
Already configured in `Info.plist`:
```xml
<key>NSLocationWhenInUseUsageDescription</key>
<string>This app needs access to location when in use...</string>
```

## 🎯 Common Use Cases

### 1. Location Picker
Use `lib/components/location_picker/modern_location_picker.dart` for a complete location picker implementation.

### 2. Store Finder
```dart
final stores = await GoogleMapsService.searchNearbyPlaces(
  userLocation,
  'store',
  radius: 5000,
);
```

### 3. Delivery Tracking
```dart
final directions = await GoogleMapsService.getDirections(
  restaurant,
  customer,
);
final estimatedTime = directions['routes'][0]['legs'][0]['duration']['value'];
```

### 4. Route Planning
```dart
final stops = [LatLng(-6.2, 106.8), LatLng(-6.3, 106.9), LatLng(-6.4, 107.0)];
final matrix = await GoogleMapsService.getDistanceMatrix(
  [userLocation],
  stops,
);
// Find nearest stop
```

## 🧪 Testing

You can test all functionality using the example file:
`lib/examples/google_maps_examples.dart`

To run the example:
1. Add the example to your app's navigation
2. Navigate to the `GoogleMapsExamples` screen
3. Test each API using the provided buttons

## 📝 Best Practices

1. **API Key Security**: Never hardcode API keys in your code
2. **Error Handling**: Always handle API failures gracefully
3. **Caching**: Cache frequently accessed location data
4. **Battery Life**: Use appropriate location accuracy settings
5. **User Experience**: Show loading indicators during API calls
6. **Rate Limits**: Implement request throttling if needed

## 🔍 Troubleshooting

### Common Issues:
1. **Maps not loading**: Check API key configuration
2. **Location permission denied**: Handle permissions properly
3. **API quota exceeded**: Monitor usage in Google Cloud Console
4. **Network errors**: Implement retry logic
5. **Invalid coordinates**: Validate input data

### Debug Tips:
- Use `debugPrint()` to log API responses
- Check network connectivity before API calls
- Test with different locations and scenarios
- Monitor API usage in Google Cloud Console

## 📚 Additional Resources

- [Google Maps Platform Documentation](https://developers.google.com/maps)
- [Flutter Google Maps Package](https://pub.dev/packages/google_maps_flutter)
- [Geolocator Package](https://pub.dev/packages/geolocator)
- [Google Places API](https://developers.google.com/maps/documentation/places/web-service)

---

**API Key**: `AIzaSyDmXmlu1X44Ng4K9ew1UtEOa90GF8w0RvQ`
**Project Setup**: Complete ✅
**All APIs**: Configured and Ready to Use! 🚀
