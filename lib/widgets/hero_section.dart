import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../constants/app_constants.dart';
import '../controllers/portfolio_controller.dart';
import '../utils/size_extensions.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PortfolioController>();

    return Padding(
      padding: EdgeInsets.only(
        top: AppConstants.paddingLarge.h,
        bottom: AppConstants.paddingXLarge.h,
      ),
      child: Obx(() {
        final portfolioData = controller.portfolioData.value;
        if (portfolioData == null) return const SizedBox.shrink();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 7.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(999),
                border: Border.all(color: AppConstants.secondaryColor.withOpacity(0.35)),
                gradient: LinearGradient(
                  colors: [
                    AppConstants.secondaryColor.withOpacity(0.14),
                    AppConstants.primaryColor.withOpacity(0.1),
                  ],
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.auto_awesome, size: 15.sp, color: AppConstants.secondaryColor),
                  SizedBox(width: 8.w),
                  Text(
                    'Design · Code · Ship',
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.6,
                      color: AppConstants.secondaryColor,
                    ),
                  ),
                ],
              ),
            ).animate().fadeIn(delay: 100.ms).slideX(begin: -0.04),

            SizedBox(height: 22.h),

            Text(
              'Hello — I\'m',
              style: TextStyle(
                fontSize: 17.sp,
                fontWeight: FontWeight.w500,
                color: AppConstants.textSecondary,
                letterSpacing: 0.4,
              ),
            ).animate().fadeIn(delay: 180.ms).slideY(begin: 0.06),

            SizedBox(height: 10.h),

            ShaderMask(
              shaderCallback: (bounds) => AppConstants.heroTitleGradient.createShader(bounds),
              blendMode: BlendMode.srcIn,
              child: Text(
                portfolioData.name,
                style: TextStyle(
                  fontSize: 42.sp,
                  fontWeight: FontWeight.w900,
                  letterSpacing: -1.2,
                  height: 1.05,
                  color: Colors.white,
                ),
              ),
            ).animate().fadeIn(delay: 260.ms).slideY(begin: 0.05),

            SizedBox(height: 12.h),

            ShaderMask(
              shaderCallback: (bounds) =>
                  AppConstants.primaryGradient.createShader(bounds),
              blendMode: BlendMode.srcIn,
              child: Text(
                portfolioData.title,
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w700,
                  height: 1.25,
                  color: Colors.white,
                ),
              ),
            ).animate().fadeIn(delay: 340.ms).slideY(begin: 0.04),

            SizedBox(height: 18.h),

            Text(
              portfolioData.bio,
              style: TextStyle(
                fontSize: 15.sp,
                color: AppConstants.textSecondary,
                height: 1.65,
              ),
            ).animate().fadeIn(delay: 420.ms).slideY(begin: 0.03),

            SizedBox(height: 28.h),

            Wrap(
              spacing: 14.w,
              runSpacing: 12.h,
              children: [
                _GradientButton(
                  label: 'View my work',
                  icon: Icons.arrow_outward_rounded,
                  onPressed: () => controller.navigateToSection('projects'),
                ).animate().fadeIn(delay: 500.ms).scale(begin: const Offset(0.94, 0.94)),
                _OutlineGlowButton(
                  label: 'Get in touch',
                  icon: Icons.chat_bubble_outline_rounded,
                  onPressed: () => controller.navigateToSection('contact'),
                ).animate().fadeIn(delay: 580.ms).scale(begin: const Offset(0.94, 0.94)),
              ],
            ),

            SizedBox(height: 32.h),

            Text(
              'Connect',
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
                letterSpacing: 1.4,
                color: AppConstants.textTertiary,
              ),
            ).animate().fadeIn(delay: 640.ms),

            SizedBox(height: 12.h),

            Wrap(
              spacing: 10.w,
              runSpacing: 10.h,
              children: portfolioData.socialLinks.map((link) {
                return _SocialChip(
                  platform: link.platform,
                  onPressed: () async {
                    final url = link.url;
                    if (url.isEmpty) {
                      Get.snackbar('Unavailable', 'No URL configured for ${link.platform}');
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
            ).animate().fadeIn(delay: 700.ms).slideY(begin: 0.04),

            SizedBox(height: 36.h),

            Center(
              child: Column(
                children: [
                  Text(
                    'Scroll',
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 2,
                      color: AppConstants.textTertiary,
                    ),
                  ),
                  SizedBox(height: 6.h),
                  Icon(
                    Icons.keyboard_double_arrow_down_rounded,
                    color: AppConstants.secondaryColor.withOpacity(0.85),
                    size: 28.sp,
                  )
                      .animate(onPlay: (c) => c.repeat(reverse: true))
                      .moveY(begin: 0, end: 8, duration: 1400.ms, curve: Curves.easeInOut),
                ],
              ),
            ).animate().fadeIn(delay: 900.ms),
          ],
        );
      }),
    );
  }
}

