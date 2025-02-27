import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hyperhire_test_app/features/home/model/product_model.dart';

part 'home_bloc.freezed.dart';
part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(const HomeState()) {
    on<_GetBannerList>(_onGetBannerList);
    on<_GetTop3ProductList>(_onGetTop3ProductList);
  }

  void _onGetBannerList(_GetBannerList event, Emitter<HomeState> emit) {
    final List<String> bannerList = ['banner1', 'banner2', 'banner3', 'banner4'];
    emit(state.copyWith(bannerList: bannerList));
  }

  void _onGetTop3ProductList(_GetTop3ProductList event, Emitter<HomeState> emit) {
    final List<ProductModel> productList = [
      ProductModel(
        image: 'product1',
        name: 'LG전자 스탠바이미 27ART10AKPL (스탠',
        descriptionList: [
          '화면을 이동할 수 있고 전환도 편리하다는 점이 제일 마음에 들었어요. 배송도 빠르고 친절하게 받을 수 있어서 좋았습니다.',
          '스탠바이미는 사랑입니다!️',
        ],
        rating: 4.89,
        review: 216,
        tagList: [
          'LG전자',
          '편리성',
        ],
        rank: 1,
      ),
      ProductModel(
        image: 'product2',
        name: 'LLG전자  울트라HD 75UP8300KNA (스탠드)',
        descriptionList: [
          '화면 잘 나오고... 리모컨 기능 좋습니다.',
          '넷플 아마존 등 버튼하나로 바로 접속 되고디스플레이는 액정문제 없어보이고소리는 살짝 약간 감이 있으나 ^^; 시끄러울까봐 그냥 블루투스 헤드폰 구매 예정이라 문제는 없네요. 아주 만족입니다!!',
        ],
        rating: 4.36,
        review: 136,
        tagList: [
          'LG전자',
          '고화질',
        ],
        rank: 2,
      ),
      ProductModel(
        image: 'product3',
        name: '라익미 스마트 DS4001L NETRANGE (스탠드)GX30K WIN10 (SSD 256GB)',
        descriptionList: [
          '반응속도 및 화질이나 여러면에서도 부족함을  느끼기에는 커녕 이정도에 이 정도 성능이면차고 넘칠만 합니다',
          '중소기업TV 라익미 제품을 사용해보았는데 뛰어난 가성비와 더불어OTT 서비스에 오픈 브라우저 까지 너무 마음에 들게끔 기능들을 사용 가능했고',
        ],
        rating: 3.98,
        review: 98,
        tagList: [
          '라익미',
          '가성비',
        ],
        rank: 3,
      ),
    ];
    emit(state.copyWith(top3ProductList: productList));
  }
}
