// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:resto_fic14/data/models/response/product_response_model.dart';

class ProductQty {
  final Product product;
  int qty;
  ProductQty({
    required this.product,
    required this.qty,
  });

  @override
  bool operator ==(covariant ProductQty other) {
    if (identical(this, other)) return true;

    return other.product == product && other.qty == qty;
  }

  @override
  int get hashCode => product.hashCode ^ qty.hashCode;
}
