import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/app_constants.dart';
import '../controllers/portfolio_controller.dart';
import '../widgets/about_section.dart';
import '../widgets/contact_section.dart';
import '../widgets/experience_section.dart';
import '../widgets/footer.dart';
import '../widgets/hero_section.dart';
import '../widgets/navigation_bar.dart';
import '../widgets/portfolio_mesh_background.dart';
import '../widgets/projects_section.dart';
import '../widgets/skills_section.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PortfolioController>();

    return Scaffold(
      body: Obx(() {
        if (controller.isLoading.value) {
          return Stack(
            fit: StackFit.expand,
            children: [
              const PortfolioMeshBackground(),
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: 40,
                      height: 40,
                      child: CircularProgressIndicator(
                        strokeWidth: 3,
                        color: AppConstants.secondaryColor,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Loading portfolio…',
                      style: TextStyle(
                        color: AppConstants.textSecondary,
                        letterSpacing: 0.3,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        }

        return Stack(
          fit: StackFit.expand,
          children: [
            const PortfolioMeshBackground(),
            SelectionArea(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics(),
                ),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: AppConstants.contentMaxWidth),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: const [
                          CustomNavigationBar(),
                          HeroSection(),
                          AboutSection(),
                          SkillsSection(),
                          ProjectsSection(),
                          ExperienceSection(),
                          ContactSection(),
                          Footer(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
