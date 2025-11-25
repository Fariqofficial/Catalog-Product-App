import 'package:catalog_product_app/features/product/domain/entities/product/product.dart';
import 'package:equatable/equatable.dart';

class CartItem extends Equatable {
  final Product product;
  final int quantity;
  const CartItem({required this.product, required this.quantity});

  CartItem copyWith({int? quantity}) {
    return CartItem(product: product, quantity: quantity ?? this.quantity);
  }

  @override
  List<Object?> get props => [product.id, quantity];
}
