class ExperienceModel {
  final String id;
  final String company;
  final String position;
  final String description;
  final String location;
  final DateTime startDate;
  final DateTime? endDate;
  final bool isCurrent;
  final List<String> achievements;
  final String companyLogo;

  ExperienceModel({
    required this.id,
    required this.company,
    required this.position,
    required this.description,
    required this.location,
    required this.startDate,
    this.endDate,
    required this.isCurrent,
    required this.achievements,
    required this.companyLogo,
  });

  factory ExperienceModel.fromJson(Map<String, dynamic> json) {
    return ExperienceModel(
      id: json['id'] ?? '',
      company: json['company'] ?? '',
      position: json['position'] ?? '',
      description: json['description'] ?? '',
      location: json['location'] ?? '',
      startDate: DateTime.parse(json['startDate'] ?? DateTime.now().toIso8601String()),
      endDate: json['endDate'] != null ? DateTime.parse(json['endDate']) : null,
      isCurrent: json['isCurrent'] ?? false,
      achievements: List<String>.from(json['achievements'] ?? []),
      companyLogo: json['companyLogo'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'company': company,
      'position': position,
      'description': description,
      'location': location,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate?.toIso8601String(),
      'isCurrent': isCurrent,
      'achievements': achievements,
      'companyLogo': companyLogo,
    };
  }
}
