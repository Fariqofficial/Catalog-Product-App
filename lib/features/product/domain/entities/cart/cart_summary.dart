import 'package:equatable/equatable.dart';

class CartSummary extends Equatable {
  final int totalItems;
  final double totalPrice;
  const CartSummary({required this.totalItems, required this.totalPrice});
  @override
  List<Object?> get props => [totalItems, totalPrice];
}
