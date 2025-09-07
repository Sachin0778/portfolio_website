import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../utils/size_extensions.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../controllers/portfolio_controller.dart';
import '../constants/app_constants.dart';
import 'package:url_launcher/url_launcher_string.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

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
        color: AppConstants.surfaceColor,
        border: Border(
          top: BorderSide(
            color: AppConstants.primaryColor.withOpacity(0.1),
            width: 1,
          ),
        ),
      ),
      child: Obx(() {
        final portfolioData = controller.portfolioData.value;
        if (portfolioData == null) return const SizedBox.shrink();

        return Column(
          children: [
            // Footer Content
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Left Side - Brand Info
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Portfolio',
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                          color: AppConstants.primaryColor,
                        ),
                      ).animate().fadeIn().slideX(),

                      SizedBox(height: 8.h),

                      Text(
                        'Flutter Developer & Mobile App Specialist',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: AppConstants.textPrimary,
                        ),
                      ).animate().fadeIn(delay: 200.ms).slideX(),

                      SizedBox(height: 4.h),

                      Text(
                        portfolioData.bio,
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: AppConstants.textSecondary,
                          height: 1.5,
                        ),
                      ).animate().fadeIn(delay: 400.ms).slideX(),

                      SizedBox(height: 16.h),

                      // Social Links
                      Row(
                        children: portfolioData.socialLinks.map((link) {
                          return Container(
                            margin: EdgeInsets.only(right: 16.w),
                            child: IconButton(
                              onPressed: () async {
                                final url = link.url;
                                if (url.isEmpty) {
                                  Get.snackbar('Unavailable', 'No URL configured for ${link.platform}');
                                  return;
                                }
                                final launched = await launchUrlString(url, mode: LaunchMode.externalApplication);
                                if (!launched) {
                                  Get.snackbar('Failed', 'Could not open ${link.platform}');
                                }
                              },
                              icon: FaIcon(
                                _getSocialIcon(link.platform),
                                color: AppConstants.textSecondary,
                                size: 20.sp,
                              ),
                            ),
                          );
                        }).toList(),
                      ).animate().fadeIn(delay: 600.ms).slideY(),
                    ],
                  ),
                ),

                SizedBox(width: 48.w),

                // Right Side - Quick Links
                if (MediaQuery.of(context).size.width > AppConstants.tabletBreakpoint)
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Quick Links',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: AppConstants.textPrimary,
                          ),
                        ).animate().fadeIn(delay: 800.ms).slideX(),

                        SizedBox(height: 12.h),

                        _FooterLink(
                          title: 'About',
                          onTap: () => controller.navigateToSection('about'),
                        ).animate().fadeIn(delay: 1000.ms).slideX(),
                        _FooterLink(
                          title: 'Skills',
                          onTap: () => controller.navigateToSection('skills'),
                        ).animate().fadeIn(delay: 1200.ms).slideX(),
                        _FooterLink(
                          title: 'Projects',
                          onTap: () => controller.navigateToSection('projects'),
                        ).animate().fadeIn(delay: 1400.ms).slideX(),
                        _FooterLink(
                          title: 'Experience',
                          onTap: () => controller.navigateToSection('experience'),
                        ).animate().fadeIn(delay: 1600.ms).slideX(),
                        _FooterLink(
                          title: 'Contact',
                          onTap: () => controller.navigateToSection('contact'),
                        ).animate().fadeIn(delay: 1800.ms).slideX(),
                      ],
                    ),
                  ),
              ],
            ),

            SizedBox(height: 24.h),

            // Divider
            Container(
              height: 1.h,
              color: AppConstants.primaryColor.withOpacity(0.1),
            ).animate().fadeIn(delay: 2000.ms).scaleX(),

            SizedBox(height: 16.h),

            // Bottom Section (responsive)
            Builder(builder: (context) {
              final isNarrow = MediaQuery.of(context).size.width <= 500;
              if (isNarrow) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      '© 2024 ${portfolioData.name}. All rights reserved.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: AppConstants.textTertiary,
                      ),
                    ).animate().fadeIn(delay: 2200.ms).slideY(),
                    SizedBox(height: 8.h),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Made with ',
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: AppConstants.textTertiary,
                          ),
                        ),
                        Icon(
                          Icons.favorite,
                          color: Colors.red,
                          size: 16.sp,
                        ),
                        Text(
                          ' using Flutter',
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: AppConstants.textTertiary,
                          ),
                        ),
                      ],
                    ).animate().fadeIn(delay: 2400.ms).slideY(),
                  ],
                );
              }
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '© 2024 ${portfolioData.name}. All rights reserved.',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: AppConstants.textTertiary,
                    ),
                  ).animate().fadeIn(delay: 2200.ms).slideX(),
                  Row(
                    children: [
                      Text(
                        'Made with ',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: AppConstants.textTertiary,
                        ),
                      ),
                      Icon(
                        Icons.favorite,
                        color: Colors.red,
                        size: 16.sp,
                      ),
                      Text(
                        ' using Flutter',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: AppConstants.textTertiary,
                        ),
                      ),
                    ],
                  ).animate().fadeIn(delay: 2400.ms).slideX(),
                ],
              );
            }),
          ],
        );
      }),
    );
  }

  IconData _getSocialIcon(String platform) {
    switch (platform.toLowerCase()) {
      case 'github':
        return FontAwesomeIcons.github;
      case 'linkedin':
        return FontAwesomeIcons.linkedin;
      case 'twitter':
        return FontAwesomeIcons.twitter;
      case 'email':
        return FontAwesomeIcons.envelope;
      case 'medium':
        return FontAwesomeIcons.medium;
      default:
        return FontAwesomeIcons.link;
    }
  }
}

class _FooterLink extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const _FooterLink({
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 6.h),
      child: InkWell(
        onTap: onTap,
        child: Text(
          title,
          style: TextStyle(
            fontSize: 12.sp,
            color: AppConstants.textSecondary,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
