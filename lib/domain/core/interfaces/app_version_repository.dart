import 'package:jetmarket/domain/core/model/model_data/app_version_model.dart';

import '../../../utils/network/data_state.dart';

abstract class AppVersionRepository {
  Future<DataState<AppVersionModel>> getAppVersion();
}
