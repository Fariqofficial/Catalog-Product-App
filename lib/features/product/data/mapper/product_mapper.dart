import 'package:catalog_product_app/common/utils/url_images.dart';
import 'package:catalog_product_app/features/product/data/mapper/rating_mapper.dart';
import 'package:catalog_product_app/features/product/domain/entities/product/product.dart';

class ProductMapper extends Product {
  const ProductMapper({
    required super.id,
    required super.title,
    required super.price,
    required super.description,
    required super.category,
    required super.images,
    required super.rating,
  });

  factory ProductMapper.fromJSON(Map<String, dynamic> json) {
    final String imageKey = json['image'] ?? json['images'] ?? '';
    return ProductMapper(
      id: json['id'],
      title: json['title'],
      price: (json['price'] as num).toDouble(),
      description: json['description'],
      category: json["category"],
      images: URLImages.image(imageKey),
      rating: RatingMapper.fromJSON(json['rating']),
    );
  }

  Map<String, dynamic> toJSON() => {
    'id': id,
    'title': title,
    'price': price,
    'description': description,
    'category': category,
    'image': images,
    'rating': (rating is RatingMapper)
        ? (rating as RatingMapper).toJSON()
        : {'rate': rating.rate, 'count': rating.count},
  };

  Product get toEntity => Product(
    id: id,
    title: title,
    price: price,
    description: description,
    category: category,
    images: images,
    rating: rating,
  );

  factory ProductMapper.fromEntity(Product entity) {
    return ProductMapper(
      id: entity.id,
      title: entity.title,
      price: entity.price,
      description: entity.description,
      category: entity.category,
      images: entity.images,
      rating: entity.rating,
    );
  }
}
