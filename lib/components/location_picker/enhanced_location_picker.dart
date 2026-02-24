import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:jetmarket/utils/google_maps_service.dart';
import 'package:geocoding/geocoding.dart';
import 'package:gap/gap.dart';
import '../loading/load_pages.dart';
import '../../infrastructure/theme/app_colors.dart';
import '../../infrastructure/theme/app_text.dart';

class EnhancedLocationPicker extends StatefulWidget {
  final LatLng? initialLocation;
  final String? initialAddress;
  final Function(LatLng location, String address, String postalCode) onLocationSelected;
  final String? title;

  const EnhancedLocationPicker({
    super.key,
    this.initialLocation,
    this.initialAddress,
    required this.onLocationSelected,
    this.title,
  });

  @override
  State<EnhancedLocationPicker> createState() => _EnhancedLocationPickerState();
}

class _EnhancedLocationPickerState extends State<EnhancedLocationPicker> {
  GoogleMapController? _mapController;
  LatLng? _selectedLocation;
  String _selectedAddress = '';
  String _postalCode = '';
  Set<Marker> _markers = {};
  bool _isLoading = false;
  bool _isSearching = false;
  final TextEditingController _searchController = TextEditingController();
  List<String> _searchSuggestions = [];
  bool _showSuggestions = false;
  bool _isDragging = false;
  Timer? _cameraMoveTimer;

  @override
  void initState() {
    super.initState();
    _initializeLocation();
    _updateMarker();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _cameraMoveTimer?.cancel();
    super.dispose();
  }

