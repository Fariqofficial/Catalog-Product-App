import 'package:catalog_product_app/core/error/failure.dart';
import 'package:catalog_product_app/features/product/domain/entities/product/product.dart';
import 'package:catalog_product_app/features/product/domain/repositories/product_repositories.dart';
import 'package:dartz/dartz.dart';

class DecrementCart {
  final ProductRepositories _repo;
  const DecrementCart(this._repo);

  Future<Either<Failure, bool>> call(Product product) =>
      _repo.decrementCart(product);
}
