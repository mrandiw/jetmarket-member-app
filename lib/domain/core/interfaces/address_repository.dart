import 'package:jetmarket/domain/core/model/model_data/address_model.dart';
import 'package:jetmarket/domain/core/model/model_data/location_model.dart';
import 'package:jetmarket/domain/core/model/params/address/address_param.dart';
import 'package:jetmarket/utils/network/data_state.dart';
import '../model/params/address/address_body.dart';
import '../model/params/location_param.dart';

abstract class AddressRepository {
  Future<DataState<List<LocationModel>>> getSearchLocation(LocationParam param);
  Future<DataState<List<LocationModel>>> getLocation(dynamic param);
  Future<DataState<List<AddressModel>>> getAddress(AddressParam param);
  Future<DataState<String>> addAddress(AddressBody body);
  Future<DataState<String>> editAddress(AddressBody body);
  Future<DataState<List<AddressModel>>> getAddressMain(AddressParam param);
}
