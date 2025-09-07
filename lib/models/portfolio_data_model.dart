import 'project_model.dart';
import 'skill_model.dart';
import 'experience_model.dart';
import 'contact_model.dart';

class PortfolioDataModel {
  final String name;
  final String title;
  final String bio;
  final String profileImage;
  final String location;
  final String email;
  final String phone;
  final String resumeUrl;
  final List<ProjectModel> projects;
  final List<SkillModel> skills;
  final List<ExperienceModel> experiences;
  final List<SocialLink> socialLinks;
  final String aboutText;
  final List<String> services;

  PortfolioDataModel({
    required this.name,
    required this.title,
    required this.bio,
    required this.profileImage,
    required this.location,
    required this.email,
    required this.phone,
    required this.resumeUrl,
    required this.projects,
    required this.skills,
    required this.experiences,
    required this.socialLinks,
    required this.aboutText,
    required this.services,
  });

  factory PortfolioDataModel.fromJson(Map<String, dynamic> json) {
    return PortfolioDataModel(
      name: json['name'] ?? '',
      title: json['title'] ?? '',
      bio: json['bio'] ?? '',
      profileImage: json['profileImage'] ?? '',
      location: json['location'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      resumeUrl: json['resumeUrl'] ?? '',
      projects: (json['projects'] as List<dynamic>?)
          ?.map((e) => ProjectModel.fromJson(e))
          .toList() ?? [],
      skills: (json['skills'] as List<dynamic>?)
          ?.map((e) => SkillModel.fromJson(e))
          .toList() ?? [],
      experiences: (json['experiences'] as List<dynamic>?)
          ?.map((e) => ExperienceModel.fromJson(e))
          .toList() ?? [],
      socialLinks: (json['socialLinks'] as List<dynamic>?)
          ?.map((e) => SocialLink.fromJson(e))
          .toList() ?? [],
      aboutText: json['aboutText'] ?? '',
      services: List<String>.from(json['services'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'title': title,
      'bio': bio,
      'profileImage': profileImage,
      'location': location,
      'email': email,
      'phone': phone,
      'resumeUrl': resumeUrl,
      'projects': projects.map((e) => e.toJson()).toList(),
      'skills': skills.map((e) => e.toJson()).toList(),
      'experiences': experiences.map((e) => e.toJson()).toList(),
      'socialLinks': socialLinks.map((e) => e.toJson()).toList(),
      'aboutText': aboutText,
      'services': services,
    };
  }
}
