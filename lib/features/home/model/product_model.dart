import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_model.freezed.dart';
part 'product_model.g.dart';

@freezed
class ProductModel with _$ProductModel {
  factory ProductModel({
    @Default('') String image,
    @Default('') String name,
    @Default([]) List<String> descriptionList,
    @Default(0) double rating,
    @Default(0) int review,
    @Default([]) List<String> tagList,
    @Default(0) int rank,
  }) = _ProductModel;

  factory ProductModel.fromJson(Map<String, dynamic> json) => _$ProductModelFromJson(json);
}

