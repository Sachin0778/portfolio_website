class ProjectModel {
  final String id;
  final String title;
  final String description;
  final String longDescription;
  final String imageUrl;
  final List<String> technologies;
  final String githubUrl;
  final String? liveUrl;
  final String category;
  final DateTime dateCreated;
  final List<String> features;

  ProjectModel({
    required this.id,
    required this.title,
    required this.description,
    required this.longDescription,
    required this.imageUrl,
    required this.technologies,
    required this.githubUrl,
    this.liveUrl,
    required this.category,
    required this.dateCreated,
    required this.features,
  });

  factory ProjectModel.fromJson(Map<String, dynamic> json) {
    return ProjectModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      longDescription: json['longDescription'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      technologies: List<String>.from(json['technologies'] ?? []),
      githubUrl: json['githubUrl'] ?? '',
      liveUrl: json['liveUrl'],
      category: json['category'] ?? '',
      dateCreated: DateTime.parse(json['dateCreated'] ?? DateTime.now().toIso8601String()),
      features: List<String>.from(json['features'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'longDescription': longDescription,
      'imageUrl': imageUrl,
      'technologies': technologies,
      'githubUrl': githubUrl,
      'liveUrl': liveUrl,
      'category': category,
      'dateCreated': dateCreated.toIso8601String(),
      'features': features,
    };
  }
}
