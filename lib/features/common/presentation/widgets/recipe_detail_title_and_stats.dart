import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe/core/utils/colors.dart';
import 'package:recipe/features/common/presentation/widgets/recipe_rating.dart';
import 'package:recipe/features/common/presentation/widgets/recipe_reviews.dart';

class RecipeDetailTitleAndStats extends StatelessWidget {
  const RecipeDetailTitleAndStats({
    super.key,
    required this.title,
    required this.rating,
    required this.reviews,
  });

  final String title;
  final int reviews;
  final num rating;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        width: 357.w,
        height: 150.h,
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 16.h),
        decoration: BoxDecoration(
          color: AppColors.redPinkMain,
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(10)),
        ),
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              overflow: TextOverflow.ellipsis,
              title,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            Row(
              spacing: 10.w,
              children: [
                RecipeRating(
                  rating: rating,
                  textColor: Colors.white,
                  iconColor: Colors.white,
                  swap: true,
                ),
                RecipeReviews(reviews: reviews),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
