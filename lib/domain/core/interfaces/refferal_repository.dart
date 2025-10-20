import 'package:jetmarket/domain/core/model/model_data/banner.dart';

import '../../../utils/network/data_state.dart';
import '../model/model_data/refferal_model.dart';

abstract class RefferalRepository {
  Future<DataState<List<RefferalModel>>> getRefferal(
      {required int page, required int size});
  Future<DataState<List<Banners>>> getBanner();
}
