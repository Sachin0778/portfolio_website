import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../utils/size_extensions.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../controllers/portfolio_controller.dart';
import '../constants/app_constants.dart';
import '../models/experience_model.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

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

        return Column(
          children: [
            // Section Title
            Text(
              'Work Experience',
              style: TextStyle(
                fontSize: 28.sp,
                fontWeight: FontWeight.bold,
                color: AppConstants.textPrimary,
              ),
            ).animate().fadeIn().slideY(),

            SizedBox(height: 8.h),

            Container(
              width: 60.w,
              height: 3.h,
              decoration: BoxDecoration(
                gradient: AppConstants.primaryGradient,
                borderRadius: BorderRadius.circular(2),
              ),
            ).animate().fadeIn(delay: 200.ms).scaleX(),

            SizedBox(height: 24.h),

            // Experience Timeline
            AnimationLimiter(
              child: Column(
                children: AnimationConfiguration.toStaggeredList(
                  duration: const Duration(milliseconds: 600),
                  childAnimationBuilder: (widget) => SlideAnimation(
                    verticalOffset: 50.0,
                    child: FadeInAnimation(child: widget),
                  ),
                  children: portfolioData.experiences.asMap().entries.map((entry) {
                    final index = entry.key;
                    final experience = entry.value;
                    return _ExperienceCard(
                      experience: experience,
                      isLast: index == portfolioData.experiences.length - 1,
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}

class _ExperienceCard extends StatelessWidget {
  final ExperienceModel experience;
  final bool isLast;

  const _ExperienceCard({
    required this.experience,
    required this.isLast,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Timeline Indicator
          Column(
            children: [
              Container(
                width: 50.w,
                height: 50.w,
                decoration: BoxDecoration(
                  gradient: AppConstants.primaryGradient,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppConstants.primaryColor.withOpacity(0.3),
                      blurRadius: 10,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: ClipOval(
                  child: Image.asset(
                    experience.companyLogo,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(
                        Icons.business,
                        color: AppConstants.textPrimary,
                        size: 24.sp,
                      );
                    },
                  ),
                ),
              ),
              if (!isLast)
                Container(
                  width: 2.w,
                  height: 60.h,
                  color: AppConstants.primaryColor.withOpacity(0.3),
                ),
            ],
          ),

          SizedBox(width: 24.w),

          // Experience Content
          Expanded(
            child: Container(
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Company and Position
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              experience.position,
                              style: TextStyle(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.bold,
                                color: AppConstants.textPrimary,
                              ),
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              experience.company,
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                                color: AppConstants.primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12.w,
                          vertical: 6.h,
                        ),
                        decoration: BoxDecoration(
                          color: experience.isCurrent
                              ? AppConstants.primaryColor.withOpacity(0.1)
                              : AppConstants.textTertiary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(AppConstants.radiusSmall),
                        ),
                        child: Text(
                          experience.isCurrent ? 'Current' : 'Past',
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                            color: experience.isCurrent
                                ? AppConstants.primaryColor
                                : AppConstants.textTertiary,
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 8.h),

                  // Location and Duration
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        size: 16.sp,
                        color: AppConstants.textSecondary,
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        experience.location,
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: AppConstants.textSecondary,
                        ),
                      ),
                      SizedBox(width: 16.w),
                      Icon(
                        Icons.calendar_today,
                        size: 16.sp,
                        color: AppConstants.textSecondary,
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        '${_formatDate(experience.startDate)} - ${experience.isCurrent ? 'Present' : _formatDate(experience.endDate!)}',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: AppConstants.textSecondary,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 16.h),

                  // Description
                  Text(
                    experience.description,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: AppConstants.textSecondary,
                      height: 1.6,
                    ),
                  ),

                  SizedBox(height: 16.h),

                  // Achievements
                  Text(
                    'Key Achievements:',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: AppConstants.textPrimary,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  ...experience.achievements.map((achievement) {
                    return Container(
                      margin: EdgeInsets.only(bottom: 4.h),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 4.w,
                            height: 4.w,
                            margin: EdgeInsets.only(top: 6.h, right: 8.w),
                            decoration: BoxDecoration(
                              color: AppConstants.primaryColor,
                              shape: BoxShape.circle,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              achievement,
                              style: TextStyle(
                                fontSize: 13.sp,
                                color: AppConstants.textSecondary,
                                height: 1.5,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.month}/${date.year}';
  }
}
