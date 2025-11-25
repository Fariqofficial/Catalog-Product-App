import 'package:catalog_product_app/core/error/failure.dart';
import 'package:catalog_product_app/features/product/domain/entities/cart/cart_item.dart';
import 'package:catalog_product_app/features/product/domain/repositories/product_repositories.dart';
import 'package:dartz/dartz.dart';

class GetCart {
  final ProductRepositories _repo;
  const GetCart(this._repo);

  Future<Either<Failure, List<CartItem>>> call() => _repo.getCart();
}
