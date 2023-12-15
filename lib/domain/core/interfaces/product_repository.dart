import 'package:jetmarket/domain/core/model/params/product/product_param.dart';
import 'package:jetmarket/utils/network/data_state.dart';

import '../model/model_data/category_product.dart';
import '../model/model_data/product.dart';

abstract class ProductRepository {
  Future<DataState<List<CategoryProduct>>> getCategoryProduct();
  Future<DataState<List<Product>>> getProduct(ProductParam param);
}
