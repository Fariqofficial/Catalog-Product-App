import 'package:catalog_product_app/core/error/failure.dart';
import 'package:catalog_product_app/features/product/domain/entities/product/product.dart';
import 'package:catalog_product_app/features/product/domain/repositories/product_repositories.dart';
import 'package:dartz/dartz.dart';

class GetAllProduct {
  final ProductRepositories _repo;
  const GetAllProduct(this._repo);

  Future<Either<Failure, List<Product>>> call(int page, int limit) =>
      _repo.getAll(page, limit);
}
