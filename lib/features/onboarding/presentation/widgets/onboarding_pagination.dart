import 'package:flutter/material.dart';
import '../../../../../core/theme/index.dart';

class OnboardingPagination extends StatelessWidget {
  final int currentPage;
  final int totalPages;

  const OnboardingPagination({
    super.key,
    required this.currentPage,
    required this.totalPages,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        totalPages,
        (index) => Container(
          width: currentPage == index ? AppSpacing.xxxl + AppSpacing.xs : AppSpacing.sm,
          height: AppSpacing.sm,
          margin: EdgeInsets.symmetric(horizontal: AppSpacing.xs),
          decoration: BoxDecoration(
            color: currentPage == index
                ? AppColors.primary
                : AppColors.borderLight,
            borderRadius: BorderRadius.circular(AppSpacing.xs),
          ),
        ),
      ),
    );
  }
}
