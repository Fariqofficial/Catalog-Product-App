import 'package:catalog_product_app/core/error/failure.dart';
import 'package:catalog_product_app/features/product/domain/entities/product/product.dart';
import 'package:catalog_product_app/features/product/domain/repositories/product_repositories.dart';
import 'package:dartz/dartz.dart';

class RemoveMultipleItem {
  final ProductRepositories _repo;
  const RemoveMultipleItem(this._repo);

  Future<Either<Failure, bool>> call(List<Product> products) =>
      _repo.removeMultipleFromCart(products);
}
