class ProductOrderCustomer {
  int? id;
  String? image;
  String? name;
  int? price;
  int? qty;
  String? status;
  int? totalAmount;
  int? totalItem;

  ProductOrderCustomer(
      {this.id,
      this.image,
      this.name,
      this.price,
      this.qty,
      this.status,
      this.totalAmount,
      this.totalItem});

  ProductOrderCustomer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    name = json['name'];
    price = json['price'];
    qty = json['qty'];
    status = json['status'];
    totalAmount = json['total_amount'];
    totalItem = json['total_item'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['image'] = image;
    data['name'] = name;
    data['price'] = price;
    data['qty'] = qty;
    data['status'] = status;
    data['total_amount'] = totalAmount;
    data['total_item'] = totalItem;
    return data;
  }
}
