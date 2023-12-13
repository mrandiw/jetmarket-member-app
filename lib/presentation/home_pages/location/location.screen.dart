import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:jetmarket/presentation/home_pages/location/section/app_bar_section.dart';
import 'package:jetmarket/presentation/home_pages/location/section/maps_section.dart';

import 'controllers/location.controller.dart';
import 'section/footer_section.dart';

class LocationScreen extends GetView<LocationController> {
  const LocationScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarLocation,
      body: const MapsSection(),
      bottomNavigationBar: const FooterSection(),
    );
  }
}
