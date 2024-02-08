import 'package:jetmarket/domain/core/model/params/cart/cart_product_param.dart';
import 'package:jetmarket/utils/network/data_state.dart';

import '../model/model_data/cart_product.dart';
import '../model/params/cart/cart_body.dart';
import '../model/params/cart/update_note_param.dart';
import '../model/params/cart/update_qty_param.dart';

abstract class CartRepository {
  Future<DataState<String>> addToCart(CartBody body);
  Future<DataState<List<CartProduct>>> getCartProduct(CartProductParam param);
  Future<DataState<String>> updateQty(UpdateQtyParam param);
  Future<DataState<String>> updateNote(UpdateNoteParam param);
  Future<DataState<String>> deleteProduct(List<int> id);
}
