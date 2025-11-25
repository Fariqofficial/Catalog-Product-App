import 'dart:convert';
import 'package:catalog_product_app/core/error/exceptions.dart';
import 'package:catalog_product_app/features/product/data/mapper/product_mapper.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

abstract class ProductRemoteDatasource {
  Future<List<ProductMapper>> getAll();
  Future<List<ProductMapper>> search(String query);
  Future<ProductMapper> getDetail(int id);
}

class ProductRemoteDatasourceImpl implements ProductRemoteDatasource {
  final http.Client _client;
  ProductRemoteDatasourceImpl(this._client);

  @override
  Future<List<ProductMapper>> getAll() async {
    final baseUrl = dotenv.env['BASE_URL'] ?? '';
    final url = Uri.parse('$baseUrl/products');
    final response = await _client.get(url).timeout(const Duration(seconds: 3));

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);
      return data.map((json) => ProductMapper.fromJSON(json)).toList();
    } else if (response.statusCode == 400) {
      throw BadRequestException();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<ProductMapper> getDetail(int id) async {
    final baseUrl = dotenv.env['BASE_URL'] ?? '';
    final url = Uri.parse('$baseUrl/products/$id');

    final response = await _client.get(url).timeout(const Duration(seconds: 3));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return ProductMapper.fromJSON(data);
    } else if (response.statusCode == 400) {
      throw BadRequestException();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<ProductMapper>> search(String query) async {
    final baseUrl = dotenv.env['BASE_URL'] ?? '';
    final url = Uri.parse('$baseUrl/products');
    final response = await _client.get(url).timeout(const Duration(seconds: 3));

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      final products = data.map((e) => ProductMapper.fromJSON(e)).toList();
      return products.where((e) {
        final q = query.toLowerCase();
        return e.title.toLowerCase().contains(q) ||
            e.description.toLowerCase().contains(q);
      }).toList();
    } else {
      throw ServerException();
    }
  }
}
