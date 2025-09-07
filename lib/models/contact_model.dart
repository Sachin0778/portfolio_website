class ContactModel {
  final String name;
  final String email;
  final String subject;
  final String message;
  final DateTime timestamp;

  ContactModel({
    required this.name,
    required this.email,
    required this.subject,
    required this.message,
    required this.timestamp,
  });

  factory ContactModel.fromJson(Map<String, dynamic> json) {
    return ContactModel(
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      subject: json['subject'] ?? '',
      message: json['message'] ?? '',
      timestamp: DateTime.parse(json['timestamp'] ?? DateTime.now().toIso8601String()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'subject': subject,
      'message': message,
      'timestamp': timestamp.toIso8601String(),
    };
  }
}

class SocialLink {
  final String platform;
  final String url;
  final String icon;
  final String color;

  SocialLink({
    required this.platform,
    required this.url,
    required this.icon,
    required this.color,
  });

  factory SocialLink.fromJson(Map<String, dynamic> json) {
    return SocialLink(
      platform: json['platform'] ?? '',
      url: json['url'] ?? '',
      icon: json['icon'] ?? '',
      color: json['color'] ?? '#000000',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'platform': platform,
      'url': url,
      'icon': icon,
      'color': color,
    };
  }
}
