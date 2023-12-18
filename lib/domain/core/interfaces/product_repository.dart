import 'package:jetmarket/domain/core/model/model_data/detail_shop.dart';
import 'package:jetmarket/domain/core/model/model_data/product_review_customer.dart';
import 'package:jetmarket/domain/core/model/params/product/product_param.dart';
import 'package:jetmarket/utils/network/data_state.dart';

import '../model/model_data/banner.dart';
import '../model/model_data/category_product.dart';
import '../model/model_data/detail_product.dart';
import '../model/model_data/product.dart';
import '../model/params/product/product_seller_param.dart';

abstract class ProductRepository {
  Future<DataState<List<Banners>>> getBanner();
  Future<DataState<List<CategoryProduct>>> getCategoryProduct();
  Future<DataState<List<CategoryProduct>>> getCategoryProductBySeller(int id);
  Future<DataState<List<Product>>> getProduct(ProductParam param);
  Future<DataState<DetailProduct>> getProductById(int id);
  Future<DataState<List<Product>>> getProductBySeller(ProductSellerParam param);
  Future<DataState<List<ProductReviewCustomer>>> getProductReview(int id);
  Future<DataState<DetailShop>> getDetailShop(int id);
}
