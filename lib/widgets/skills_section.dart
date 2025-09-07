import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../utils/size_extensions.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../controllers/portfolio_controller.dart';
import '../constants/app_constants.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PortfolioController>();

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: AppConstants.paddingLarge.w,
        vertical: AppConstants.paddingXLarge.h,
      ),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppConstants.surfaceColor,
            AppConstants.backgroundColor,
          ],
        ),
      ),
      child: Obx(() {
        final portfolioData = controller.portfolioData.value;
        if (portfolioData == null) return const SizedBox.shrink();

        final skillCategories = controller.getSkillCategories();

        return Column(
          children: [
            // Section Title
            Text(
              'Skills & Technologies',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: AppConstants.textPrimary,
              ),
            ).animate().fadeIn().slideY(),

            SizedBox(height: 2.h),

            Container(
              width: 30.w,
              height: 2.h,
              decoration: BoxDecoration(
                gradient: AppConstants.primaryGradient,
                borderRadius: BorderRadius.circular(2),
              ),
            ).animate().fadeIn(delay: 200.ms).scaleX(),

            SizedBox(height: 8.h),

            // Skills by Category
            ...skillCategories.map((category) {
              final categorySkills = controller.getSkillsByCategory(category);
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Category Title
                  Text(
                    category,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      color: AppConstants.textPrimary,
                    ),
                  ).animate().fadeIn().slideX(),

                  SizedBox(height: 8.h),

                  // Skills Grid
                  AnimationLimiter(
                    child: Wrap(
                      spacing: 8.w,
                      runSpacing: 8.h,
                      children: AnimationConfiguration.toStaggeredList(
                        duration: const Duration(milliseconds: 600),
                        childAnimationBuilder: (widget) => SlideAnimation(
                          verticalOffset: 50.0,
                          child: FadeInAnimation(child: widget),
                        ),
                        children: categorySkills.map((skill) {
                          return _SkillCard(skill: skill);
                        }).toList(),
                      ),
                    ),
                  ),

                  SizedBox(height: 12.h),
                ],
              );
            }).toList(),

            // Overall Proficiency
            Container(
              padding: EdgeInsets.all(AppConstants.paddingLarge.w),
              decoration: BoxDecoration(
                color: AppConstants.cardColor,
                borderRadius: BorderRadius.circular(AppConstants.radiusLarge),
                border: Border.all(
                  color: AppConstants.primaryColor.withOpacity(0.1),
                  width: 1,
                ),
              ),
              child: Column(
                children: [
                  Text(
                    'Overall Proficiency',
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                      color: AppConstants.textPrimary,
                    ),
                  ),
                  SizedBox(height: 24.h),
                  Row(
                    children: [
                      Expanded(
                        child: _ProficiencyBar(
                          label: 'Mobile Development',
                          percentage: 0.95,
                          color: AppConstants.primaryColor,
                        ),
                      ),
                      SizedBox(width: 16.w),
                      Expanded(
                        child: _ProficiencyBar(
                          label: 'UI/UX Design',
                          percentage: 0.85,
                          color: AppConstants.secondaryColor,
                        ),
                      ),
                      SizedBox(width: 16.w),
                      Expanded(
                        child: _ProficiencyBar(
                          label: 'Backend Integration',
                          percentage: 0.80,
                          color: AppConstants.accentColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ).animate().fadeIn(delay: 800.ms).slideY(),
          ],
        );
      }),
    );
  }
}

class _SkillCard extends StatelessWidget {
  final dynamic skill;

  const _SkillCard({required this.skill});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: AppConstants.cardColor,
        borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
        border: Border.all(
          color: AppConstants.primaryColor.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          // Skill Icon
          Container(
            width: 32.w,
            height: 32.w,
            decoration: BoxDecoration(
              color: AppConstants.primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
            ),
            child: Icon(
              _getSkillIcon(skill.name),
              color: AppConstants.primaryColor,
              size: 16.sp,
            ),
          ),
          SizedBox(height: 6.h),
          
          // Skill Name
          Text(
            skill.name,
            style: TextStyle(
              fontSize: 10.sp,
              fontWeight: FontWeight.w600,
              color: AppConstants.textPrimary,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 4.h),
          
          // Proficiency Bar
          Container(
            width: 60.w,
            height: 3.h,
            decoration: BoxDecoration(
              color: AppConstants.textTertiary.withOpacity(0.2),
              borderRadius: BorderRadius.circular(2),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: skill.proficiency,
              child: Container(
                decoration: BoxDecoration(
                  gradient: AppConstants.primaryGradient,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  IconData _getSkillIcon(String skillName) {
    switch (skillName.toLowerCase()) {
      case 'flutter':
        return Icons.phone_android;
      case 'dart':
        return Icons.code;
      case 'android':
        return Icons.android;
      case 'ios':
        return Icons.phone_iphone;
      case 'firebase':
        return Icons.cloud;
      case 'sqlite':
        return Icons.storage;
      case 'javascript':
        return Icons.javascript;
      case 'python':
        return Icons.code;
      case 'java':
        return Icons.code;
      case 'figma':
        return Icons.design_services;
      case 'material design':
        return Icons.palette;
      default:
        return Icons.extension;
    }
  }
}

class _ProficiencyBar extends StatelessWidget {
  final String label;
  final double percentage;
  final Color color;

  const _ProficiencyBar({
    required this.label,
    required this.percentage,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 14.sp,
                  color: AppConstants.textSecondary,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                softWrap: false,
              ),
            ),
            SizedBox(width: 8.w),
            Text(
              '${(percentage * 100).toInt()}%',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
          ],
        ),
        SizedBox(height: 8.h),
        Container(
          height: 6.h,
          decoration: BoxDecoration(
            color: AppConstants.textTertiary.withOpacity(0.2),
            borderRadius: BorderRadius.circular(3),
          ),
          child: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: percentage,
            child: Container(
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(3),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
