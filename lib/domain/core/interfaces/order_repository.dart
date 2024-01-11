import '../../../utils/network/data_state.dart';
import '../model/model_data/detail_order_customer.dart';
import '../model/model_data/detail_refund_model.dart';
import '../model/model_data/order_customer.dart';
import '../model/model_data/order_customer_payment.dart';
import '../model/model_data/order_product_model.dart';
import '../model/model_data/product_order_customer.dart';
import '../model/model_data/submit_refund_model.dart';
import '../model/model_data/tracking_order.dart';
import '../model/model_data/tracking_refund_model.dart';
import '../model/model_data/waiting_payment.dart';
import '../model/params/order/list_order_param.dart';
import '../model/params/order/refund_param.dart';

abstract class OrderRepository {
  Future<DataState<OrderCustomerPaymentModel>> orderCustomerPayment(
      OrderCustomerModel? body);
  Future<DataState<int>> getWaitingOrderLenght();
  Future<DataState<List<WaitingPaymentModel>>> getListWaitingPayment();
  Future<DataState<OrderCustomerPaymentModel>> getPaymentTutorial(int id);
  Future<DataState<DetailOrderCustomer>> getDetailOrder(int id);
  Future<DataState<List<ProductOrderCustomer>>> getListOrderCustomer(int id);
  Future<DataState<List<OrderProductModel>>> getListOrderProduct(
      ListOrderParam param);
  Future<DataState<String>> confirmationOrder(int id);
  Future<DataState<TrackingRefundModel>> trackingRefund(int id);
  Future<DataState<SubmitRefundModel>> getRefund(int id);
  Future<DataState<DetailRefundModel>> submitRefund(RefundParam param);
  Future<DataState<DetailRefundModel>> getRefundStatus(int id);
  Future<DataState<String>> receiveOrder(int id);
  Future<DataState<TrackingOrderModel>> trackingOrder(int id);
}
