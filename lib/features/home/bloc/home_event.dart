part of 'home_bloc.dart';

@freezed
class HomeEvent with _$HomeEvent {
  const factory HomeEvent.getBannerList() = _GetBannerList;
  const factory HomeEvent.getTop3ProductList() = _GetTop3ProductList;
}
