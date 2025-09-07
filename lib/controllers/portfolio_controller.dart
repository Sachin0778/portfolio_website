import 'package:get/get.dart';
import '../models/portfolio_data_model.dart';
import '../models/project_model.dart';
import '../models/skill_model.dart';
import '../services/portfolio_service.dart';

class PortfolioController extends GetxController {
  // Observable variables
  var portfolioData = Rxn<PortfolioDataModel>();
  var isLoading = true.obs;
  var selectedProject = Rxn<ProjectModel>();
  var currentSection = 'home'.obs;
  var isDarkMode = true.obs;

  @override
  void onInit() {
    super.onInit();
    loadPortfolioData();
  }

  // Load portfolio data
  void loadPortfolioData() {
    try {
      isLoading.value = true;
      // Simulate API call delay
      Future.delayed(const Duration(seconds: 1), () {
        portfolioData.value = PortfolioService.getPortfolioData();
        isLoading.value = false;
      });
    } catch (e) {
      isLoading.value = false;
      Get.snackbar('Error', 'Failed to load portfolio data: $e');
    }
  }

  // Navigation methods
  void navigateToSection(String section) {
    currentSection.value = section;
  }

  void selectProject(ProjectModel project) {
    selectedProject.value = project;
  }

  void clearSelectedProject() {
    selectedProject.value = null;
  }

  // Theme toggle
  void toggleTheme() {
    isDarkMode.value = !isDarkMode.value;
  }

  // Get filtered projects by category
  List<ProjectModel> getProjectsByCategory(String category) {
    if (portfolioData.value == null) return [];
    return portfolioData.value!.projects
        .where((project) => project.category.toLowerCase() == category.toLowerCase())
        .toList();
  }

  // Get skills by category
  List<SkillModel> getSkillsByCategory(String category) {
    if (portfolioData.value == null) return [];
    return portfolioData.value!.skills
        .where((skill) => skill.category.toLowerCase() == category.toLowerCase())
        .toList();
  }

  // Get all unique skill categories
  List<String> getSkillCategories() {
    if (portfolioData.value == null) return [];
    return portfolioData.value!.skills
        .map((skill) => skill.category)
        .toSet()
        .toList();
  }

  // Get all unique project categories
  List<String> getProjectCategories() {
    if (portfolioData.value == null) return [];
    return portfolioData.value!.projects
        .map((project) => project.category)
        .toSet()
        .toList();
  }

  // Search projects
  List<ProjectModel> searchProjects(String query) {
    if (portfolioData.value == null || query.isEmpty) return [];
    return portfolioData.value!.projects
        .where((project) =>
            project.title.toLowerCase().contains(query.toLowerCase()) ||
            project.description.toLowerCase().contains(query.toLowerCase()) ||
            project.technologies.any((tech) =>
                tech.toLowerCase().contains(query.toLowerCase())))
        .toList();
  }

  // Get recent projects (last 3)
  List<ProjectModel> getRecentProjects() {
    if (portfolioData.value == null) return [];
    final projects = List<ProjectModel>.from(portfolioData.value!.projects);
    projects.sort((a, b) => b.dateCreated.compareTo(a.dateCreated));
    return projects.take(3).toList();
  }

  // Get featured projects (you can customize this logic)
  List<ProjectModel> getFeaturedProjects() {
    if (portfolioData.value == null) return [];
    return portfolioData.value!.projects
        .where((project) => project.liveUrl != null)
        .toList();
  }
}