class _GradientButton extends StatelessWidget {
  const _GradientButton({
    required this.label,
    required this.icon,
    required this.onPressed,
  });

  final String label;
  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: AppConstants.primaryGradient,
        borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
        boxShadow: [
          BoxShadow(
            color: AppConstants.secondaryColor.withOpacity(0.35),
            blurRadius: 28,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 26.w, vertical: 14.h),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                    color: AppConstants.backgroundColor,
                  ),
                ),
                SizedBox(width: 8.w),
                Icon(icon, size: 18.sp, color: AppConstants.backgroundColor),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _OutlineGlowButton extends StatefulWidget {
  const _OutlineGlowButton({
    required this.label,
    required this.icon,
    required this.onPressed,
  });

  final String label;
  final IconData icon;
  final VoidCallback onPressed;

  @override
  State<_OutlineGlowButton> createState() => _OutlineGlowButtonState();
}

class _OutlineGlowButtonState extends State<_OutlineGlowButton> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      cursor: SystemMouseCursors.click,
      child: AnimatedContainer(
        duration: AppConstants.animationDuration,
        curve: Curves.easeOutCubic,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
          border: Border.all(
            color: _hover ? AppConstants.secondaryColor : AppConstants.secondaryColor.withOpacity(0.45),
            width: _hover ? 2 : 1.2,
          ),
          boxShadow: _hover
              ? [
                  BoxShadow(
                    color: AppConstants.secondaryColor.withOpacity(0.18),
                    blurRadius: 24,
                    offset: const Offset(0, 10),
                  ),
                ]
              : null,
        ),
        child: Material(
          color: AppConstants.surfaceColor.withOpacity(_hover ? 0.55 : 0.35),
          borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
          child: InkWell(
            onTap: widget.onPressed,
            borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 26.w, vertical: 14.h),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    widget.icon,
                    size: 18.sp,
                    color: AppConstants.secondaryColor,
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    widget.label,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                      color: AppConstants.secondaryColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SocialChip extends StatefulWidget {
  const _SocialChip({required this.platform, required this.onPressed});

  final String platform;
  final VoidCallback onPressed;

  @override
  State<_SocialChip> createState() => _SocialChipState();
}

class _SocialChipState extends State<_SocialChip> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      cursor: SystemMouseCursors.click,
      child: AnimatedScale(
        scale: _hover ? 1.06 : 1.0,
        duration: AppConstants.animationDuration,
        curve: Curves.easeOutCubic,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: widget.onPressed,
            borderRadius: BorderRadius.circular(14),
            child: Ink(
              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: AppConstants.primaryColor.withOpacity(_hover ? 0.45 : 0.18),
                ),
                gradient: LinearGradient(
                  colors: [
                    AppConstants.cardColor.withOpacity(_hover ? 0.95 : 0.75),
                    AppConstants.surfaceColor.withOpacity(0.5),
                  ],
                ),
              ),
              child: FaIcon(
                _iconFor(widget.platform),
                color: _hover ? AppConstants.secondaryColor : AppConstants.textSecondary,
                size: 18.sp,
              ),
            ),
          ),
        ),
      ),
    );
  }

  IconData _iconFor(String platform) {
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
