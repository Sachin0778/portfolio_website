import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../constants/app_constants.dart';
import '../utils/size_extensions.dart';

class SectionHeader extends StatelessWidget {
  const SectionHeader({
    super.key,
    required this.title,
    this.eyebrow,
    this.subtitle,
  });

  final String title;
  final String? eyebrow;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (eyebrow != null) ...[
          Container(
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(999),
              border: Border.all(color: AppConstants.primaryColor.withOpacity(0.35)),
              gradient: LinearGradient(
                colors: [
                  AppConstants.primaryColor.withOpacity(0.12),
                  AppConstants.secondaryColor.withOpacity(0.08),
                ],
              ),
            ),
            child: Text(
              eyebrow!,
              style: TextStyle(
                fontSize: 11.sp,
                fontWeight: FontWeight.w600,
                letterSpacing: 1.2,
                color: AppConstants.secondaryColor,
              ),
            ),
          ).animate().fadeIn().slideY(begin: 0.05),
          SizedBox(height: 14.h),
        ],
        ShaderMask(
          shaderCallback: (bounds) =>
              AppConstants.heroTitleGradient.createShader(bounds),
          blendMode: BlendMode.srcIn,
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 26.sp,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.5,
              color: Colors.white,
              height: 1.15,
            ),
          ),
        ).animate().fadeIn(delay: 80.ms).slideY(begin: 0.06),
        SizedBox(height: 12.h),
        Container(
          width: 48.w,
          height: 4.h,
          decoration: BoxDecoration(
            gradient: AppConstants.primaryGradient,
            borderRadius: BorderRadius.circular(4),
            boxShadow: [
              BoxShadow(
                color: AppConstants.secondaryColor.withOpacity(0.35),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
        ).animate().fadeIn(delay: 160.ms).scaleX(),
        if (subtitle != null) ...[
          SizedBox(height: 14.h),
          Text(
            subtitle!,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14.sp,
              height: 1.5,
              color: AppConstants.textSecondary,
            ),
          ).animate().fadeIn(delay: 240.ms).slideY(begin: 0.04),
        ],
      ],
    );
  }
}
