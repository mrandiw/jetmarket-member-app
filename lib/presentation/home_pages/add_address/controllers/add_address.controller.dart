import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jetmarket/domain/core/interfaces/address_repository.dart';
import 'package:jetmarket/domain/core/model/model_data/location_model.dart';
import 'package:jetmarket/domain/core/model/params/location_param.dart';
import 'package:jetmarket/infrastructure/navigation/routes.dart';
import 'package:jetmarket/utils/path/environment.dart';

import '../../../../utils/debouncer.dart';

enum ResultLocation { success, error, empty, loading }

class AddAddressController extends GetxController {
  final AddressRepository _addressRepository;
  AddAddressController(this._addressRepository);
  TextEditingController searchController = TextEditingController();
  var resultLocation = ResultLocation.empty;
  List<LocationModel> locations = [];

  final Debouncer _debouncer = Debouncer(milliseconds: 1000);
  void searchLocation(String query) async {
    resultLocation = ResultLocation.loading;
    update();
    _debouncer.run(() async {
      var param = LocationParam(input: query, key: apiKey);
      final response = await _addressRepository.getSearchLocation(param);
      if (response.result != null) {
        locations.assignAll(response.result!);
        resultLocation = ResultLocation.success;
        update();
      } else {
        resultLocation = ResultLocation.empty;
        locations.clear();
        update();
      }
    });
  }

  void toLocationMap(LocationModel location) {
    print("Lat halaman 1 : ${location.latitude}");
    print("Lat halaman 2 : ${location.longitude}");
    Get.toNamed(Routes.LOCATION, arguments: {
      "lat": location.latitude,
      "lng": location.longitude,
      "with-latlong": true
    });
  }
}
