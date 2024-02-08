import 'package:jetmarket/domain/core/model/params/review/review_param.dart';

import '../../../utils/network/data_state.dart';
import '../model/model_data/product_review_model.dart';

abstract class ReviewRepository {
  Future<DataState<List<ProductReviewModel>>> getReview(int id);
  Future<DataState<String>> sendReview(ReviewParam param);
}
