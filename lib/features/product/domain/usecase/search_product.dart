import 'package:catalog_product_app/core/error/failure.dart';
import 'package:catalog_product_app/features/product/domain/entities/product/product.dart';
import 'package:catalog_product_app/features/product/domain/repositories/product_repositories.dart';
import 'package:dartz/dartz.dart';

class SearchProduct {
  final ProductRepositories _repo;
  const SearchProduct(this._repo);

  Future<Either<Failure, List<Product>>> call(String query) =>
      _repo.search(query);
}
