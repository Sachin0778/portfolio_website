class SkillModel {
  final String name;
  final double proficiency; // 0.0 to 1.0
  final String category;
  final String iconUrl;
  final String color;

  SkillModel({
    required this.name,
    required this.proficiency,
    required this.category,
    required this.iconUrl,
    required this.color,
  });

  factory SkillModel.fromJson(Map<String, dynamic> json) {
    return SkillModel(
      name: json['name'] ?? '',
      proficiency: (json['proficiency'] ?? 0.0).toDouble(),
      category: json['category'] ?? '',
      iconUrl: json['iconUrl'] ?? '',
      color: json['color'] ?? '#000000',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'proficiency': proficiency,
      'category': category,
      'iconUrl': iconUrl,
      'color': color,
    };
  }
}
