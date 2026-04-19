import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../constants/app_constants.dart';
import '../controllers/portfolio_controller.dart';
import '../utils/size_extensions.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PortfolioController>();

    return Padding(
      padding: EdgeInsets.only(top: AppConstants.paddingXXLarge.h, bottom: AppConstants.paddingLarge.h),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: AppConstants.paddingXLarge.h),
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: AppConstants.secondaryColor.withOpacity(0.18)),
          ),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppConstants.surfaceColor.withOpacity(0.65),
              AppConstants.backgroundColor.withOpacity(0.4),
            ],
          ),
        ),
        child: Obx(() {
          final portfolioData = controller.portfolioData.value;
          if (portfolioData == null) return const SizedBox.shrink();

          return Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ShaderMask(
                          shaderCallback: (bounds) =>
                              AppConstants.heroTitleGradient.createShader(bounds),
                          blendMode: BlendMode.srcIn,
                          child: Text(
                            AppConstants.appName,
                            style: TextStyle(
                              fontSize: 22.sp,
                              fontWeight: FontWeight.w900,
                              letterSpacing: -0.4,
                              color: Colors.white,
                            ),
                          ),
                        ).animate().fadeIn().slideX(begin: -0.02),
                        SizedBox(height: 10.h),
                        Text(
                          portfolioData.title,
                          style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w700,
                            color: AppConstants.textPrimary,
                          ),
                        ).animate().fadeIn(delay: 120.ms).slideX(begin: -0.02),
                        SizedBox(height: 10.h),
                        Text(
                          portfolioData.bio,
                          style: TextStyle(
                            fontSize: 13.sp,
                            color: AppConstants.textSecondary,
                            height: 1.55,
                          ),
                        ).animate().fadeIn(delay: 220.ms).slideX(begin: -0.02),
                        SizedBox(height: 18.h),
                        Wrap(
                          spacing: 10.w,
                          runSpacing: 10.h,
                          children: portfolioData.socialLinks.map((link) {
                            return _FooterSocialChip(
                              platform: link.platform,
                              onTap: () async {
                                final url = link.url;
                                if (url.isEmpty) {
                                  Get.snackbar(
                                    'Unavailable',
                                    'No URL configured for ${link.platform}',
                                  );
                                  return;
                                }
                                final launched =
                                    await launchUrlString(url, mode: LaunchMode.externalApplication);
                                if (!launched) {
                                  Get.snackbar('Failed', 'Could not open ${link.platform}');
                                }
                              },
                            );
                          }).toList(),
                        ).animate().fadeIn(delay: 320.ms).slideY(begin: 0.03),
                      ],
                    ),
                  ),
                  if (MediaQuery.of(context).size.width > AppConstants.tabletBreakpoint) ...[
                    SizedBox(width: 36.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Quick links',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w800,
                              color: AppConstants.textPrimary,
                            ),
                          ).animate().fadeIn(delay: 400.ms).slideX(),
                          SizedBox(height: 14.h),
                          _FooterLink(
                            title: 'About',
                            onTap: () => controller.navigateToSection('about'),
                          ).animate().fadeIn(delay: 460.ms).slideX(),
                          _FooterLink(
                            title: 'Skills',
                            onTap: () => controller.navigateToSection('skills'),
                          ).animate().fadeIn(delay: 520.ms).slideX(),
                          _FooterLink(
                            title: 'Projects',
                            onTap: () => controller.navigateToSection('projects'),
                          ).animate().fadeIn(delay: 580.ms).slideX(),
                          _FooterLink(
                            title: 'Experience',
                            onTap: () => controller.navigateToSection('experience'),
                          ).animate().fadeIn(delay: 640.ms).slideX(),
                          _FooterLink(
                            title: 'Contact',
                            onTap: () => controller.navigateToSection('contact'),
                          ).animate().fadeIn(delay: 700.ms).slideX(),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
              SizedBox(height: 28.h),
              Container(
                height: 1,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.transparent,
                      AppConstants.primaryColor.withOpacity(0.25),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              Builder(
                builder: (context) {
                  final narrow = MediaQuery.of(context).size.width <= 500;
                  final year = DateTime.now().year;
                  final copy = Text(
                    '© $year ${portfolioData.name}. All rights reserved.',
                    textAlign: narrow ? TextAlign.center : TextAlign.start,
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: AppConstants.textTertiary,
                    ),
                  );
                  final made = Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment:
                        narrow ? MainAxisAlignment.center : MainAxisAlignment.start,
                    children: [
                      Text(
                        'Crafted with ',
                        style: TextStyle(fontSize: 13.sp, color: AppConstants.textTertiary),
                      ),
                      Icon(Icons.favorite_rounded, color: AppConstants.accentColor, size: 16.sp),
                      Text(
                        ' & Flutter',
                        style: TextStyle(fontSize: 13.sp, color: AppConstants.textTertiary),
                      ),
                    ],
                  );
                  if (narrow) {
                    return Column(
                      children: [
                        copy,
                        SizedBox(height: 10.h),
                        made,
                      ],
                    );
                  }
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [copy, made],
                  );
                },
              ),
            ],
          );
        }),
      ),
    );
  }
}

class _FooterSocialChip extends StatefulWidget {
  const _FooterSocialChip({required this.platform, required this.onTap});

  final String platform;
  final VoidCallback onTap;

  @override
  State<_FooterSocialChip> createState() => _FooterSocialChipState();
}

class _FooterSocialChipState extends State<_FooterSocialChip> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      cursor: SystemMouseCursors.click,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: widget.onTap,
          borderRadius: BorderRadius.circular(12),
          child: Ink(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: AppConstants.secondaryColor.withOpacity(_hover ? 0.45 : 0.2),
              ),
              color: AppConstants.cardColor.withOpacity(_hover ? 0.85 : 0.55),
            ),
            child: FaIcon(
              _icon(widget.platform),
              size: 18.sp,
              color: _hover ? AppConstants.secondaryColor : AppConstants.textSecondary,
            ),
          ),
        ),
      ),
    );
  }

  IconData _icon(String platform) {
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
  const _FooterLink({required this.title, required this.onTap});

  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 4.h),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 13.sp,
              color: AppConstants.textSecondary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
