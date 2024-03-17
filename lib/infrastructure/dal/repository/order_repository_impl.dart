import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:jetmarket/domain/core/interfaces/order_repository.dart';
import 'package:jetmarket/domain/core/model/params/order/refund_param.dart';

import '../../../domain/core/model/model_data/detail_order_customer.dart';
import '../../../domain/core/model/model_data/detail_refund_model.dart';
import '../../../domain/core/model/model_data/order_customer.dart';
import '../../../domain/core/model/model_data/order_customer_payment.dart';
import '../../../domain/core/model/model_data/order_product_model.dart';
import '../../../domain/core/model/model_data/product_order_customer.dart';
import '../../../domain/core/model/model_data/reorder_id.dart';
import '../../../domain/core/model/model_data/submit_refund_model.dart';
import '../../../domain/core/model/model_data/tracking_order.dart';
import '../../../domain/core/model/model_data/tracking_refund_model.dart';
import '../../../domain/core/model/model_data/waiting_payment.dart';
import '../../../domain/core/model/params/order/list_order_param.dart';
import '../../../utils/network/code_response.dart';
import '../../../utils/network/custom_exception.dart';
import '../../../utils/network/data_state.dart';
import '../daos/provider/endpoint/endpoint.dart';
import '../daos/provider/remote/remote_provider.dart';

class OrderRepositoryImpl implements OrderRepository {
  @override
  Future<DataState<OrderCustomerPaymentModel>> orderCustomerPayment(
      OrderCustomerModel? body) async {
    try {
      final response = await RemoteProvider.post(
          path: Endpoint.orderCustomer, data: body?.toJson());
      log("Data: ${response.data['data']}");
      return DataState<OrderCustomerPaymentModel>(
        status: StatusCodeResponse.cek(response: response),
        result: OrderCustomerPaymentModel.fromJson(response.data['data']),
        message: response.data['message'],
      );
    } on DioException catch (e) {
      return CustomException<OrderCustomerPaymentModel>().dio(e);
    }
  }

  @override
  Future<DataState<int>> getWaitingOrderLenght() async {
    log("Get Waiting Payment");
    try {
      final response =
          await RemoteProvider.get(path: Endpoint.orderWaitingCustomer);
      List<dynamic> datas = response.data['data'];
      log("Get Waiting : ${datas.length}");

      return DataState<int>(
        status: StatusCodeResponse.cek(response: response),
        result: datas.length,
        message: response.data['message'],
      );
    } on DioException catch (e) {
      return CustomException<int>().dio(e);
    }
  }

  @override
  Future<DataState<List<WaitingPaymentModel>>> getListWaitingPayment() async {
    try {
      final response =
          await RemoteProvider.get(path: Endpoint.orderWaitingCustomer);
      List<dynamic> datas = response.data['data'];
      return DataState<List<WaitingPaymentModel>>(
        status: StatusCodeResponse.cek(response: response),
        result: datas.map((e) => WaitingPaymentModel.fromJson(e)).toList(),
        message: response.data['message'],
      );
    } on DioException catch (e) {
      return CustomException<List<WaitingPaymentModel>>().dio(e);
    }
  }

  @override
  Future<DataState<OrderCustomerPaymentModel>> getPaymentTutorial(
      int id) async {
    try {
      final response = await RemoteProvider.get(
          path: '${Endpoint.orderWaitingCustomer}/$id');
      return DataState<OrderCustomerPaymentModel>(
        status: StatusCodeResponse.cek(response: response),
        result: OrderCustomerPaymentModel.fromJson(response.data['data']),
        message: response.data['message'],
      );
    } on DioException catch (e) {
      return CustomException<OrderCustomerPaymentModel>().dio(e);
    }
  }

  @override
  Future<DataState<DetailOrderCustomer>> getDetailOrder(
      int id, String? refId) async {
    String modifiedId = "";
    if (refId != null) {
      modifiedId = refId.replaceAll('#', '%23');
    } else {}
    try {
      final response = await RemoteProvider.get(
          path: refId == null
              ? '${Endpoint.orderCustomer}/$id'
              : '${Endpoint.orderCustomer}/detail/$modifiedId');
      return DataState<DetailOrderCustomer>(
        status: StatusCodeResponse.cek(response: response),
        result: DetailOrderCustomer.fromJson(response.data['data']),
        message: response.data['message'],
      );
    } on DioException catch (e) {
      return CustomException<DetailOrderCustomer>().dio(e);
    }
  }

  @override
  Future<DataState<List<ProductOrderCustomer>>> getListOrderCustomer(
      String refId) async {
    try {
      final response = await RemoteProvider.get(
          path: Endpoint.orderWaitingProductCustomer,
          queryParameters: {'ref_id': refId});
      List<dynamic> datas = response.data['data'];
      return DataState<List<ProductOrderCustomer>>(
        status: StatusCodeResponse.cek(response: response),
        result: datas.map((e) => ProductOrderCustomer.fromJson(e)).toList(),
        message: response.data['message'],
      );
    } on DioException catch (e) {
      return CustomException<List<ProductOrderCustomer>>().dio(e);
    }
  }

