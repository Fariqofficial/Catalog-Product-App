import 'dart:async';
import 'dart:developer';

import 'package:catalog_product_app/core/error/exceptions.dart';
import 'package:catalog_product_app/core/error/failure.dart';
import 'package:catalog_product_app/core/network/network_info.dart';
import 'package:catalog_product_app/features/product/data/datasource/product_remote_datasource.dart';
import 'package:catalog_product_app/features/product/data/datasource/product_remote_local_datasource.dart';
import 'package:catalog_product_app/features/product/data/mapper/product_mapper.dart';
import 'package:catalog_product_app/features/product/domain/entities/cart/cart_item.dart';
import 'package:catalog_product_app/features/product/domain/entities/cart/cart_summary.dart';
import 'package:catalog_product_app/features/product/domain/entities/product/product.dart';
import 'package:catalog_product_app/features/product/domain/repositories/product_repositories.dart';
import 'package:dartz/dartz.dart';

class ProductRepositoriesImpl implements ProductRepositories {
  final NetworkInfo _networkInfo;
  final ProductRemoteLocalDatasource _localDatasource;
  final ProductRemoteDatasource _remoteDatasource;

  const ProductRepositoriesImpl(
    this._networkInfo,
    this._localDatasource,
    this._remoteDatasource,
  );

  @override
  Future<Either<Failure, List<Product>>> getAll(int page, int limit) async {
    final bool online = await _networkInfo.isConnected();
    if (online) {
      try {
        final allProducts = await _remoteDatasource.getAll();
        await _localDatasource.cachedAll(allProducts);
        final sliced = _sliceList(allProducts, page, limit);
        return Right(sliced.map((e) => e.toEntity).toList());
      } on TimeoutException {
        log('TimeoutException');
        return Left(NotFoundFailure(message: "Request Timeout / No Response"));
      } on NotFoundException {
        log('NotFoundException');
        return Left(NotFoundFailure(message: "Data Not Found"));
      } on ServerException {
        log('ServerException');
        return Left(ServerFailure(message: "Server Error"));
      }
    } else {
      try {
        final allProducts = await _localDatasource.getAll();
        final sliced = _sliceList(allProducts, page, limit);
        return Right(sliced.map((e) => e.toEntity).toList());
      } on CachedException {
        return Left(CachedFailure(message: "Data can't show"));
      }
    }
  }

  @override
  Future<Either<Failure, Product>> getDetail(int id) async {
    bool online = await _networkInfo.isConnected();

    if (online) {
      try {
        final result = await _remoteDatasource.getDetail(id);
        return Right(result.toEntity);
      } on TimeoutException {
        return Left(NotFoundFailure(message: "Request Timeout / No Response"));
      } on NotFoundException {
        return Left(NotFoundFailure(message: "Data Not Found"));
      } on ServerException {
        return Left(ServerFailure(message: "Server Error"));
      }
    } else {
      try {
        final cachedProducts = await _localDatasource.getAll();
        final product = cachedProducts.firstWhere((e) => e.id == id);
        return Right(product.toEntity);
      } on CachedException {
        return Left(CachedFailure(message: "Data can't show"));
      }
    }
  }

  @override
  Future<Either<Failure, List<Product>>> search(String query) async {
    bool online = await _networkInfo.isConnected();

    if (online) {
      try {
        final result = await _remoteDatasource.search(query);
        return Right(result.map((e) => e.toEntity).toList());
      } on TimeoutException {
        return Left(NotFoundFailure(message: "Request Timeout / No Response"));
      } on NotFoundException {
        return Left(NotFoundFailure(message: "Data Not Found"));
      } on ServerException {
        return Left(ServerFailure(message: "Server Error"));
      }
    } else {
      try {
        final cachedProducts = await _localDatasource.getAll();
        final filtered = cachedProducts.where((e) {
          final q = query.toLowerCase();
          return e.title.toLowerCase().contains(q) ||
              e.description.toLowerCase().contains(q);
        }).toList();

        return Right(filtered.map((e) => e.toEntity).toList());
      } on CachedException {
        return Left(CachedFailure(message: "Data can't show"));
      }
    }
  }

  @override
  Future<Either<Failure, bool>> addToCart(Product product) async {
    try {
      final success = await _localDatasource.addToCart(product);
      return Right(success);
    } on CachedException {
      return Left(CachedFailure(message: 'Failed add product to cart'));
    }
  }

  @override
  Future<Either<Failure, CartSummary>> getCartSummary() async {
    try {
      final summary = await _localDatasource.getCartSummary();
      return Right(summary);
    } on CachedException {
      return Left(CachedFailure(message: 'Failed to load cart summary'));
    }
  }

  @override
  Future<Either<Failure, bool>> decrementCart(Product product) async {
    try {
      final success = await _localDatasource.decrementCart(product);
      return Right(success);
    } on CachedException {
      return Left(CachedFailure(message: 'Failed to update cart'));
    }
  }

  @override
  Future<Either<Failure, List<CartItem>>> getCart() async {
    try {
      final cart = await _localDatasource.getCart();
      return Right(cart);
    } on CachedException {
      return Left(CachedFailure(message: 'Failed to load cart'));
    }
  }

  @override
  Future<Either<Failure, bool>> removeProductFromCart(Product product) async {
    try {
      final success = await _localDatasource.removeFromCart(product);
      return Right(success);
    } on CachedException {
      return Left(CachedFailure(message: 'Failed to remove from cart'));
    }
  }

  @override
  Future<Either<Failure, bool>> removeMultipleFromCart(
    List<Product> products,
  ) async {
    try {
      final success = await _localDatasource.removeMultipleFromCart(products);
      return Right(success);
    } on CachedException {
      return Left(CachedFailure(message: 'Failed to remove selected items'));
    }
  }
}

List<ProductMapper> _sliceList(List<ProductMapper> list, int page, int limit) {
  final start = (page - 1) * limit;
  if (start >= list.length) return [];
  final end = start + limit;
  return list.sublist(start, end > list.length ? list.length : end);
}
