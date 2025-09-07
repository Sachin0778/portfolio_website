import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../utils/size_extensions.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../controllers/portfolio_controller.dart';
import '../constants/app_constants.dart';
import 'package:url_launcher/url_launcher_string.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PortfolioController>();

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: AppConstants.paddingLarge.w,
        vertical: AppConstants.paddingXLarge.h,
      ),
      child: Obx(() {
        final portfolioData = controller.portfolioData.value;
        if (portfolioData == null) return const SizedBox.shrink();

        return Column(
          children: [
            // Section Title
            Text(
              'About Me',
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

            // Content
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Left Side - About Text
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        portfolioData.aboutText,
                        style: TextStyle(
                          fontSize: 10.sp,
                          color: AppConstants.textSecondary,
                          height: 1.3,
                        ),
                      ).animate().fadeIn(delay: 400.ms).slideX(),

                      SizedBox(height: 8.h),

                      // Services
                      Text(
                        'What I Do',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                          color: AppConstants.textPrimary,
                        ),
                      ).animate().fadeIn(delay: 600.ms).slideX(),

                      SizedBox(height: 6.h),

                      // Services Grid
                      AnimationLimiter(
                        child: Column(
                          children: AnimationConfiguration.toStaggeredList(
                            duration: const Duration(milliseconds: 600),
                            childAnimationBuilder: (widget) => SlideAnimation(
                              verticalOffset: 50.0,
                              child: FadeInAnimation(child: widget),
                            ),
                            children: portfolioData.services.map((service) {
                            return Container(
                              margin: EdgeInsets.only(bottom: 4.h),
                              padding: EdgeInsets.all(2.w),
                                decoration: BoxDecoration(
                                  color: AppConstants.cardColor,
                                  borderRadius: BorderRadius.circular(AppConstants.radiusLarge),
                                  border: Border.all(
                                    color: AppConstants.primaryColor.withOpacity(0.1),
                                    width: 1,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 24.w,
                                      height: 24.w,
                                      decoration: BoxDecoration(
                                        gradient: AppConstants.primaryGradient,
                                        borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
                                      ),
                                      child: Icon(
                                        _getServiceIcon(service),
                                        color: AppConstants.textPrimary,
                                        size: 12.sp,
                                      ),
                                    ),
                                    SizedBox(width: 6.w),
                                    Expanded(
                                      child: Text(
                                        service,
                                        style: TextStyle(
                                          fontSize: 10.sp,
                                          fontWeight: FontWeight.w600,
                                          color: AppConstants.textPrimary,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(width: 48.w),

                // Right Side - Stats
                if (MediaQuery.of(context).size.width > AppConstants.tabletBreakpoint)
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        _StatCard(
                          number: '2+',
                          label: 'Years Experience',
                          icon: Icons.work_outline,
                        ).animate().fadeIn(delay: 800.ms).scale(),
                        SizedBox(height: 16.h),
                        _StatCard(
                          number: '${portfolioData.projects.length}+',
                          label: 'Projects Completed',
                          icon: Icons.code,
                        ).animate().fadeIn(delay: 1000.ms).scale(),
                        SizedBox(height: 16.h),
                        _StatCard(
                          number: '${portfolioData.skills.length}+',
                          label: 'Technologies',
                          icon: Icons.psychology,
                        ).animate().fadeIn(delay: 1200.ms).scale(),
                        SizedBox(height: 16.h),
                        _StatCard(
                          number: '100%',
                          label: 'Client Satisfaction',
                          icon: Icons.thumb_up,
                        ).animate().fadeIn(delay: 1400.ms).scale(),
                      ],
                    ),
                  ),
              ],
            ),

            SizedBox(height: 24.h),

            // Download Resume Button
            Center(
              child: ElevatedButton.icon(
                onPressed: () async {
                  final controller = Get.find<PortfolioController>();
                  final data = controller.portfolioData.value;
                  final url = data?.resumeUrl ?? '';
                  if (url.isEmpty) {
                    Get.snackbar('Unavailable', 'No resume URL configured');
                    return;
                  }
                  final ok = await launchUrlString(url, mode: LaunchMode.externalApplication);
                  if (!ok) {
                    Get.snackbar('Failed', 'Could not open resume');
                  }
                },
                icon: Icon(Icons.download, size: 20.sp),
                label: Text(
                  'Download Resume',
                  style: TextStyle(fontSize: 16.sp),
                ),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(
                    horizontal: 32.w,
                    vertical: 16.h,
                  ),
                ),
              ),
            ).animate().fadeIn(delay: 1600.ms).scale(),
          ],
        );
      }),
    );
  }

  IconData _getServiceIcon(String service) {
    switch (service.toLowerCase()) {
      case 'mobile app development':
        return Icons.phone_android;
      case 'ui/ux design':
        return Icons.design_services;
      case 'cross-platform solutions':
        return Icons.devices;
      case 'app store deployment':
        return Icons.store;
      case 'code review & optimization':
        return Icons.rate_review;
      case 'technical consulting':
        return Icons.support_agent;
      default:
        return Icons.work;
    }
  }
}

class _StatCard extends StatelessWidget {
  final String number;
  final String label;
  final IconData icon;

  const _StatCard({
    required this.number,
    required this.label,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
          Container(
            width: 60.w,
            height: 60.w,
            decoration: BoxDecoration(
              gradient: AppConstants.primaryGradient,
              borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
            ),
            child: Icon(
              icon,
              color: AppConstants.textPrimary,
              size: 28.sp,
            ),
          ),
          SizedBox(height: 16.h),
          Text(
            number,
            style: TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
              color: AppConstants.primaryColor,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            label,
            style: TextStyle(
              fontSize: 14.sp,
              color: AppConstants.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