  @override
  Future<DataState<List<OrderProductModel>>> getListOrderProduct(
      ListOrderParam param) async {
    try {
      final response = await RemoteProvider.get(
          path: Endpoint.orderCustomer, queryParameters: param.toMap());
      List<dynamic> datas = response.data['data']['items'];
      log(param.toMap().toString());
      return DataState<List<OrderProductModel>>(
        status: StatusCodeResponse.cek(
            response: response, queryParams: true, showLogs: true),
        result: datas.map((e) => OrderProductModel.fromJson(e)).toList(),
        message: response.data['message'],
      );
    } on DioException catch (e) {
      return CustomException<List<OrderProductModel>>().dio(e);
    }
  }

  @override
  Future<DataState<String>> confirmationOrder(int? id) async {
    try {
      final response = await RemoteProvider.post(
          path: "${Endpoint.orderCustomer}/$id/receive");
      return DataState<String>(
        status: StatusCodeResponse.cek(response: response),
        result: response.data['data'],
        message: response.data['message'],
      );
    } on DioException catch (e) {
      return CustomException<String>().dio(e);
    }
  }

  @override
  Future<DataState<TrackingRefundModel>> trackingRefund(int id) async {
    try {
      final response =
          await RemoteProvider.get(path: '${Endpoint.orderRefundTracking}/$id');
      return DataState<TrackingRefundModel>(
        status: StatusCodeResponse.cek(response: response),
        result: TrackingRefundModel.fromJson(response.data['data']),
        message: response.data['message'],
      );
    } on DioException catch (e) {
      return CustomException<TrackingRefundModel>().dio(e);
    }
  }

  @override
  Future<DataState<SubmitRefundModel>> getRefund(int id) async {
    try {
      final response = await RemoteProvider.get(
          path: '${Endpoint.orderCustomer}/$id/refund');
      return DataState<SubmitRefundModel>(
        status: StatusCodeResponse.cek(response: response),
        result: SubmitRefundModel.fromJson(response.data['data']),
        message: response.data['message'],
      );
    } on DioException catch (e) {
      return CustomException<SubmitRefundModel>().dio(e);
    }
  }

  @override
  Future<DataState<DetailRefundModel>> submitRefund(RefundParam param) async {
    try {
      final response = await RemoteProvider.post(
          path: '${Endpoint.orderCustomer}/${param.id}/refund',
          data: param.body?.toMap());
      return DataState<DetailRefundModel>(
          status: StatusCodeResponse.cek(response: response),
          result: DetailRefundModel.fromJson(response.data['data']),
          message: response.data['message']);
    } on DioException catch (e) {
      return CustomException<DetailRefundModel>().dio(e);
    }
  }

  @override
  Future<DataState<DetailRefundModel>> getRefundStatus(int id) async {
    try {
      final response =
          await RemoteProvider.get(path: '${Endpoint.orderRefundStatus}/$id');
      return DataState<DetailRefundModel>(
        status: StatusCodeResponse.cek(response: response),
        result: DetailRefundModel.fromJson(response.data['data']),
        message: response.data['message'],
      );
    } on DioException catch (e) {
      return CustomException<DetailRefundModel>().dio(e);
    }
  }

  @override
  Future<DataState<String>> receiveOrder(int id) async {
    try {
      final response = await RemoteProvider.post(
          path: '${Endpoint.orderCustomer}/$id/receive', data: {'id': id});
      return DataState<String>(
        status: StatusCodeResponse.cek(response: response),
        result: response.data['data'],
        message: response.data['message'],
      );
    } on DioException catch (e) {
      return CustomException<String>().dio(e);
    }
  }

  @override
  Future<DataState<TrackingOrderModel>> trackingOrder(int id) async {
    try {
      final response =
          await RemoteProvider.get(path: '${Endpoint.orderTracking}/$id');
      return DataState<TrackingOrderModel>(
        status: StatusCodeResponse.cek(response: response),
        result: TrackingOrderModel.fromJson(response.data['data']),
        message: response.data['message'],
      );
    } on DioException catch (e) {
      return CustomException<TrackingOrderModel>().dio(e);
    }
  }

  @override
  Future<DataState<List<OrderProductModel>>> getListOrderReview(
      ListOrderParam param) async {
    try {
      final response = await RemoteProvider.get(
          path: Endpoint.orderCustomerReview, queryParameters: param.toMap());
      List<dynamic> datas = response.data['data']['items'];
      return DataState<List<OrderProductModel>>(
        status: StatusCodeResponse.cek(response: response, queryParams: true),
        result: datas.map((e) => OrderProductModel.fromJson(e)).toList(),
        message: response.data['message'],
      );
    } on DioException catch (e) {
      return CustomException<List<OrderProductModel>>().dio(e);
    }
  }

  @override
  Future<DataState<List<ReOrderId>>> getReorderId(int id) async {
    try {
      final response = await RemoteProvider.post(
        path: "${Endpoint.orderCustomer}/$id/re_order",
      );
      List<dynamic> datas = response.data['data'];
      return DataState<List<ReOrderId>>(
        status: StatusCodeResponse.cek(response: response, showLogs: true),
        result: datas.map((e) => ReOrderId.fromJson(e)).toList(),
        message: response.data['message'],
      );
    } on DioException catch (e) {
      return CustomException<List<ReOrderId>>().dio(e);
    }
  }
}
