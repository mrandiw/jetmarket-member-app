import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:jetmarket/infrastructure/dal/repository/address_repository_impl.dart';
import 'package:jetmarket/infrastructure/theme/app_colors.dart';
import 'package:jetmarket/presentation/home_pages/location/controllers/location.controller.dart';

class MapsSection extends StatelessWidget {
  const MapsSection({super.key});

  @override
  Widget build(BuildContext context) {
    late GoogleMapController gmapsControl;
    return GetBuilder<LocationController>(
        init: LocationController(AddressRepositoryImpl()),
        builder: (controller) {
          return SizedBox(
            height: Get.height,
            width: Get.width,
            child: !controller.isLoading
                ? GoogleMap(
                    onTap: (latLng) => controller.onTapMaps(latLng),
                    mapType: MapType.normal,
                    myLocationEnabled: true,
                    initialCameraPosition: CameraPosition(
                        target:
                            LatLng(controller.latitude, controller.longitude),
                        zoom: 14),
                    gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
                      Factory<OneSequenceGestureRecognizer>(
                        () => EagerGestureRecognizer(),
                      ),
                    },
                    mapToolbarEnabled: false,
                    zoomGesturesEnabled: true,
                    zoomControlsEnabled: false,
                    scrollGesturesEnabled: true,
                    myLocationButtonEnabled: true,
                    onMapCreated: (GoogleMapController controller) {
                      gmapsControl = controller;
                    },
                    markers: {
                      Marker(
                        markerId: const MarkerId(""),
                        position:
                            LatLng(controller.latitude, controller.longitude),
                        draggable: true,
                      )
                    })
                : const Center(
                    child: CircularProgressIndicator(
                      color: kPrimaryColor,
                    ),
                  ),
          );
        });
  }
}
