import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../utils/size_extensions.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../controllers/portfolio_controller.dart';
import '../constants/app_constants.dart';
import 'package:url_launcher/url_launcher_string.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

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
            AppConstants.backgroundColor,
            AppConstants.surfaceColor,
          ],
        ),
      ),
      child: Obx(() {
        final portfolioData = controller.portfolioData.value;
        if (portfolioData == null) return const SizedBox.shrink();

        return Column(
          children: [
            // Main Content
            Row(
              children: [
                // Left Side - Text Content
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Greeting
                      Text(
                        'Hello, I\'m',
                        style: TextStyle(
                          fontSize: 18.sp,
                          color: AppConstants.textSecondary,
                          fontWeight: FontWeight.w400,
                        ),
                      ).animate().fadeIn(delay: 200.ms).slideX(),

                      SizedBox(height: 8.h),

                      // Name
                      Text(
                        portfolioData.name,
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          color: AppConstants.textPrimary,
                          height: 1.1,
                        ),
                      ).animate().fadeIn(delay: 400.ms).slideX(),

                      SizedBox(height: 2.h),

                      // Title with gradient
                      ShaderMask(
                        shaderCallback: (bounds) => AppConstants.primaryGradient.createShader(bounds),
                        child: Text(
                          portfolioData.title,
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                            height: 1.2,
                          ),
                        ),
                      ).animate().fadeIn(delay: 600.ms).slideX(),

                      SizedBox(height: 4.h),

                      // Bio
                      Text(
                        portfolioData.bio,
                        style: TextStyle(
                          fontSize: 10.sp,
                          color: AppConstants.textSecondary,
                          height: 1.3,
                        ),
                      ).animate().fadeIn(delay: 800.ms).slideX(),

                      SizedBox(height: 8.h),

                      // CTA Buttons
                      Row(
                        children: [
                          ElevatedButton(
                            onPressed: () => controller.navigateToSection('projects'),
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                horizontal: 12.w,
                                vertical: 6.h,
                              ),
                            ),
                            child: Text(
                              'View My Work',
                              style: TextStyle(
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ).animate().fadeIn(delay: 1000.ms).scale(),

                          SizedBox(width: 6.w),

                          OutlinedButton(
                            onPressed: () => controller.navigateToSection('contact'),
                            style: OutlinedButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                horizontal: 12.w,
                                vertical: 6.h,
                              ),
                              side: const BorderSide(
                                color: AppConstants.primaryColor,
                                width: 1,
                              ),
                            ),
                            child: Text(
                              'Get In Touch',
                              style: TextStyle(
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w600,
                                color: AppConstants.primaryColor,
                              ),
                            ),
                          ).animate().fadeIn(delay: 1200.ms).scale(),
                        ],
                      ),

                      SizedBox(height: 8.h),

                      // Social Links
                      Row(
                        children: portfolioData.socialLinks.map((link) {
                          return Container(
                            margin: EdgeInsets.only(right: 4.w),
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
                                size: 12.sp,
                              ),
                            ),
                          );
                        }).toList(),
                      ).animate().fadeIn(delay: 1400.ms).slideY(),
                    ],
                  ),
                ),

                // Right Side - Profile Image (Desktop only)
                // if (MediaQuery.of(context).size.width > AppConstants.tabletBreakpoint)
                //   Expanded(
                //     flex: 1,
                //     child: Center(
                //       child: Container(
                //         width: 300.w,
                //         height: 300.w,
                //         decoration: BoxDecoration(
                //           shape: BoxShape.circle,
                //           gradient: AppConstants.primaryGradient,
                //           boxShadow: [
                //             BoxShadow(
                //               color: AppConstants.primaryColor.withOpacity(0.3),
                //               blurRadius: 20,
                //               spreadRadius: 5,
                //             ),
                //           ],
                //         ),
                //         child: Container(
                //           margin: EdgeInsets.all(4.w),
                //           decoration: BoxDecoration(
                //             shape: BoxShape.circle,
                //             color: AppConstants.backgroundColor,
                //           ),
                //           child: ClipOval(
                //             child: Image.asset(
                //               portfolioData.profileImage,
                //               fit: BoxFit.cover,
                //               errorBuilder: (context, error, stackTrace) {
                //                 return Icon(
                //                   Icons.person,
                //                   size: 100.sp,
                //                   color: AppConstants.textSecondary,
                //                 );
                //               },
                //             ),
                //           ),
                //         ),
                //       ),
                //     ),
                //   ).animate().fadeIn(delay: 1000.ms).scale(),
              ],
            ),

            SizedBox(height: 12.h),

            // Scroll Indicator
            Column(
              children: [
                Text(
                  'Scroll Down',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: AppConstants.textTertiary,
                  ),
                ),
                SizedBox(height: 8.h),
                Icon(
                  Icons.keyboard_arrow_down,
                  color: AppConstants.textTertiary,
                  size: 24.sp,
                ),
              ],
            ).animate().fadeIn(delay: 1600.ms).slideY(),
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
