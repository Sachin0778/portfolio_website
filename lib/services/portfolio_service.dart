import '../models/portfolio_data_model.dart';
import '../models/project_model.dart';
import '../models/skill_model.dart';
import '../models/experience_model.dart';
import '../models/contact_model.dart';

class PortfolioService {
  static PortfolioDataModel getPortfolioData() {
    return PortfolioDataModel(
      name: 'SACHIN SHIRAKE',
      title: 'Software Developer • Flutter | Java | APIs',
      bio: 'Experienced Software Developer focused on responsive, high‑performance apps. Skilled in cross‑platform Flutter, Java backends, and API integration; passionate about scalable, user‑friendly solutions.',
      profileImage: 'assets/images/profile.jpg',
      location: 'Hubli, Karnataka',
      email: 'sachinshirake961@gmail.com',
      phone: '7815968632',
      resumeUrl: 'https://linkedin.com/in/sachin-shirake-4a977a200',
      aboutText: '''
I'm a passionate Flutter developer with over 2 years of experience in mobile app development. 
I specialize in creating beautiful, performant, and user-friendly applications that provide exceptional user experiences.

My journey in mobile development started with a curiosity about how apps work, and it has evolved into a deep passion for creating innovative solutions. I love working with Flutter because it allows me to build apps for both iOS and Android with a single codebase, ensuring consistency and efficiency.

When I'm not coding, you can find me exploring new technologies, contributing to open-source projects, or sharing my knowledge with the developer community through blog posts and tutorials.
      ''',
      services: [
        'Flutter Mobile & Web Apps',
        'REST API Integration',
        'Clean Architecture & MVVM',
        'CI/CD & Store Deployment',
        'Java Spring Boot Backends',
      ],
      projects: _getProjects(),
      skills: _getSkills(),
      experiences: _getExperiences(),
      socialLinks: _getSocialLinks(),
    );
  }

  static List<ProjectModel> _getProjects() {
    return [
      ProjectModel(
        id: '1',
        title: 'E-Commerce Mobile App',
        description: 'A full-featured e-commerce app with payment integration, user authentication, and real-time updates.',
        longDescription: '''
This comprehensive e-commerce application was built using Flutter and Firebase. 
It features a modern UI design, secure payment processing, real-time inventory updates, 
and a robust admin panel. The app supports multiple payment methods and includes 
features like wishlist, cart management, order tracking, and push notifications.
        ''',
        imageUrl: 'assets/images/project1.jpg',
        technologies: ['Flutter', 'Firebase', 'Stripe', 'Provider', 'Dart'],
        githubUrl: 'https://github.com/yourusername/ecommerce-app',
        liveUrl: 'https://play.google.com/store/apps/details?id=com.example.ecommerce',
        category: 'Mobile App',
        dateCreated: DateTime(2024, 1, 15),
        features: [
          'User Authentication & Authorization',
          'Product Catalog with Search & Filter',
          'Shopping Cart & Wishlist',
          'Secure Payment Processing',
          'Order Tracking & History',
          'Push Notifications',
          'Admin Dashboard',
          'Real-time Inventory Updates',
        ],
      ),
      ProjectModel(
        id: '2',
        title: 'Task Management App',
        description: 'A productivity app for managing tasks, projects, and team collaboration with real-time synchronization.',
        longDescription: '''
A comprehensive task management solution designed to boost productivity and team collaboration. 
The app features intuitive task creation, project organization, team member assignment, 
and real-time synchronization across all devices. Built with clean architecture principles 
and optimized for performance.
        ''',
        imageUrl: 'assets/images/project2.jpg',
        technologies: ['Flutter', 'GetX', 'SQLite', 'REST API', 'WebSocket'],
        githubUrl: 'https://github.com/yourusername/task-manager',
        liveUrl: 'https://apps.apple.com/app/task-manager/id123456789',
        category: 'Productivity',
        dateCreated: DateTime(2023, 11, 20),
        features: [
          'Task Creation & Management',
          'Project Organization',
          'Team Collaboration',
          'Real-time Synchronization',
          'Due Date Reminders',
          'Progress Tracking',
          'File Attachments',
          'Custom Categories & Tags',
        ],
      ),
      ProjectModel(
        id: '3',
        title: 'Weather Forecast App',
        description: 'A beautiful weather app with detailed forecasts, location-based services, and interactive maps.',
        longDescription: '''
An elegant weather application that provides accurate weather forecasts and detailed meteorological data. 
The app features location-based weather updates, interactive weather maps, detailed forecasts, 
and beautiful animations. Built with a focus on user experience and performance optimization.
        ''',
        imageUrl: 'assets/images/project3.jpg',
        technologies: ['Flutter', 'OpenWeather API', 'Google Maps', 'Location Services', 'Animations'],
        githubUrl: 'https://github.com/yourusername/weather-app',
        liveUrl: 'https://play.google.com/store/apps/details?id=com.example.weather',
        category: 'Utility',
        dateCreated: DateTime(2023, 8, 10),
        features: [
          'Current Weather & Forecasts',
          'Location-based Updates',
          'Interactive Weather Maps',
          'Detailed Weather Data',
          'Beautiful Animations',
          'Offline Support',
          'Multiple Location Support',
          'Weather Alerts & Notifications',
        ],
      ),
    ];
  }

