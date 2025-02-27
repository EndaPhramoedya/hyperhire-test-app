import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hyperhire_test_app/features/home/model/product_model.dart';
import 'package:hyperhire_test_app/utils/image_helper.dart';

class ProductCard extends StatelessWidget {
  final ProductModel item;

  const ProductCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Stack(
          children: [
            Container(
              width: 104,
              height: 104,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                border: Border.all(
                  color: Color(0xffCECECE),
                  width: 1,
                ),
                image: DecorationImage(
                  image: AssetImage(ImageHelper.getSourceByPng(item.image)),
                ),
              ),
            ),
            Positioned(
              left: 5,
              top: 5,
              child: Image.asset(
                ImageHelper.getSourceByPng(item.rank == 1
                    ? 'rank1'
                    : item.rank == 2
                        ? 'rank2'
                        : 'rank3'),
              ),
            ),
          ],
        ),
        const SizedBox(
          width: 8,
        ),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                item.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.notoSansKr(
                  textStyle: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
              ),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: item.descriptionList
                      .map(
                        (e) => Text(
                          '\u2022 $e',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.notoSansKr(
                            textStyle: const TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Icon(
                    Icons.star,
                    color: Color(0xffFFD233),
                    size: 12,
                  ),
                  const SizedBox(width: 2),
                  Text(
                    item.rating.toString(),
                    style: GoogleFonts.notoSansKr(
                      textStyle: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 10,
                        color: Color(0xffFFD233),
                      ),
                    ),
                  ),
                  const SizedBox(width: 2),
                  Text(
                    '(${item.review})',
                    style: GoogleFonts.notoSansKr(
                      textStyle: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 10,
                        color: Color(0xffC4C4C4),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: item.tagList
                    .map(
                      (e) => Padding(
                        padding: const EdgeInsets.only(right: 4),
                        child: Chip(
                          label: Text(
                            e,
                            style: GoogleFonts.notoSansKr(
                              textStyle: const TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 11,
                                color: Color(0xff868686),
                              ),
                            ),
                          ),
                          backgroundColor: Color(0xffF0F0F0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                            side: BorderSide(color: Colors.transparent),
                          ),
                          padding: EdgeInsets.zero,
                          visualDensity: VisualDensity.compact,
                        ),
                      ),
                    )
                    .toList(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
