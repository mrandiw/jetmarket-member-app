import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:jetmarket/domain/core/interfaces/notification_repository.dart';
import 'package:jetmarket/domain/core/model/params/notification/notification_param.dart';
import 'package:jetmarket/infrastructure/dal/daos/provider/endpoint/endpoint.dart';

import '../../../domain/core/model/model_data/notification.dart';
import '../../../utils/network/code_response.dart';
import '../../../utils/network/custom_exception.dart';
import '../../../utils/network/data_state.dart';
import '../daos/provider/remote/remote_provider.dart';

class NotificationRepositoryImpl implements NotificationRepository {
  @override
  Future<DataState<List<NotificationData>>> getNotification(
      NotificationParam param) async {
    try {
      final response = await RemoteProvider.get(
          path: Endpoint.notification, queryParameters: param.toMap());
      List<dynamic> datas = response.data['data']['items'];
      return DataState<List<NotificationData>>(
          result: datas.map((e) => NotificationData.fromJson(e)).toList(),
          status: StatusCodeResponse.cek(
            response: response,
          ));
    } on DioException catch (e) {
      return CustomException<List<NotificationData>>().dio(e);
    }
  }

  @override
  Future<DataState<int>> getUnreadCount() async {
    try {
      final response =
          await RemoteProvider.get(path: Endpoint.notificationUnreadCount);
      log(Endpoint.notificationUnreadCount);
      return DataState<int>(
          result: response.data['data']['unread_count'],
          status: StatusCodeResponse.cek(
            response: response,
          ));
    } on DioException catch (e) {
      return CustomException<int>().dio(e);
    }
  }
}
