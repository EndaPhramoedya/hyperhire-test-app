part of 'home_bloc.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState({
    @Default(<String>[]) List<String> bannerList,
    @Default(<ProductModel>[]) List<ProductModel> top3ProductList,
  }) = _HomeState;
}
