import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../constants/app_constants.dart';
import '../controllers/portfolio_controller.dart';
import '../models/project_model.dart';
import '../utils/size_extensions.dart';
import 'section_header.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

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
              eyebrow: 'Portfolio',
              title: 'Featured projects',
              subtitle:
                  'Selected work showcasing product thinking, craft, and technical depth.',
            ),
            SizedBox(height: 28.h),
            AnimationLimiter(
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount:
                      MediaQuery.of(context).size.width > AppConstants.tabletBreakpoint ? 2 : 1,
                  crossAxisSpacing: 18.w,
                  mainAxisSpacing: 18.h,
                  // Lower ratio = taller cells (more room for text + buttons; avoids bottom overflow).
                  childAspectRatio:
                      MediaQuery.of(context).size.width > AppConstants.tabletBreakpoint ? 0.72 : 0.68,
                ),
                itemCount: portfolioData.projects.length,
                itemBuilder: (context, index) {
                  final project = portfolioData.projects[index];
                  return AnimationConfiguration.staggeredGrid(
                    position: index,
                    duration: const Duration(milliseconds: 560),
                    columnCount:
                        MediaQuery.of(context).size.width > AppConstants.tabletBreakpoint ? 2 : 1,
                    child: SlideAnimation(
                      verticalOffset: 36.0,
                      child: FadeInAnimation(
                        child: _ProjectCard(project: project),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 28.h),
            Center(
              child: OutlinedButton.icon(
                onPressed: () => controller.navigateToSection('projects'),
                icon: Icon(Icons.arrow_forward_rounded, size: 20.sp),
                label: Text(
                  'Explore all projects',
                  style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w700),
                ),
                style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.symmetric(
                    horizontal: 28.w,
                    vertical: 14.h,
                  ),
                  side: BorderSide(color: AppConstants.secondaryColor.withOpacity(0.55)),
                  foregroundColor: AppConstants.secondaryColor,
                ),
              ),
            ).animate().fadeIn(delay: 320.ms).scale(begin: const Offset(0.96, 0.96)),
          ],
        );
      }),
    );
  }
}

class _ProjectCard extends StatefulWidget {
  const _ProjectCard({required this.project});

  final ProjectModel project;

  @override
  State<_ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<_ProjectCard> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    final project = widget.project;
    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: AnimatedContainer(
        duration: AppConstants.animationDuration,
        curve: Curves.easeOutCubic,
        clipBehavior: Clip.antiAlias,
        decoration: AppConstants.depthPanelDecoration(
          accentColors: [AppConstants.primaryColor, AppConstants.secondaryColor],
          borderRadius: AppConstants.radiusLarge,
          boxShadow: [
            BoxShadow(
              color: AppConstants.primaryColor.withOpacity(_hover ? 0.14 : 0.08),
              blurRadius: _hover ? 36 : 22,
              offset: Offset(0, _hover ? 18 : 12),
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
        child: Transform.translate(
          offset: Offset(0, _hover ? -4 : 0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(AppConstants.radiusLarge),
            child: Material(
              color: Colors.transparent,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 3,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.asset(
                          project.imageUrl,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              decoration: BoxDecoration(
                                gradient: AppConstants.primaryGradient,
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.image_not_supported_outlined,
                                  size: 48.sp,
                                  color: AppConstants.textPrimary.withOpacity(0.85),
                                ),
                              ),
                            );
                          },
                        ),
                        Positioned.fill(
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.transparent,
                                  AppConstants.backgroundColor.withOpacity(0.1),
                                  AppConstants.backgroundColor.withOpacity(0.85),
                                ],
                                stops: const [0.35, 0.72, 1.0],
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 12.w,
                          bottom: 12.h,
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                            decoration: BoxDecoration(
                              color: AppConstants.backgroundColor.withOpacity(0.55),
                              borderRadius: BorderRadius.circular(999),
                              border: Border.all(
                                color: AppConstants.secondaryColor.withOpacity(0.35),
                              ),
                            ),
                            child: Text(
                              project.category,
                              style: TextStyle(
                                fontSize: 11.sp,
                                fontWeight: FontWeight.w700,
                                color: AppConstants.secondaryColor,
                                letterSpacing: 0.3,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: EdgeInsets.all(AppConstants.paddingMedium.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: SingleChildScrollView(
                              physics: const ClampingScrollPhysics(),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    project.title,
                                    style: TextStyle(
                                      fontSize: 17.sp,
                                      fontWeight: FontWeight.w800,
                                      letterSpacing: -0.3,
                                      color: AppConstants.textPrimary,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(height: 8.h),
                                  Text(
                                    project.description,
                                    style: TextStyle(
                                      fontSize: 13.sp,
                                      color: AppConstants.textSecondary,
                                      height: 1.45,
                                    ),
                                    maxLines: 4,
                                    overflow: TextOverflow.ellipsis,
                                    softWrap: true,
                                  ),
                                  SizedBox(height: 10.h),
                                  Wrap(
                                    spacing: 6.w,
                                    runSpacing: 6.h,
                                    children: project.technologies.take(3).map((tech) {
                                      return Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 10.w,
                                          vertical: 5.h,
                                        ),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(999),
                                          border: Border.all(
                                            color: AppConstants.secondaryColor.withOpacity(0.22),
                                          ),
                                          color: AppConstants.secondaryColor.withOpacity(0.06),
                                        ),
                                        child: Text(
                                          tech,
                                          style: TextStyle(
                                            fontSize: 11.sp,
                                            color: AppConstants.secondaryColor,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 10.h),
                          Row(
                            children: [
                              Expanded(
                                child: OutlinedButton.icon(
                                  onPressed: () async {
                                    final url = project.githubUrl;
                                    if (url.isEmpty) {
                                      Get.snackbar('Unavailable', 'No GitHub URL for this project');
                                      return;
                                    }
                                    final ok =
                                        await launchUrlString(url, mode: LaunchMode.externalApplication);
                                    if (!ok) {
                                      Get.snackbar('Failed', 'Could not open GitHub');
                                    }
                                  },
                                  icon: FaIcon(
                                    FontAwesomeIcons.github,
                                    size: 14.sp,
                                  ),
                                  label: Text(
                                    'Code',
                                    style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w600),
                                  ),
                                  style: OutlinedButton.styleFrom(
                                    padding: EdgeInsets.symmetric(vertical: 10.h),
                                    side: BorderSide(
                                      color: AppConstants.textTertiary.withOpacity(0.45),
                                    ),
                                    foregroundColor: AppConstants.textSecondary,
                                  ),
                                ),
                              ),
                              if (project.liveUrl != null) ...[
                                SizedBox(width: 10.w),
                                Expanded(
                                  child: FilledButton.icon(
                                    onPressed: () async {
                                      final url = project.liveUrl!;
                                      if (url.isEmpty) {
                                        Get.snackbar('Unavailable', 'No live URL for this project');
                                        return;
                                      }
                                      final ok = await launchUrlString(
                                        url,
                                        mode: LaunchMode.externalApplication,
                                      );
                                      if (!ok) {
                                        Get.snackbar('Failed', 'Could not open live demo');
                                      }
                                    },
                                    icon: FaIcon(
                                      FontAwesomeIcons.upRightFromSquare,
                                      size: 13.sp,
                                    ),
                                    label: Text(
                                      'Live',
                                      style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w700),
                                    ),
                                    style: FilledButton.styleFrom(
                                      padding: EdgeInsets.symmetric(vertical: 10.h),
                                      backgroundColor: AppConstants.secondaryColor,
                                      foregroundColor: AppConstants.backgroundColor,
                                    ),
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ],
                      ),
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
