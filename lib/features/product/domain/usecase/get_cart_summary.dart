import 'package:catalog_product_app/core/error/failure.dart';
import 'package:catalog_product_app/features/product/domain/entities/cart/cart_summary.dart';
import 'package:catalog_product_app/features/product/domain/repositories/product_repositories.dart';
import 'package:dartz/dartz.dart';

class GetCartSummary {
  final ProductRepositories _repo;
  const GetCartSummary(this._repo);

  Future<Either<Failure, CartSummary>> call() => _repo.getCartSummary();
}
