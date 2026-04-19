import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';

import '../constants/app_constants.dart';
import '../controllers/portfolio_controller.dart';
import '../models/skill_model.dart';
import '../utils/size_extensions.dart';
import 'section_header.dart';

/// Skills area — category chips, track-style rows with brand colors/icons,
/// and a compact “focus” triad (replaces the old wrap + bar block).
class SkillsSection extends StatefulWidget {
  const SkillsSection({super.key});

  @override
  State<SkillsSection> createState() => _SkillsSectionState();
}

class _SkillsSectionState extends State<SkillsSection> {
  int _categoryIndex = 0;

  Color _skillColor(SkillModel s) {
    if (s.color.trim().isEmpty) return AppConstants.secondaryColor;
    try {
      final h = s.color.replaceFirst('#', '').trim();
      if (h.length == 6) return Color(int.parse('FF$h', radix: 16));
      if (h.length == 8) return Color(int.parse(h, radix: 16));
    } catch (_) {}
    return AppConstants.secondaryColor;
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PortfolioController>();

    return Padding(
      padding: EdgeInsets.symmetric(vertical: AppConstants.paddingXLarge.h),
      child: Obx(() {
        final portfolioData = controller.portfolioData.value;
        if (portfolioData == null) return const SizedBox.shrink();

        final categories = controller.getSkillCategories();
        if (categories.isEmpty) return const SizedBox.shrink();

        _categoryIndex = _categoryIndex.clamp(0, categories.length - 1);
        final active = categories[_categoryIndex];
        final skills = controller.getSkillsByCategory(active);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SectionHeader(
              eyebrow: 'Capabilities',
              title: 'Skills & stack',
              subtitle:
                  'Pick a domain to see tools and comfort level. Colors follow each skill’s brand palette.',
            ),
            SizedBox(height: 24.h),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              child: Row(
                children: List.generate(categories.length, (i) {
                  final selected = i == _categoryIndex;
                  return Padding(
                    padding: EdgeInsets.only(right: 10.w),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () => setState(() => _categoryIndex = i),
                        borderRadius: BorderRadius.circular(999),
                        child: AnimatedContainer(
                          duration: AppConstants.animationDuration,
                          curve: Curves.easeOutCubic,
                          clipBehavior: Clip.antiAlias,
                          padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 11.h),
                          decoration: selected
                              ? AppConstants.depthPanelDecoration(
                                  accentColors: [
                                    AppConstants.secondaryColor,
                                    AppConstants.primaryColor,
                                  ],
                                  borderRadius: 999,
                                )
                              : BoxDecoration(
                                  borderRadius: BorderRadius.circular(999),
                                  border: Border.all(
                                    color: AppConstants.textTertiary.withOpacity(0.35),
                                  ),
                                  color: AppConstants.cardColor.withOpacity(0.45),
                                ),
                          child: Text(
                            categories[i],
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.2,
                              color: selected ? AppConstants.textPrimary : AppConstants.textSecondary,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ).animate().fadeIn(delay: 80.ms).slideX(begin: -0.02),
            SizedBox(height: 20.h),
            AnimatedSwitcher(
              duration: AppConstants.longAnimationDuration,
              switchInCurve: Curves.easeOutCubic,
              switchOutCurve: Curves.easeInCubic,
              layoutBuilder: (currentChild, previousChildren) {
                return Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    ...previousChildren,
                    if (currentChild != null) currentChild,
                  ],
                );
              },
              child: KeyedSubtree(
                key: ValueKey(active),
                child: Column(
                  children: [
                    for (var i = 0; i < skills.length; i++)
                      Padding(
                        padding: EdgeInsets.only(bottom: 12.h),
                        child: _SkillTrackTile(
                          skill: skills[i],
                          skillColor: _skillColor(skills[i]),
                          index: i,
                        ),
                      ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 28.h),
            Text(
              'Where I spend depth',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.w800,
                letterSpacing: 1.4,
                color: AppConstants.textTertiary,
              ),
            ),
            SizedBox(height: 16.h),
            LayoutBuilder(
              builder: (context, c) {
                final narrow = c.maxWidth < 640;
                if (narrow) {
                  return Column(
                    children: [
                      _FocusOrb(
                        label: 'Product & mobile',
                        value: 0.95,
                        caption: 'Shipping end-to-end apps',
                        colors: [AppConstants.primaryColor, AppConstants.glowPrimary],
                      ),
                      SizedBox(height: 14.h),
                      _FocusOrb(
                        label: 'Interfaces',
                        value: 0.85,
                        caption: 'Systems that feel intentional',
                        colors: [AppConstants.secondaryColor, AppConstants.glowSecondary],
                      ),
                      SizedBox(height: 14.h),
                      _FocusOrb(
                        label: 'Integration',
                        value: 0.80,
                        caption: 'APIs, data, and services',
                        colors: [AppConstants.accentColor, AppConstants.glowAccent],
                      ),
                    ],
                  );
                }
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: _FocusOrb(
                        label: 'Product & mobile',
                        value: 0.95,
                        caption: 'Shipping end-to-end apps',
                        colors: [AppConstants.primaryColor, AppConstants.glowPrimary],
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: _FocusOrb(
                        label: 'Interfaces',
                        value: 0.85,
                        caption: 'Systems that feel intentional',
                        colors: [AppConstants.secondaryColor, AppConstants.glowSecondary],
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: _FocusOrb(
                        label: 'Integration',
                        value: 0.80,
                        caption: 'APIs, data, and services',
                        colors: [AppConstants.accentColor, AppConstants.glowAccent],
                      ),
                    ),
                  ],
                );
              },
            ).animate().fadeIn(delay: 160.ms).slideY(begin: 0.04),
          ],
        );
      }),
    );
  }
}

class _SkillTrackTile extends StatelessWidget {
  const _SkillTrackTile({
    required this.skill,
    required this.skillColor,
    required this.index,
  });

  final SkillModel skill;
  final Color skillColor;
  final int index;

  @override
  Widget build(BuildContext context) {
    final pct = (skill.proficiency * 100).round();

    return Material(
      color: Colors.transparent,
      child: Container(
        clipBehavior: Clip.antiAlias,
        padding: EdgeInsets.fromLTRB(16.w, 14.h, 16.w, 14.h),
        decoration: AppConstants.depthPanelDecoration(
          accentColors: [skillColor, AppConstants.secondaryColor],
          borderRadius: AppConstants.radiusLarge,
          boxShadow: [
            BoxShadow(
              color: skillColor.withOpacity(0.1),
              blurRadius: 24,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _SkillAvatar(skill: skill, color: skillColor),
                SizedBox(width: 14.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        skill.name,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w800,
                          letterSpacing: -0.25,
                          color: AppConstants.textPrimary,
                          height: 1.2,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        skill.category,
                        style: TextStyle(
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w600,
                          color: AppConstants.textTertiary,
                          letterSpacing: 0.3,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 8.w),
                ShaderMask(
                  shaderCallback: (bounds) => LinearGradient(
                    colors: [skillColor, AppConstants.secondaryColor],
                  ).createShader(bounds),
                  blendMode: BlendMode.srcIn,
                  child: Text(
                    '$pct%',
                    style: TextStyle(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      fontFeatures: const [FontFeature.tabularFigures()],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 14.h),
            _AnimatedTrack(
              value: skill.proficiency,
              activeColor: skillColor,
              delay: Duration(milliseconds: 80 + index * 45),
            ),
          ],
        ),
      ),
    ).animate().fadeIn(duration: 420.ms, delay: (60 + index * 40).ms).slideX(begin: 0.04);
  }
}

class _SkillAvatar extends StatelessWidget {
  const _SkillAvatar({required this.skill, required this.color});

  final SkillModel skill;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final initial = skill.name.isNotEmpty ? skill.name[0].toUpperCase() : '?';

    return Container(
      width: 52.w,
      height: 52.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: color.withOpacity(0.65), width: 2),
        boxShadow: [
          BoxShadow(color: color.withOpacity(0.25), blurRadius: 14, spreadRadius: 0),
        ],
      ),
      child: ClipOval(
        child: ColoredBox(
          color: AppConstants.backgroundColor.withOpacity(0.85),
          child: skill.iconUrl.isNotEmpty
              ? Image.asset(
                  skill.iconUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Center(
                    child: Text(
                      initial,
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w800,
                        color: color,
                      ),
                    ),
                  ),
                )
              : Center(
                  child: Text(
                    initial,
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w800,
                      color: color,
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}

class _AnimatedTrack extends StatelessWidget {
  const _AnimatedTrack({
    required this.value,
    required this.activeColor,
    required this.delay,
  });

  final double value;
  final Color activeColor;
  final Duration delay;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: value),
      duration: AppConstants.longAnimationDuration + const Duration(milliseconds: 200),
      curve: Curves.easeOutCubic,
      builder: (context, v, _) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(99),
          child: SizedBox(
            height: 8.h,
            child: Stack(
              fit: StackFit.expand,
              children: [
                ColoredBox(color: AppConstants.textTertiary.withOpacity(0.12)),
                Align(
                  alignment: Alignment.centerLeft,
                  child: FractionallySizedBox(
                    widthFactor: v.clamp(0.0, 1.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(99),
                        gradient: LinearGradient(
                          colors: [activeColor, AppConstants.secondaryColor.withOpacity(0.85)],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: activeColor.withOpacity(0.35),
                            blurRadius: 10,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    ).animate().shimmer(duration: 1800.ms, delay: delay, color: Colors.white.withOpacity(0.06));
  }
}

class _FocusOrb extends StatelessWidget {
  const _FocusOrb({
    required this.label,
    required this.value,
    required this.caption,
    required this.colors,
  });

  final String label;
  final double value;
  final String caption;
  final List<Color> colors;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: value),
      duration: AppConstants.longAnimationDuration,
      curve: Curves.easeOutCubic,
      builder: (context, v, child) {
        return Container(
          clipBehavior: Clip.antiAlias,
          decoration: AppConstants.depthPanelDecoration(accentColors: colors),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final w = constraints.maxWidth;
              final horizontalPad = (w * 0.055).clamp(8.0, 18.0);
              final ring = (w * 0.30).clamp(34.0, 50.0);
              final gap = (w * 0.028).clamp(6.0, 12.0);
              final stroke = ring < 40 ? 3.0 : 4.0;

              return Padding(
                padding: EdgeInsets.fromLTRB(
                  horizontalPad,
                  18.h,
                  horizontalPad,
                  18.h,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: ring,
                          height: ring,
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              CircularProgressIndicator(
                                value: 1,
                                strokeWidth: stroke,
                                color: AppConstants.textTertiary.withOpacity(0.2),
                              ),
                              CircularProgressIndicator(
                                value: v,
                                strokeWidth: stroke,
                                strokeCap: StrokeCap.round,
                                color: colors.first,
                              ),
                              Center(
                                child: Text(
                                  '${(v * 100).round()}',
                                  style: TextStyle(
                                    fontSize: (ring * 0.26).clamp(10.0, 14.0),
                                    fontWeight: FontWeight.w900,
                                    color: AppConstants.textPrimary,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: gap),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                label,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: (w * 0.055).clamp(11.0, 14.0),
                                  fontWeight: FontWeight.w800,
                                  color: AppConstants.textPrimary,
                                  height: 1.2,
                                ),
                              ),
                              SizedBox(height: 4.h),
                              Text(
                                caption,
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: (w * 0.042).clamp(9.5, 11.5),
                                  height: 1.35,
                                  color: AppConstants.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
