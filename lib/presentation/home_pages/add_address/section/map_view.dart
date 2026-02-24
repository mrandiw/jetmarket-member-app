import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:jetmarket/components/location_picker/enhanced_location_picker.dart';
import 'package:jetmarket/infrastructure/theme/app_colors.dart';
import 'package:jetmarket/infrastructure/theme/app_text.dart';

class MapView extends StatelessWidget {
  final double lat;
  final double lng;
  final Function(double lat, double lng, String address, String postalCode)? onLocationSelected;

  const MapView({
    super.key,
    required this.lat,
    required this.lng,
    this.onLocationSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Location picker button
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: kPrimaryColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Column(
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
                    child: Text(
                      'Lokasi Dipilih',
                      style: text14BlackMedium.copyWith(
                        color: kPrimaryColor,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      await Get.to(() => EnhancedLocationPicker(
                        title: 'Pilih Lokasi Alamat',
                        initialLocation: LatLng(lat, lng),
                        onLocationSelected: (location, address, postalCode) {
                          if (onLocationSelected != null) {
                            onLocationSelected!(location.latitude, location.longitude, address, postalCode);
                          }
                        },
                      ));
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                      decoration: BoxDecoration(
                        color: kPrimaryColor,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.edit,
                            color: Colors.white,
                            size: 16.r,
                          ),
                          Gap(4.w),
                          Text(
                            'Ubah Lokasi',
                            style: text12BlackRegular.copyWith(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Gap(8.h),
              Text(
                'Koordinat: ${lat.toStringAsFixed(6)}, ${lng.toStringAsFixed(6)}',
                style: text10HintRegular,
              ),
            ],
          ),
        ),
        Gap(12.h),
        // Static map display
        Container(
          height: 250.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: kSoftGrey),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12.r),
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(lat, lng),
                zoom: 15,
              ),
              markers: {
                Marker(
                  markerId: const MarkerId('current_location'),
                  position: LatLng(lat, lng),
                  icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
                  infoWindow: const InfoWindow(title: 'Selected Location'),
                ),
              },
              zoomControlsEnabled: true,
              myLocationEnabled: true,
              myLocationButtonEnabled: false, // Disabled since we have custom button
              mapType: MapType.normal,
              compassEnabled: true,
              scrollGesturesEnabled: false, // Static display
              zoomGesturesEnabled: false, // Static display
            ),
          ),
        ),
      ],
    );
  }
}

// Enhanced map view with location picker integration
class EnhancedMapView extends StatelessWidget {
  final double? lat;
  final double? lng;
  final Function(double lat, double lng, String address, String postalCode)? onLocationSelected;
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
                            builder: (context) => EnhancedLocationPicker(
                              title: title ?? 'Select Location',
                              initialLocation: lat != null && lng != null
                                  ? LatLng(lat!, lng!)
                                  : null,
                              onLocationSelected: (location, address, postalCode) {
                                if (onLocationSelected != null) {
                                  onLocationSelected!(
                                    location.latitude,
                                    location.longitude,
                                    address,
                                    postalCode,
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
