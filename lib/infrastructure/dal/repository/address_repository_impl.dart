import 'package:dio/dio.dart';
import 'package:jetmarket/domain/core/interfaces/address_repository.dart';
import 'package:jetmarket/domain/core/model/model_data/address_model.dart';
import 'package:jetmarket/domain/core/model/params/address/address_body.dart';
import 'package:jetmarket/domain/core/model/params/address/address_param.dart';
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
      // dynamic placeId = response.data;
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

  @override
  Future<DataState<List<AddressModel>>> getAddress(AddressParam param) async {
    try {
      final response = await RemoteProvider.get(
          path: Endpoint.address, queryParameters: param.toMap());
      List<dynamic> datas = response.data['data']['items'];
      return DataState<List<AddressModel>>(
          result: datas.map((e) => AddressModel.fromJson(e)).toList(),
          status: StatusCodeResponse.cek(response: response));
    } on DioException catch (e) {
      return CustomException<List<AddressModel>>().dio(e);
    }
  }

  @override
  Future<DataState<List<AddressModel>>> getAddressMain(
      AddressParam param) async {
    try {
      final response = await RemoteProvider.get(
          path: Endpoint.address, queryParameters: param.toMap());
      List<dynamic> datas = response.data['data']['items'];
      return DataState<List<AddressModel>>(
          result: datas.map((e) => AddressModel.fromJson(e)).toList(),
          status: StatusCodeResponse.cek(response: response));
    } on DioException catch (e) {
      return CustomException<List<AddressModel>>().dio(e);
    }
  }

  @override
  Future<DataState<String>> addAddress(AddressBody body) async {
    try {
      final response =
          await RemoteProvider.post(path: Endpoint.address, data: body.toMap());
      return DataState<String>(
          result: response.data['message'],
          status: StatusCodeResponse.cek(response: response));
    } on DioException catch (e) {
      return CustomException<String>().dio(e);
    }
  }

  @override
  Future<DataState<String>> editAddress(AddressBody body) async {
    try {
      final response = await RemoteProvider.put(
          path: '${Endpoint.address}/${body.id}', data: body.toMap());
      return DataState<String>(
          result: response.data['message'],
          status: StatusCodeResponse.cek(response: response));
    } on DioException catch (e) {
      return CustomException<String>().dio(e);
    }
  }
}
