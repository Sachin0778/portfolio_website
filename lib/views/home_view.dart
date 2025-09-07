import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/portfolio_controller.dart';
import '../constants/app_constants.dart';
import '../widgets/navigation_bar.dart';
import '../widgets/hero_section.dart';
import '../widgets/about_section.dart';
import '../widgets/skills_section.dart';
import '../widgets/projects_section.dart';
import '../widgets/experience_section.dart';
import '../widgets/contact_section.dart';
import '../widgets/footer.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PortfolioController>();

    return Scaffold(
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(
              color: AppConstants.primaryColor,
            ),
          );
        }

        return SingleChildScrollView(
          child: Column(
            children: [
              // Navigation Bar
              const CustomNavigationBar(),
              
              // Hero Section
              const HeroSection(),
              
              // About Section
              const AboutSection(),
              
              // Skills Section
              const SkillsSection(),
              
              // Projects Section
              const ProjectsSection(),
              
              // Experience Section
              const ExperienceSection(),
              
              // Contact Section
              const ContactSection(),
              
              // Footer
              const Footer(),
            ],
          ),
        );
      }),
    );
  }
}
