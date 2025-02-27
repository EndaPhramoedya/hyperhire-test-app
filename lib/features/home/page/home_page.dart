import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gradient_borders/input_borders/gradient_outline_input_border.dart';
import 'package:hyperhire_test_app/features/home/bloc/home_bloc.dart';
import 'package:hyperhire_test_app/features/home/model/product_model.dart';
import 'package:hyperhire_test_app/features/home/model/user_model.dart';
import 'package:hyperhire_test_app/features/home/widget/product_card.dart';
import 'package:hyperhire_test_app/features/home/widget/reviewer_card.dart';
import 'package:hyperhire_test_app/utils/image_helper.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    context.read<HomeBloc>()
      ..add(const HomeEvent.getBannerList())
      ..add(const HomeEvent.getTop3ProductList())
      ..add(const HomeEvent.getTop10ReviewerList());

    super.initState();
  }

  PreferredSizeWidget _buildAppBar() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(kToolbarHeight),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              offset: const Offset(0, 2.0),
              blurRadius: 4.0,
            ),
          ],
        ),
        child: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          centerTitle: false,
          title: Text(
            'LOGO',
            style: GoogleFonts.roboto(
              textStyle: const TextStyle(
                color: Color(0xff5D5FEF),
                fontWeight: FontWeight.w500,
                fontSize: 24,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderSection() {
    return ColoredBox(
      color: Colors.white,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: const TextField(
              decoration: InputDecoration(
                labelText: '검색어를 입력하세요',
                enabledBorder: GradientOutlineInputBorder(
                  gradient: LinearGradient(colors: [Color(0xff3C41BF), Color(0xff74FBDE)]),
                  width: 2,
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
                focusedBorder: GradientOutlineInputBorder(
                  gradient: LinearGradient(colors: [Color(0xff3C41BF), Color(0xff74FBDE)]),
                  width: 2,
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
                suffixIcon: Icon(Icons.search),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          BlocBuilder<HomeBloc, HomeState>(
            buildWhen: (prev, curr) => prev.bannerList != curr.bannerList,
            builder: (context, state) {
              final List<String> bannerList = state.bannerList;
              if (bannerList.isEmpty) {
                return const SizedBox();
              }

              return ConstrainedBox(
                constraints: const BoxConstraints(maxHeight: 200),
                child: CarouselView(
                  backgroundColor: Colors.transparent,
                  itemExtent: 300,
                  padding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                  children: List.generate(
                    bannerList.length,
                    (index) => Image.asset(ImageHelper.getSourceByPng(bannerList[index])),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTop3ProductSection() {
    return Flexible(
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '제일 핫한 리뷰를 만나보세요',
                      style: GoogleFonts.notoSansKr(
                        textStyle: const TextStyle(
                          color: Color(0xff616161),
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    Text(
                      '리뷰️  랭킹⭐ top 3',
                      style: GoogleFonts.notoSansKr(
                        textStyle: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
                Icon(
                  Icons.chevron_right,
                  color: Colors.black,
                  size: 24,
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            BlocBuilder<HomeBloc, HomeState>(
              buildWhen: (prev, curr) => prev.top3ProductList != curr.top3ProductList,
              builder: (context, state) {
                final List<ProductModel> productList = state.top3ProductList;
                if (productList.isEmpty) {
                  return const SizedBox();
                }

                return ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: productList.length,
                  itemBuilder: (context, index) => ProductCard(item: productList[index]),
                );
              },
            )
          ],
        ),
      ),
    );
  }

  Widget _buildTop10UserSection() {
    return ColoredBox(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '골드 계급 사용자들이예요',
                  style: GoogleFonts.notoSansKr(
                    textStyle: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                    ),
                  ),
                ),
                Text(
                  '베스트 리뷰어 🏆 Top10',
                  style: GoogleFonts.notoSansKr(
                    textStyle: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 18,
          ),
          BlocBuilder<HomeBloc, HomeState>(
            buildWhen: (prev, curr) => prev.top10ReviewerList != curr.top10ReviewerList,
            builder: (context, state) {
              final List<UserModel> reviewerList = state.top10ReviewerList;
              if (reviewerList.isEmpty) {
                return const SizedBox();
              }

              return ConstrainedBox(
                constraints: const BoxConstraints(maxHeight: 120),
                child: CarouselView(
                  backgroundColor: Colors.transparent,
                  itemExtent: 100,
                  padding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                  children: List.generate(
                    reviewerList.length,
                    (index) => GestureDetector(
                      onTap: () {},
                      child: ReviewerCard(
                        user: reviewerList[index],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildFooterSection() {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'LOGO Inc.',
            style: GoogleFonts.notoSansKr(
              textStyle: const TextStyle(
                color: Color(0xff616161),
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '회사 소개 ',
                style: GoogleFonts.notoSansKr(
                  textStyle: const TextStyle(
                    color: Color(0xff616161),
                    fontWeight: FontWeight.w400,
                    fontSize: 13,
                  ),
                ),
              ),
              Text(' | '),
              Text(
                '인재 채용',
                style: GoogleFonts.notoSansKr(
                  textStyle: const TextStyle(
                    color: Color(0xff616161),
                    fontWeight: FontWeight.w400,
                    fontSize: 13,
                  ),
                ),
              ),
              Text(' | '),
              Text(
                '기술 블로그',
                style: GoogleFonts.notoSansKr(
                  textStyle: const TextStyle(
                    color: Color(0xff616161),
                    fontWeight: FontWeight.w400,
                    fontSize: 13,
                  ),
                ),
              ),
              Text(' | '),
              Text(
                '리뷰 저작권',
                style: GoogleFonts.notoSansKr(
                  textStyle: const TextStyle(
                    color: Color(0xff616161),
                    fontWeight: FontWeight.w400,
                    fontSize: 13,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 18,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.send,
                    color: Color(0xff868686),
                    size: 16,
                  ),
                  const SizedBox(
                    width: 2,
                  ),
                  Text(
                    'review@logo.com',
                    style: GoogleFonts.notoSansKr(
                      textStyle: const TextStyle(
                        color: Color(0xff868686),
                        fontWeight: FontWeight.w400,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 7),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(
                    color: Color(0xffCECECE),
                    width: 2,
                  ),
                ),
                child: Row(
                  children: [
                    Text(
                      'KOR',
                      style: GoogleFonts.notoSansKr(
                        textStyle: const TextStyle(
                          color: Color(0xff616161),
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 23,
                    ),
                    Icon(Icons.arrow_drop_down),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 14,
          ),
          Divider(),
          Text(
            '@2022-2022 LOGO Lab, Inc. (주)아무개  서울시 강남구',
            style: GoogleFonts.notoSansKr(
              textStyle: const TextStyle(
                color: Color(0xff616161),
                fontWeight: FontWeight.w400,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent() {
    return SafeArea(
      child: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildHeaderSection(),
            _buildTop3ProductSection(),
            const SizedBox(height: 10),
            _buildTop10UserSection(),
            _buildFooterSection(),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildContent(),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(10),
            topLeft: Radius.circular(10),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              spreadRadius: 0,
              blurRadius: 5,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
          child: BottomNavigationBar(
            backgroundColor: Colors.white,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                label: '홈',
                activeIcon: Image.asset(
                  ImageHelper.getSourceByPng('home'),
                ),
                icon: Image.asset(
                  ImageHelper.getSourceByPng('home'),
                ),
              ),
              BottomNavigationBarItem(
                label: '카테고리',
                activeIcon: Image.asset(
                  ImageHelper.getSourceByPng('category'),
                ),
                icon: Image.asset(
                  ImageHelper.getSourceByPng('category'),
                ),
              ),
              BottomNavigationBarItem(
                label: '커뮤니티',
                activeIcon: Image.asset(
                  ImageHelper.getSourceByPng('community'),
                ),
                icon: Image.asset(
                  ImageHelper.getSourceByPng('community'),
                ),
              ),
              BottomNavigationBarItem(
                label: '마이페이지',
                activeIcon: Image.asset(
                  ImageHelper.getSourceByPng('account'),
                ),
                icon: Image.asset(
                  ImageHelper.getSourceByPng('account'),
                ),
              ),
            ],
            type: BottomNavigationBarType.fixed,
            showUnselectedLabels: true,
          ),
        ),
      ),
    );
  }
}
