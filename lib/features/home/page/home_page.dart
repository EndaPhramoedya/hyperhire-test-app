import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gradient_borders/input_borders/gradient_outline_input_border.dart';
import 'package:hyperhire_test_app/features/home/bloc/home_bloc.dart';
import 'package:hyperhire_test_app/features/home/model/product_model.dart';
import 'package:hyperhire_test_app/features/home/widget/product_card.dart';
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
      ..add(const HomeEvent.getTop3ProductList());

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
    return Column(
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
    );
  }

  Widget _buildTop3Section() {
    return Flexible(
      child: Padding(
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
            const SizedBox(height: 15,),
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

  Widget _buildContent() {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildHeaderSection(),
          _buildTop3Section(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildContent(),
    );
  }
}
