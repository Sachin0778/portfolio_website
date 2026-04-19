import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../constants/app_constants.dart';
import '../controllers/portfolio_controller.dart';
import '../utils/size_extensions.dart';
import 'depth_panel.dart';
import 'section_header.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PortfolioController>();

    return Padding(
      padding: EdgeInsets.symmetric(vertical: AppConstants.paddingXLarge.h),
      child: Obx(() {
        final portfolioData = controller.portfolioData.value;
        if (portfolioData == null) return const SizedBox.shrink();

        return Column(
          children: [
            const SectionHeader(
              eyebrow: 'Introduction',
              title: 'About Me',
              subtitle:
                  'A quick snapshot of who I am, what I build, and how I can help your team ship quality software.',
            ),
            SizedBox(height: 28.h),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DepthPanel(
                        padding: EdgeInsets.all(AppConstants.paddingLarge.w),
                        borderRadius: AppConstants.radiusXLarge,
                        child: Text(
                          portfolioData.aboutText,
                          style: TextStyle(
                            fontSize: 15.sp,
                            color: AppConstants.textSecondary,
                            height: 1.65,
                          ),
                        ),
                      ).animate().fadeIn(delay: 120.ms).slideX(begin: -0.02),
                      SizedBox(height: 28.h),
                      Text(
                        'What I do',
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w800,
                          color: AppConstants.textPrimary,
                          letterSpacing: -0.3,
                        ),
                      ).animate().fadeIn(delay: 200.ms).slideX(begin: -0.02),
                      SizedBox(height: 16.h),
                      AnimationLimiter(
                        child: Column(
                          children: AnimationConfiguration.toStaggeredList(
                            duration: const Duration(milliseconds: 550),
                            childAnimationBuilder: (widget) => SlideAnimation(
                              verticalOffset: 28.0,
                              child: FadeInAnimation(child: widget),
                            ),
                            children: portfolioData.services.map((service) {
                              return Padding(
                                padding: EdgeInsets.only(bottom: 12.h),
                                child: _ServiceTile(service: service),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 28.h),
            Center(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: AppConstants.primaryGradient,
                  borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
                  boxShadow: [
                    BoxShadow(
                      color: AppConstants.secondaryColor.withOpacity(0.28),
                      blurRadius: 24,
                      offset: const Offset(0, 12),
                    ),
                  ],
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () async {
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
                    borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 28.w, vertical: 14.h),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.download_rounded, size: 20.sp, color: AppConstants.backgroundColor),
                          SizedBox(width: 10.w),
                          Text(
                            'Download resume',
                            style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w700,
                              color: AppConstants.backgroundColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ).animate().fadeIn(delay: 400.ms).scale(begin: const Offset(0.96, 0.96)),
          ],
        );
      }),
    );
  }
}

class _ServiceTile extends StatefulWidget {
  const _ServiceTile({required this.service});

  final String service;

  @override
  State<_ServiceTile> createState() => _ServiceTileState();
}

class _ServiceTileState extends State<_ServiceTile> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: AnimatedContainer(
        duration: AppConstants.animationDuration,
        curve: Curves.easeOutCubic,
        clipBehavior: Clip.antiAlias,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        decoration: AppConstants.depthPanelDecoration(
          accentColors: [AppConstants.primaryColor, AppConstants.secondaryColor],
          borderRadius: AppConstants.radiusLarge,
          boxShadow: [
            BoxShadow(
              color: AppConstants.secondaryColor.withOpacity(_hover ? 0.14 : 0.06),
              blurRadius: _hover ? 28 : 18,
              offset: const Offset(0, 10),
            ),
          ],
        ).copyWith(
          border: Border.all(
            color: _hover
                ? AppConstants.secondaryColor.withOpacity(0.45)
                : AppConstants.primaryColor.withOpacity(0.28),
            width: _hover ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 44.w,
              height: 44.w,
              decoration: BoxDecoration(
                gradient: AppConstants.primaryGradient,
                borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
                boxShadow: [
                  BoxShadow(
                    color: AppConstants.primaryColor.withOpacity(0.25),
                    blurRadius: 12,
                  ),
                ],
              ),
              child: Icon(
                _getServiceIcon(widget.service),
                color: AppConstants.backgroundColor,
                size: 20.sp,
              ),
            ),
            SizedBox(width: 14.w),
            Expanded(
              child: Text(
                widget.service,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: AppConstants.textPrimary,
                  height: 1.35,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getServiceIcon(String service) {
    switch (service.toLowerCase()) {
      case 'mobile app development':
        return Icons.phone_android_rounded;
      case 'ui/ux design':
        return Icons.design_services_rounded;
      case 'cross-platform solutions':
        return Icons.devices_rounded;
      case 'app store deployment':
        return Icons.store_rounded;
      case 'code review & optimization':
        return Icons.rate_review_rounded;
      case 'technical consulting':
        return Icons.support_agent_rounded;
      default:
        return Icons.work_outline_rounded;
    }
  }
}
