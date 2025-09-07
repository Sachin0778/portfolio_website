# Portfolio Website

A stunning, modern portfolio website built with Flutter and GetX. This website showcases your skills, projects, and experience as a Flutter developer.

## Features

- 🎨 **Modern Design**: Beautiful, responsive design with smooth animations
- 📱 **Mobile First**: Fully responsive design that works on all devices
- ⚡ **Fast Performance**: Built with GetX for optimal state management
- 🎭 **Smooth Animations**: Engaging animations using flutter_animate
- 📧 **Contact Form**: Interactive contact form for potential clients
- 🔗 **Social Links**: Easy access to your social media profiles
- 📊 **Skills Showcase**: Visual representation of your technical skills
- 💼 **Project Gallery**: Beautiful project showcase with live demos
- 📈 **Experience Timeline**: Professional work experience display

## Getting Started

### Prerequisites

- Flutter SDK (3.8.1 or higher)
- Dart SDK
- Android Studio / VS Code
- Git

### Installation

1. Clone the repository:
```bash
git clone <your-repo-url>
cd portfolio_website
```

2. Install dependencies:
```bash
flutter pub get
```

3. Run the app:
```bash
flutter run
```

## Customization

### Personal Information

Update your personal information in `lib/services/portfolio_service.dart`:

- Name, title, and bio
- Contact information
- Social media links
- Profile image path
- Resume URL

### Projects

Add your projects in the `_getProjects()` method:

- Project title and description
- Technologies used
- GitHub and live demo URLs
- Project images
- Features list

### Skills

Customize your skills in the `_getSkills()` method:

- Skill name and proficiency level
- Skill category
- Icon and color

### Experience

Update your work experience in the `_getExperiences()` method:

- Company information
- Job title and description
- Duration and location
- Key achievements
- Company logo

## Deployment

### GitHub Pages

1. Build the web version:
```bash
flutter build web
```

2. Push the `build/web` folder to your GitHub Pages repository

3. Enable GitHub Pages in your repository settings

### Netlify

1. Build the web version:
```bash
flutter build web
```

2. Drag and drop the `build/web` folder to Netlify

### Vercel

1. Build the web version:
```bash
flutter build web
```

2. Deploy using Vercel CLI or connect your GitHub repository

## Technologies Used

- **Flutter**: Cross-platform UI framework
- **GetX**: State management and routing
- **Google Fonts**: Typography
- **Font Awesome**: Icons
- **Flutter Animate**: Animations
- **Flutter ScreenUtil**: Responsive design

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Submit a pull request

## License

This project is open source and available under the [MIT License](LICENSE).

## Support

If you have any questions or need help customizing your portfolio, feel free to open an issue or contact me.

---

**Happy Coding! 🚀**