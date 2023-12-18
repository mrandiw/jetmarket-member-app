import 'package:dio/dio.dart';
import 'package:jetmarket/domain/core/interfaces/address_repository.dart';
import 'package:jetmarket/infrastructure/dal/daos/provider/endpoint/endpoint.dart';
import 'package:jetmarket/utils/network/data_state.dart';
import '../../../../domain/core/model/model_data/location_model.dart';
import '../../../../domain/core/model/params/location_param.dart';
import '../../../utils/network/code_response.dart';
import '../../../utils/network/custom_exception.dart';
import '../../../utils/path/environment.dart';
import '../daos/provider/remote/remote_provider.dart';

class AddressRepositoryImpl implements AddressRepository {
  @override
  Future<DataState<List<LocationModel>>> getSearchLocation(
      LocationParam param) async {
    try {
      final response = await RemoteProvider.getLocation(
        path: Endpoint.placeAutocomplete,
        queryParameters: param.toMap(),
      );
      List<dynamic> data = response.data['predictions'];
      List<LocationModel> location = [];
      for (var item in data) {
        final responseDetail = await RemoteProvider.getLocation(
            path: Endpoint.placeDatail,
            queryParameters: {
              'place_id': item['place_id'],
              'inputtype': 'textquery',
              'key': apiKey
            });
        List<dynamic> dataDetail =
            responseDetail.data['result']['address_components'];
        print(responseDetail.data['result']['geometry']['location']);
        for (var itemDetail in dataDetail) {
          if (itemDetail['types'].contains('postal_code')) {
            location.add(LocationModel(
                placeName: item['structured_formatting']['main_text'],
                address: "${item['description']} - ${itemDetail['long_name']}",
                latitude: responseDetail.data['result']['geometry']['location']
                    ['lat'],
                longitude: responseDetail.data['result']['geometry']['location']
                    ['lng']));
          }
        }
      }
      return DataState<List<LocationModel>>(
          status: StatusCodeResponse.cek(response: response), result: location);
    } on DioException catch (e) {
      return CustomException<List<LocationModel>>().dio(e);
    }
  }

  @override
  Future<DataState<List<LocationModel>>> getLocation(dynamic param) async {
    try {
      final response = await RemoteProvider.getLocation(
        path: Endpoint.placeAutocomplete,
        queryParameters: {
          'input': param['input'],
          'key': apiKey,
          'location': '${param['lat']},${param['lng']}',
          'radius': '10000',
        },
      );
      dynamic placeId = response.data;
      print(placeId);
      List<LocationModel> location = [];
      // final responseDetail = await RemoteProvider.getLocation(
      //     path: Endpoint.placeDatail,
      //     queryParameters: {
      //       'place_id': placeId,
      //       'inputtype': 'textquery',
      //       'key': apiKey
      //     });
      // List<dynamic> dataDetail =
      //     responseDetail.data['result']['address_components'];
      // print(dataDetail);
      // for (var itemDetail in dataDetail) {
      //   if (itemDetail['types'].contains('postal_code')) {
      //     location.add(LocationModel(
      //         // placeName: item['structured_formatting']['main_text'],
      //         // address: "${item['description']} - ${itemDetail['long_name']}",
      //         latitude: responseDetail.data['result']['geometry']['location']
      //             ['lat'],
      //         longitude: responseDetail.data['result']['geometry']['location']
      //             ['lng']));
      //   }
      // }
      return DataState<List<LocationModel>>(
          status: StatusCodeResponse.cek(response: response), result: location);
    } on DioException catch (e) {
      return CustomException<List<LocationModel>>().dio(e);
    }
  }
}
