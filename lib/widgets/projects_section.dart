import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../utils/size_extensions.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../controllers/portfolio_controller.dart';
import '../constants/app_constants.dart';
import '../models/project_model.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

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
              'Featured Projects',
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

            // Projects Grid
            AnimationLimiter(
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: MediaQuery.of(context).size.width > AppConstants.tabletBreakpoint ? 2 : 1,
                  crossAxisSpacing: 8.w,
                  mainAxisSpacing: 8.h,
                  // Give cards a bit more height to avoid vertical overflow
                  childAspectRatio: MediaQuery.of(context).size.width > AppConstants.tabletBreakpoint ? 0.9 : 1.1,
                ),
                itemCount: portfolioData.projects.length,
                itemBuilder: (context, index) {
                  final project = portfolioData.projects[index];
                  return AnimationConfiguration.staggeredGrid(
                    position: index,
                    duration: const Duration(milliseconds: 600),
                    columnCount: MediaQuery.of(context).size.width > AppConstants.tabletBreakpoint ? 2 : 1,
                    child: SlideAnimation(
                      verticalOffset: 50.0,
                      child: FadeInAnimation(
                        child: _ProjectCard(project: project),
                      ),
                    ),
                  );
                },
              ),
            ),

            SizedBox(height: 24.h),

            // View All Projects Button
            Center(
              child: OutlinedButton.icon(
                onPressed: () => controller.navigateToSection('projects'),
                icon: Icon(Icons.arrow_forward, size: 20.sp),
                label: Text(
                  'View All Projects',
                  style: TextStyle(fontSize: 16.sp),
                ),
                style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.symmetric(
                    horizontal: 32.w,
                    vertical: 16.h,
                  ),
                  side: const BorderSide(
                    color: AppConstants.primaryColor,
                    width: 2,
                  ),
                ),
              ),
            ).animate().fadeIn(delay: 800.ms).scale(),
          ],
        );
      }),
    );
  }
}

class _ProjectCard extends StatelessWidget {
  final ProjectModel project;

  const _ProjectCard({required this.project});

  @override
  Widget build(BuildContext context) {
    return Container(
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
          // Project Image
          Expanded(
            flex: 3,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(AppConstants.radiusLarge),
                ),
                gradient: AppConstants.primaryGradient,
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(AppConstants.radiusLarge),
                ),
                child: Image.asset(
                  project.imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      decoration: BoxDecoration(
                        gradient: AppConstants.primaryGradient,
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(AppConstants.radiusLarge),
                        ),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.image,
                          size: 48.sp,
                          color: AppConstants.textPrimary,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),

          // Project Content
          Expanded(
            flex: 2,
            child: Padding(
              padding: EdgeInsets.all(AppConstants.paddingLarge.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Project Title
                  Text(
                    project.title,
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: AppConstants.textPrimary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 8.h),

                  // Project Description
                  Flexible(
                    child: Text(
                      project.description,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: AppConstants.textSecondary,
                        height: 1.4,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      softWrap: true,
                    ),
                  ),
                  SizedBox(height: 12.h),

                  // Technologies
                  Wrap(
                    spacing: 6.w,
                    runSpacing: 6.h,
                    children: project.technologies.take(3).map((tech) {
                      return Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.w,
                          vertical: 4.h,
                        ),
                        decoration: BoxDecoration(
                          color: AppConstants.primaryColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(AppConstants.radiusSmall),
                        ),
                        child: Text(
                          tech,
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: AppConstants.primaryColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 12.h),

                  // Action Buttons
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
                            final ok = await launchUrlString(url, mode: LaunchMode.externalApplication);
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
                            style: TextStyle(fontSize: 12.sp),
                          ),
                          style: OutlinedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 8.h),
                            side: BorderSide(
                              color: AppConstants.textTertiary,
                              width: 1,
                            ),
                          ),
                        ),
                      ),
                      if (project.liveUrl != null) ...[
                        SizedBox(width: 8.w),
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () async {
                              final url = project.liveUrl!;
                              if (url.isEmpty) {
                                Get.snackbar('Unavailable', 'No live URL for this project');
                                return;
                              }
                              final ok = await launchUrlString(url, mode: LaunchMode.externalApplication);
                              if (!ok) {
                                Get.snackbar('Failed', 'Could not open live demo');
                              }
                            },
                            icon: FaIcon(
                              FontAwesomeIcons.externalLinkAlt,
                              size: 14.sp,
                            ),
                            label: Text(
                              'Live',
                              style: TextStyle(fontSize: 12.sp),
                            ),
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(vertical: 8.h),
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
    );
  }
}