  Future<void> _initializeLocation() async {
    setState(() => _isLoading = true);
    
    try {
      if (widget.initialLocation != null) {
        _selectedLocation = widget.initialLocation;
        _selectedAddress = widget.initialAddress ?? '';
        await _updateAddressFromCoordinates();
      } else {
        // Try to get current location
        Position? currentPos = await GoogleMapsService.getCurrentLocation();
        if (currentPos != null) {
          _selectedLocation = LatLng(currentPos.latitude, currentPos.longitude);
          await _updateAddressFromCoordinates();
        } else {
          // Fallback to Jakarta
          _selectedLocation = const LatLng(-6.2088, 106.8456);
        }
      }
      
      _moveToLocation(_selectedLocation!);
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
          infoWindow: InfoWindow(
            title: 'Lokasi Dipilih',
            snippet: _selectedAddress.isNotEmpty ? _selectedAddress : 'Geser pin untuk memilih lokasi',
          ),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
          draggable: true,
          onDragStart: (_) {
            setState(() => _isDragging = true);
          },
          onDragEnd: (newLocation) {
            _updateLocationFromPin(newLocation);
            setState(() => _isDragging = false);
          },
        ),
      };
    }
  }

  void _updateMarkerPositionOnly() {
    // Update marker position only without triggering geocoding
    if (_selectedLocation != null) {
      _markers = {
        Marker(
          markerId: const MarkerId('selected_location'),
          position: _selectedLocation!,
          infoWindow: InfoWindow(
            title: 'Lokasi Dipilih',
            snippet: _selectedAddress.isNotEmpty ? _selectedAddress : 'Geser pin untuk memilih lokasi',
          ),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
          draggable: true,
          onDragStart: (_) {
            setState(() => _isDragging = true);
          },
          onDragEnd: (newLocation) {
            _updateLocationFromPin(newLocation);
            setState(() => _isDragging = false);
          },
        ),
      };
    }
  }

  Future<void> _updateAddressFromCoordinates() async {
    if (_selectedLocation != null) {
      try {
        List<Placemark> placemarks = await placemarkFromCoordinates(
          _selectedLocation!.latitude,
          _selectedLocation!.longitude,
        );
        
        if (placemarks.isNotEmpty) {
          Placemark place = placemarks.first;
          _selectedAddress = _formatAddress(place);
          _postalCode = place.postalCode ?? '';
        }
      } catch (e) {
        debugPrint('Error getting address: $e');
      }
      
      // Update UI with new address and postal code
      if (mounted) {
        setState(() {
          _updateMarker();
        });
      }
    }
  }

  String _formatAddress(Placemark place) {
    final parts = <String>[];
    if (place.street?.isNotEmpty == true) parts.add(place.street!);
    if (place.subLocality?.isNotEmpty == true) parts.add(place.subLocality!);
    if (place.locality?.isNotEmpty == true) parts.add(place.locality!);
    if (place.administrativeArea?.isNotEmpty == true) parts.add(place.administrativeArea!);
    if (place.country?.isNotEmpty == true) parts.add(place.country!);
    return parts.join(', ');
  }

  void _updateLocationFromPin(LatLng location) {
    // Cancel any ongoing camera move timer to prevent conflicts
    _cameraMoveTimer?.cancel();
    
    setState(() {
      _selectedLocation = location;
    });
    // Update marker position immediately for smooth movement
    _updateMarkerPositionOnly();
    // Update address after a short delay to ensure smooth drag
    Future.delayed(const Duration(milliseconds: 100), () {
      _updateAddressFromCoordinates();
    });
  }

  void _moveToLocation(LatLng location) {
    _mapController?.animateCamera(
      CameraUpdate.newLatLngZoom(location, 17),
    );
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
            'Izin Ditolak',
            'Izin lokasi diperlukan untuk mendapatkan lokasi Anda',
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
        });
        
        await _updateAddressFromCoordinates();
        _moveToLocation(newLocation);
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Gagal mendapatkan lokasi: $e',
        backgroundColor: kErrorColor,
        colorText: Colors.white,
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _searchPlaces(String query) async {
    debugPrint('Simple search for: "$query"');
    
    if (query.isEmpty) {
      setState(() {
        _searchSuggestions = [];
        _showSuggestions = false;
      });
      return;
    }

    setState(() => _isSearching = true);

    try {
      debugPrint('Calling GoogleMapsService.getPlacePredictions');
      final predictions = await GoogleMapsService.getPlacePredictions(query);
      debugPrint('Got ${predictions.length} predictions');
      
      if (mounted) {
        setState(() {
          _searchSuggestions = predictions.map<String>((p) {
            if (p is Map<String, dynamic>) {
              return p['description'] as String? ?? '';
            }
            return '';
          }).where((s) => s.isNotEmpty).toList();
          _showSuggestions = true;
          _isSearching = false;
          debugPrint('Suggestions: $_searchSuggestions');
        });
      }
    } catch (e) {
      debugPrint('Error searching places: $e');
      if (mounted) {
        setState(() => _isSearching = false);
      }
    }
  }

  Future<void> _selectSuggestion(String place) async {
    debugPrint('Selecting suggestion: $place');
    
    // Hide suggestions immediately
    setState(() {
      _showSuggestions = false;
      _isSearching = false;
    });
    
    // Simple text assignment
    _searchController.text = place;
    
    try {
      final location = await GoogleMapsService.geocode(place);
      if (location != null) {
        setState(() {
          _selectedLocation = location;
        });
        
        await _updateAddressFromCoordinates();
        _moveToLocation(location);
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Gagal menemukan lokasi: $e',
        backgroundColor: kErrorColor,
        colorText: Colors.white,
      );
    }
  }

  void _confirmLocation() {
    if (_selectedLocation != null && _selectedAddress.isNotEmpty) {
      widget.onLocationSelected(_selectedLocation!, _selectedAddress, _postalCode);
      Get.back();
    } else {
      Get.snackbar(
        'Peringatan',
        'Silakan pilih lokasi terlebih dahulu',
        backgroundColor: Colors.orange,
        colorText: Colors.white,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title ?? 'Pilih Lokasi'),
        backgroundColor: kPrimaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Stack(
        children: [
          // Map
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: _selectedLocation ?? const LatLng(-6.2088, 106.8456),
              zoom: 17,
            ),
            onMapCreated: (GoogleMapController controller) {
              _mapController = controller;
              if (_selectedLocation != null) {
                _moveToLocation(_selectedLocation!);
              }
            },
            onTap: (LatLng position) {
              // Handle tap on map to move pin
              _updateLocationFromPin(position);
            },
            onCameraMove: (position) {
              // Only handle camera move when not dragging pin
              if (!_isDragging) {
                // Cancel previous timer
                _cameraMoveTimer?.cancel();
                
                // Update location immediately for smooth pin movement
                _selectedLocation = position.target;
                
                // Debounce marker updates to prevent choppy movement
                _cameraMoveTimer = Timer(const Duration(milliseconds: 16), () {
                  if (mounted) {
                    setState(() {
                      _updateMarkerPositionOnly();
                    });
                  }
                });
              }
            },
            onCameraIdle: () {
              // Update address when camera stops (only if not dragging pin)
              if (!_isDragging && _selectedLocation != null) {
                _updateAddressFromCoordinates();
              }
            },
            markers: _markers,
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            zoomControlsEnabled: true,
            mapType: MapType.normal,
            compassEnabled: true,
          ),

          // Search bar
          Positioned(
            top: 16.h,
            left: 16.w,
            right: 16.w,
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Column(
                children: [
                  TextField(
                    controller: _searchController,
                    onChanged: _searchPlaces,
                    decoration: InputDecoration(
                      hintText: 'Cari alamat atau tempat...',
                      prefixIcon: _isSearching
                          ? SizedBox(
                              width: 20.w,
                              height: 20.w,
                              child: Padding(
                                padding: EdgeInsets.all(12.w),
                                child: const CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(kPrimaryColor),
                                ),
                              ),
                            )
                          : const Icon(Icons.search, color: kPrimaryColor),
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
                            leading: const Icon(Icons.location_on, color: kPrimaryColor),
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
          Positioned(
            bottom: 120.h,
            right: 16.w,
            child: FloatingActionButton(
              heroTag: "current_location",
              onPressed: _getCurrentLocation,
              backgroundColor: kPrimaryColor,
              mini: true,
              child: const Icon(
                Icons.my_location,
                color: Colors.white,
              ),
            ),
          ),

          // Location info and confirm button
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
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        color: kPrimaryColor,
                        size: 20.r,
                      ),
                      Gap(8.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Lokasi Dipilih',
                              style: text12BlackMedium.copyWith(
                                color: Colors.grey[600],
                              ),
                            ),
                            if (_isDragging)
                              Text(
                                'Menyesuaikan lokasi...',
                                style: text10HintRegular.copyWith(
                                  color: Colors.orange,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Gap(8.h),
                  Text(
                    _selectedAddress.isNotEmpty 
                        ? _selectedAddress
                        : 'Geser pin untuk memilih lokasi',
                    style: text14BlackRegular.copyWith(
                      color: _selectedAddress.isNotEmpty 
                          ? Colors.black 
                          : Colors.grey,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (_postalCode.isNotEmpty) ...[
                    Gap(4.h),
                    Text(
                      'Kode Pos: $_postalCode',
                      style: text12HintRegular,
                    ),
                  ],
                  Gap(12.h),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _confirmLocation,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kPrimaryColor,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                      ),
                      child: Text(
                        'Konfirmasi Lokasi',
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
              color: Colors.black.withValues(alpha: 0.3),
              child: const Center(
                child: LoadingPages(),
              ),
            ),
        ],
      ),
    );
  }
}
