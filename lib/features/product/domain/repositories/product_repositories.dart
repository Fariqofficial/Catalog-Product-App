import 'package:catalog_product_app/core/error/failure.dart';
import 'package:catalog_product_app/features/product/domain/entities/cart/cart_item.dart';
import 'package:catalog_product_app/features/product/domain/entities/cart/cart_summary.dart';
import 'package:catalog_product_app/features/product/domain/entities/product/product.dart';
import 'package:dartz/dartz.dart';

abstract class ProductRepositories {
  Future<Either<Failure, List<Product>>> getAll(int page, int limit);
  Future<Either<Failure, List<Product>>> search(String query);
  Future<Either<Failure, Product>> getDetail(int id);
  Future<Either<Failure, bool>> addToCart(Product product);
  Future<Either<Failure, CartSummary>> getCartSummary();
  Future<Either<Failure, bool>> decrementCart(Product product);
  Future<Either<Failure, List<CartItem>>> getCart();
  Future<Either<Failure, bool>> removeProductFromCart(Product product);
  Future<Either<Failure, bool>> removeMultipleFromCart(List<Product> products);
}
