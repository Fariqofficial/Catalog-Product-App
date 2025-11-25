import 'dart:convert';

import 'package:catalog_product_app/core/error/exceptions.dart';
import 'package:catalog_product_app/features/product/data/mapper/product_mapper.dart';
import 'package:catalog_product_app/features/product/domain/entities/cart/cart_item.dart';
import 'package:catalog_product_app/features/product/domain/entities/cart/cart_summary.dart';
import 'package:catalog_product_app/features/product/domain/entities/product/product.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ProductRemoteLocalDatasource {
  Future<List<ProductMapper>> getAll();
  Future<bool> cachedAll(List<ProductMapper> products);
  Future<ProductMapper> getDetail(int id);
  Future<bool> addToCart(Product product);
  Future<List<CartItem>> getCart();
  Future<CartSummary> getCartSummary();
  Future<bool> decrementCart(Product product);
  Future<bool> removeFromCart(Product product);
  Future<bool> removeMultipleFromCart(List<Product> products);
}

class ProductRemoteLocalDatasourceImpl implements ProductRemoteLocalDatasource {
  final SharedPreferences _preferences;
  const ProductRemoteLocalDatasourceImpl(this._preferences);

  static const _cacheProductKey = 'all_products';
  static const _cartKey = 'cart_items';

  @override
  Future<bool> cachedAll(List<ProductMapper> products) async {
    List<Map<String, dynamic>> listData = products
        .map((e) => e.toJSON())
        .toList();
    String data = jsonEncode(listData);
    return _preferences.setString(_cacheProductKey, data);
  }

  @override
  Future<List<ProductMapper>> getAll() async {
    String? data = _preferences.getString(_cacheProductKey);
    if (data != null) {
      List<Map<String, dynamic>> dataList = List<Map<String, dynamic>>.from(
        jsonDecode(data),
      );
      List<ProductMapper> mapper = dataList
          .map((e) => ProductMapper.fromJSON(e))
          .toList();
      return mapper;
    }
    throw CachedException();
  }

  @override
  Future<ProductMapper> getDetail(int id) async {
    String? data = _preferences.getString(_cacheProductKey);
    if (data != null) {
      List<Map<String, dynamic>> dataList = List<Map<String, dynamic>>.from(
        jsonDecode(data),
      );
      final matchingJson = dataList.firstWhere(
        (json) => json['id'] == id,
        orElse: () => throw NotFoundException(),
      );
      return ProductMapper.fromJSON(matchingJson);
    }
    throw CachedException();
  }

  @override
  Future<bool> addToCart(Product product) async {
    try {
      final currentCart = await getCart();
      final existingIndex = currentCart.indexWhere(
        (item) => item.product.id == product.id,
      );
      final updatedCart = List<CartItem>.from(currentCart);
      if (existingIndex != -1) {
        updatedCart[existingIndex] = updatedCart[existingIndex].copyWith(
          quantity: updatedCart[existingIndex].quantity + 1,
        );
      } else {
        updatedCart.add(CartItem(product: product, quantity: 1));
      }
      final jsonList = updatedCart
          .map(
            (item) => {
              'product': ProductMapper.fromEntity(item.product).toJSON(),
              'quantity': item.quantity,
            },
          )
          .toList();
      final jsonData = jsonEncode(jsonList);
      return _preferences.setString(_cartKey, jsonData);
    } catch (e) {
      throw CachedException();
    }
  }

  @override
  Future<List<CartItem>> getCart() async {
    final data = _preferences.getString(_cartKey);
    if (data == null || data.isEmpty) {
      return [];
    }
    try {
      final List<dynamic> jsonList = jsonDecode(data);
      return jsonList.map<CartItem>((json) {
        final productJson = json['product'] as Map<String, dynamic>;
        final mapper = ProductMapper.fromJSON(productJson);
        return CartItem(
          product: mapper.toEntity,
          quantity: json['quantity'] as int,
        );
      }).toList();
    } catch (e) {
      throw CachedException();
    }
  }

  @override
  Future<CartSummary> getCartSummary() async {
    final cart = await getCart();
    final totalItems = cart.fold<int>(0, (sum, item) => sum + item.quantity);
    final totalPrice = cart.fold<double>(
      0.0,
      (sum, item) => sum + (item.product.price * item.quantity),
    );
    return CartSummary(totalItems: totalItems, totalPrice: totalPrice);
  }

  @override
  Future<bool> decrementCart(Product product) async {
    try {
      final currentCart = await getCart();
      final existingIndex = currentCart.indexWhere(
        (item) => item.product.id == product.id,
      );
      if (existingIndex == -1) {
        return false;
      }
      final updatedCart = List<CartItem>.from(currentCart);
      if (updatedCart[existingIndex].quantity > 1) {
        updatedCart[existingIndex] = updatedCart[existingIndex].copyWith(
          quantity: updatedCart[existingIndex].quantity - 1,
        );
      } else {
        updatedCart.removeAt(existingIndex);
      }
      final jsonList = updatedCart
          .map(
            (item) => {
              'product': ProductMapper.fromEntity(item.product).toJSON(),
              'quantity': item.quantity,
            },
          )
          .toList();
      final jsonData = jsonEncode(jsonList);
      return _preferences.setString(_cartKey, jsonData);
    } catch (e) {
      throw CachedException();
    }
  }

  @override
  Future<bool> removeFromCart(Product product) async {
    try {
      final currentCart = await getCart();
      final updatedCart = currentCart
          .where((item) => item.product.id != product.id)
          .toList();
      final jsonList = updatedCart
          .map(
            (item) => {
              'product': ProductMapper.fromEntity(item.product).toJSON(),
              'quantity': item.quantity,
            },
          )
          .toList();
      final jsonData = jsonEncode(jsonList);
      return _preferences.setString(_cartKey, jsonData);
    } catch (e) {
      throw CachedException();
    }
  }

  @override
  Future<bool> removeMultipleFromCart(List<Product> products) async {
    try {
      final currentCart = await getCart();
      final productIds = products.map((p) => p.id).toSet();
      final updatedCart = currentCart
          .where((item) => !productIds.contains(item.product.id))
          .toList();

      final jsonList = updatedCart
          .map(
            (item) => {
              'product': ProductMapper.fromEntity(item.product).toJSON(),
              'quantity': item.quantity,
            },
          )
          .toList();
      final jsonData = jsonEncode(jsonList);
      return _preferences.setString(_cartKey, jsonData);
    } catch (e) {
      throw CachedException();
    }
  }
}
