import 'package:catalog_product_app/core/error/failure.dart';
import 'package:catalog_product_app/features/product/domain/entities/product/product.dart';
import 'package:catalog_product_app/features/product/domain/repositories/product_repositories.dart';
import 'package:dartz/dartz.dart';

class GetDetailProduct {
  final ProductRepositories _repo;
  const GetDetailProduct(this._repo);

  Future<Either<Failure, Product>> call(int id) => _repo.getDetail(id);
}