  static List<SkillModel> _getSkills() {
    return [
      SkillModel(name: 'Flutter', proficiency: 0.95, category: 'Flutter Development', iconUrl: 'assets/icons/flutter.png', color: '#02569B'),
      SkillModel(name: 'Dart', proficiency: 0.90, category: 'Flutter Development', iconUrl: 'assets/icons/dart.png', color: '#0175C2'),
      SkillModel(name: 'REST API', proficiency: 0.90, category: 'Backend', iconUrl: 'assets/icons/api.png', color: '#4CAF50'),
      SkillModel(name: 'GetX', proficiency: 0.90, category: 'State Management', iconUrl: 'assets/icons/getx.png', color: '#8B5CF6'),
      SkillModel(name: 'Provider', proficiency: 0.85, category: 'State Management', iconUrl: 'assets/icons/provider.png', color: '#FF6B6B'),
      SkillModel(name: 'Bloc/Cubit', proficiency: 0.80, category: 'State Management', iconUrl: 'assets/icons/bloc.png', color: '#2196F3'),
      SkillModel(name: 'Java (Core, OOPs, Collections)', proficiency: 0.80, category: 'Java Technologies', iconUrl: 'assets/icons/java.png', color: '#007396'),
      SkillModel(name: 'Spring Boot', proficiency: 0.75, category: 'Java Technologies', iconUrl: 'assets/icons/spring.png', color: '#6DB33F'),
      SkillModel(name: 'Hibernate', proficiency: 0.70, category: 'Java Technologies', iconUrl: 'assets/icons/hibernate.png', color: '#59666C'),
      SkillModel(name: 'SQL / MySQL', proficiency: 0.80, category: 'Database', iconUrl: 'assets/icons/sql.png', color: '#003B57'),
      SkillModel(name: 'HTML/CSS/JS', proficiency: 0.70, category: 'Web Development', iconUrl: 'assets/icons/web.png', color: '#F7DF1E'),
      SkillModel(name: 'Python', proficiency: 0.60, category: 'Programming Languages', iconUrl: 'assets/icons/python.png', color: '#3776AB'),
    ];
  }

  static List<ExperienceModel> _getExperiences() {
    return [
      ExperienceModel(
        id: '1',
        company: 'Applaunch.io',
        position: 'Flutter Developer',
        description: 'Built a Tipp app and responsive Flutter Web admin dashboard; ensured modular, scalable architecture.',
        location: 'Bengaluru, Karnataka',
        startDate: DateTime(2024, 7, 1),
        isCurrent: true,
        achievements: [
          'Initiated and developed a Tipp app from scratch (20+ sports betting).',
          'Implemented scalable state management using GetX, Bloc, Provider, and Cubit.',
          'Designed clean, modular architecture with maintainability in mind.',
          'Built responsive admin dashboard for Flutter Web for efficient ops.',
          'Defined API structures and integrated REST APIs for dynamic content.',
          'Ensured UI/UX consistency and responsiveness across Android, iOS, Web.',
        ],
        companyLogo: 'assets/images/company1.png',
      ),
      ExperienceModel(
        id: '2',
        company: 'Chromosis Technologies Pvt. Ltd.',
        position: 'Flutter Developer',
        description: 'Delivered production apps, integrated payments/notifications, and contributed to backend tools.',
        location: 'Hubli, Karnataka',
        startDate: DateTime(2022, 2, 1),
        endDate: DateTime(2024, 7, 1),
        isCurrent: false,
        achievements: [
          'Developed and launched 5+ Flutter apps (Android/iOS) using MVVM & Provider.',
          'Integrated Razorpay, Firebase Messaging, and Braze for payments, push, deep links.',
          'Worked on localization, real-time messaging, CI/CD, and store deployment.',
          'Mentored junior developers; improved reviews and processes.',
          'Shipped 4–5 production apps to App Store/Play Store; TestFlight distribution.',
          'Built backend tools with Spring Boot and Hibernate; designed RESTful APIs.',
          'Implemented CRUD, authentication; integrated MySQL; practiced OOPs, Collections, Exception Handling, Multithreading.',
          'Streamlined backend service communication with utility modules.',
        ],
        companyLogo: 'assets/images/company2.png',
      ),
    ];
  }

  static List<SocialLink> _getSocialLinks() {
    return [
      SocialLink(
        platform: 'GitHub',
        url: 'https://github.com/sachinshirake',
        icon: 'assets/icons/github.png',
        color: '#333333',
      ),
      SocialLink(
        platform: 'LinkedIn',
        url: 'https://linkedin.com/in/sachin-shirake-4a977a200',
        icon: 'assets/icons/linkedin.png',
        color: '#0077B5',
      ),
      SocialLink(
        platform: 'Email',
        url: 'mailto:sachinshirake961@gmail.com',
        icon: 'assets/icons/email.png',
        color: '#EA4335',
      ),
      SocialLink(
        platform: 'Medium',
        url: 'https://medium.com/@sachinshirake',
        icon: 'assets/icons/medium.png',
        color: '#00AB6C',
      ),
    ];
  }
}
