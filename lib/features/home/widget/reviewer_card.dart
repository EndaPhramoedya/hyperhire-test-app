import 'package:flutter/material.dart';
import 'package:hyperhire_test_app/features/home/model/user_model.dart';
import 'package:hyperhire_test_app/utils/image_helper.dart';

class ReviewerCard extends StatelessWidget {
  final UserModel user;

  const ReviewerCard({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              ImageHelper.getSourceByPng(user.image),
              height: 100,
              width: 100,
            ),
            const SizedBox(width: 10),
            Flexible(
              child: Text(
                user.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        if (user.isTopRank)
          Positioned(
            left: 10,
            top: 5,
            child: Image.asset(
              ImageHelper.getSourceByPng('crown'),
            ),
          ),
      ],
    );
  }
}
