import '../../../utils/network/data_state.dart';
import '../model/model_data/mandatory_saving_model.dart';

abstract class MandatorySavingRepository {
  /// Get total mandatory saving amount for current user
  Future<DataState<int>> getTotalMandatorySaving();

  /// Get mandatory saving history with pagination
  Future<DataState<MandatorySavingHistoryResponse>> getMandatorySavingHistory({
    required int page,
    required int size,
  });
}
