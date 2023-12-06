import 'package:jetmarket/domain/core/model/model_data/location_model.dart';
import 'package:jetmarket/utils/network/data_state.dart';

import '../model/params/location_param.dart';

abstract class AddressRepository {
  Future<DataState<List<LocationModel>>> getSearchLocation(LocationParam param);
  Future<DataState<List<LocationModel>>> getLocation(dynamic param);
}
