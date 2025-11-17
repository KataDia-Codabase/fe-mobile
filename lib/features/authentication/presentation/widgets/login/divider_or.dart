import 'package:flutter/material.dart';
import '../../../../../../core/theme/index.dart';

class DividerOr extends StatelessWidget {
  const DividerOr({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Divider(
            color: AppColors.borderLight,
            height: 1,
            thickness: 1,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSpacing.md),
          child: Text(
            'atau',
            style: AppTextStyles.labelSmall,
          ),
        ),
        Expanded(
          child: Divider(
            color: AppColors.borderLight,
            height: 1,
            thickness: 1,
          ),
        ),
      ],
    );
  }
}
