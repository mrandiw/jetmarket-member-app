import 'package:jetmarket/domain/core/model/model_data/notification.dart';
import 'package:jetmarket/domain/core/model/params/notification/notification_param.dart';

import '../../../utils/network/data_state.dart';

abstract class NotificationRepository {
  Future<DataState<List<NotificationData>>> getNotification(
      NotificationParam param);
  Future<DataState<int>> getUnreadCount();
}
