import 'package:catalog_product_app/features/product/domain/entities/product/rating.dart';

class RatingMapper extends Rating {
  const RatingMapper({required super.rate, required super.count});

  factory RatingMapper.fromJSON(Map<String, dynamic> json) => RatingMapper(
    rate: (json['rate'] as num).toDouble(),
    count: json['count'],
  );

  factory RatingMapper.fromEntity(Rating entity) =>
      RatingMapper(rate: entity.rate, count: entity.count);

  Map<String, dynamic> toJSON() => {'rate': rate, 'count': count};
}
