import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../utils/google_maps_service.dart';
import '../loading/load_pages.dart';
import '../../infrastructure/theme/app_colors.dart';
import '../../infrastructure/theme/app_text.dart';
import '../../presentation/home_pages/location/section/constants.dart';

class ModernLocationPicker extends StatefulWidget {
  final LatLng? initialLocation;
  final Function(LatLng location, String address) onLocationSelected;
  final String? title;
  final bool enableSearch;
  final bool enableCurrentLocation;

  const ModernLocationPicker({
    super.key,
    this.initialLocation,
    required this.onLocationSelected,
    this.title,
    this.enableSearch = true,
    this.enableCurrentLocation = true,
  });

  @override
  State<ModernLocationPicker> createState() => _ModernLocationPickerState();
}

class _ModernLocationPickerState extends State<ModernLocationPicker> {
  GoogleMapController? _mapController;
  LatLng? _selectedLocation;
  String _selectedAddress = '';
  Set<Marker> _markers = {};
  bool _isLoading = false;
  final TextEditingController _searchController = TextEditingController();
  List<String> _searchSuggestions = [];
  bool _showSuggestions = false;

  @override
  void initState() {
    super.initState();
    _selectedLocation = widget.initialLocation ?? const LatLng(-6.2088, 106.8456); // Jakarta
    _initializeLocation();
    _updateMarker();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _initializeLocation() async {
    setState(() => _isLoading = true);
    
    try {
      if (widget.initialLocation == null) {
        Position? currentPos = await GoogleMapsService.getCurrentLocation();
        if (currentPos != null) {
          _selectedLocation = LatLng(currentPos.latitude, currentPos.longitude);
          _mapController?.animateCamera(
            CameraUpdate.newLatLngZoom(_selectedLocation!, 15),
          );
        }
      }
      
      await _updateAddress();
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _updateMarker() {
    if (_selectedLocation != null) {
      _markers = {
        Marker(
          markerId: const MarkerId('selected_location'),
          position: _selectedLocation!,
          infoWindow: const InfoWindow(title: 'Selected Location'),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        ),
      };
    }
  }

  Future<void> _updateAddress() async {
    if (_selectedLocation != null) {
      String? address = await GoogleMapsService.reverseGeocode(_selectedLocation!);
      setState(() {
        _selectedAddress = address ?? 'Unknown location';
      });
    }
  }

  Future<void> _onMapTap(LatLng location) async {
    setState(() {
      _selectedLocation = location;
      _updateMarker();
    });
    
    await _updateAddress();
    _mapController?.animateCamera(CameraUpdate.newLatLng(location));
  }

  Future<void> _getCurrentLocation() async {
    setState(() => _isLoading = true);
    
    try {
      // Check permissions
      var status = await Permission.location.status;
      if (!status.isGranted) {
        status = await Permission.location.request();
        if (!status.isGranted) {
          Get.snackbar(
            'Permission Denied',
            'Location permission is required to get your current location',
            backgroundColor: kErrorColor,
            colorText: Colors.white,
          );
          return;
        }
      }

      Position? position = await GoogleMapsService.getCurrentLocation();
      if (position != null) {
        final newLocation = LatLng(position.latitude, position.longitude);
        setState(() {
          _selectedLocation = newLocation;
          _updateMarker();
        });
        
        await _updateAddress();
        _mapController?.animateCamera(
          CameraUpdate.newLatLngZoom(newLocation, 15),
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to get current location: $e',
        backgroundColor: kErrorColor,
        colorText: Colors.white,
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _searchPlaces(String query) async {
    if (query.isEmpty) {
      setState(() {
        _searchSuggestions = [];
        _showSuggestions = false;
      });
      return;
    }

    try {
      final predictions = await GoogleMapsService.getPlacePredictions(query);
      setState(() {
        _searchSuggestions = predictions.map<String>((p) => p.description ?? '').toList();
        _showSuggestions = true;
      });
    } catch (e) {
      debugPrint('Error searching places: $e');
    }
  }

  Future<void> _selectSuggestion(String place) async {
    setState(() {
      _searchController.text = place;
      _showSuggestions = false;
    });

    try {
      final location = await GoogleMapsService.geocode(place);
      if (location != null) {
        setState(() {
          _selectedLocation = location;
          _updateMarker();
        });
        
        await _updateAddress();
        _mapController?.animateCamera(
          CameraUpdate.newLatLngZoom(location, 15),
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to find location: $e',
        backgroundColor: kErrorColor,
        colorText: Colors.white,
      );
    }
  }

  void _confirmLocation() {
    if (_selectedLocation != null && _selectedAddress.isNotEmpty) {
      widget.onLocationSelected(_selectedLocation!, _selectedAddress);
      Get.back();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title ?? 'Select Location'),
        backgroundColor: AppColors.primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Stack(
        children: [
          // Map
          GoogleMap(
            initialCameraPosition: const CameraPosition(
              target: LatLng(-6.2088, 106.8456),
              zoom: 15,
            ),
            onMapCreated: (GoogleMapController controller) {
              _mapController = controller;
            },
            onTap: _onMapTap,
            markers: _markers,
            myLocationEnabled: true,
            myLocationButtonEnabled: false, // We'll use custom button
            zoomControlsEnabled: true,
            mapType: MapType.normal,
            compassEnabled: true,
          ),

          // Search bar
          if (widget.enableSearch)
            Positioned(
              top: 16.h,
              left: 16.w,
              right: 16.w,
              child: Card(
                elevation: 4,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                child: Column(
                  children: [
                    TextField(
                      controller: _searchController,
                      onChanged: _searchPlaces,
                      decoration: InputDecoration(
                        hintText: 'Search for a place...',
                        prefixIcon: const Icon(Icons.search, color: AppColors.primaryColor),
                        suffixIcon: _searchController.text.isNotEmpty
                            ? IconButton(
                                icon: const Icon(Icons.clear),
                                onPressed: () {
                                  _searchController.clear();
                                  setState(() {
                                    _searchSuggestions = [];
                                    _showSuggestions = false;
                                  });
                                },
                              )
                            : null,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 12.h,
                        ),
                      ),
                    ),
                    
                    // Search suggestions
                    if (_showSuggestions && _searchSuggestions.isNotEmpty)
                      Container(
                        height: 200.h,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(12),
                            bottomRight: Radius.circular(12),
                          ),
                        ),
                        child: ListView.builder(
                          itemCount: _searchSuggestions.length,
                          itemBuilder: (context, index) {
                            final suggestion = _searchSuggestions[index];
                            return ListTile(
                              title: Text(suggestion),
                              leading: const Icon(Icons.location_on, color: AppColors.primaryColor),
                              onTap: () => _selectSuggestion(suggestion),
                            );
                          },
                        ),
                      ),
                  ],
                ),
              ),
            ),

          // Current location button
          if (widget.enableCurrentLocation)
            Positioned(
              bottom: 120.h,
              right: 16.w,
              child: FloatingActionButton(
                heroTag: "current_location",
                onPressed: _getCurrentLocation,
                backgroundColor: AppColors.primaryColor,
                mini: true,
                child: const Icon(
                  Icons.my_location,
                  color: Colors.white,
                ),
              ),
            ),

          // Confirm button
          Positioned(
            bottom: 16.h,
            left: 16.w,
            right: 16.w,
            child: Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Selected Address:',
                    style: text12HintRegular.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    _selectedAddress,
                    style: text14BlackRegular,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 12.h),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _confirmLocation,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                      ),
                      child: Text(
                        'Confirm Location',
                        style: text14BlackSemiBold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Loading overlay
          if (_isLoading)
            Container(
              color: Colors.black.withOpacity(0.3),
              child: const Center(
                child: LoadingPages(),
              ),
            ),
        ],
      ),
    );
  }
}

// Custom marker for the center of the map
class CenterMarker extends StatelessWidget {
  const CenterMarker({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40.w,
      height: 40.w,
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: const Icon(
        Icons.location_on,
        color: Colors.white,
        size: 24,
      ),
    );
  }
}

// Animated pin marker
class AnimatedPinMarker extends StatefulWidget {
  const AnimatedPinMarker({super.key});

  @override
  State<AnimatedPinMarker> createState() => _AnimatedPinMarkerState();
}

class _AnimatedPinMarkerState extends State<AnimatedPinMarker>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _animation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.scale(
          scale: _animation.value,
          child: Container(
              width: 50.w,
              height: 50.w,
              decoration: const BoxDecoration(
                color: AppColors.primaryColor,
                shape: BoxShape.circle,
              ),
            child: Center(
              child: Container(
                width: 30.w,
                height: 30.w,
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.location_on,
                  color: Colors.white,
                  size: 18,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
